import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/providers/ev_providers.dart';

enum CalendarViewType { day, week, month }

const List<String> days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];
const List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

class EventCalendarPage extends ConsumerStatefulWidget {
  final int id;
  final CalendarViewType currentView;

  const EventCalendarPage({
    super.key,
    required this.id,
    required this.currentView,
  });

  @override
  _EventCalendarPage createState() => _EventCalendarPage();
}

class _EventCalendarPage extends ConsumerState<EventCalendarPage> {
  @override
  Widget build(BuildContext context) {
    final controller = EventController();
    final constraintsAsync = ref.watch(
      localConstraintsStreamProvider(widget.id),
    );

    final headerStyle = HeaderStyle(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      leftIconConfig: IconDataConfig(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      rightIconConfig: IconDataConfig(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );

    return constraintsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (constraints) {
        final List<CalendarEventData> events = [];

        for (final constraint in constraints) {
          events.addAll(
            splitMultiDayEvent(
              constraintId: constraint.id,
              start: constraint.startTime,
              end: constraint.endTime,
              minCharge: (constraint.targetPercentage * 100).round(),
            ),
          );
        }

        for (final e in events) {
          controller.add(e);
        }

        final calendarView = switch (widget.currentView) {
          CalendarViewType.day => DayView(
            scrollOffset: (DateTime.now().hour - 5) * 60 * 0.6,
            backgroundColor: Theme.of(context).colorScheme.surface,
            headerStyle: headerStyle,
            liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
              color: Theme.of(context).colorScheme.primary,
            ),
            onEventTap: _handleEventTap,
            heightPerMinute: 0.6,
            dateStringBuilder: (date, {secondaryDate}) {
              final dayString = days[date.weekday - 1];
              final monthString = months[date.month - 1];

              final string = "$dayString, $monthString ${date.day}";

              if (date.day == DateTime.now().day &&
                  date.month == DateTime.now().month) {
                return "Today - $string";
              }
              if (date.day == DateTime.now().add(Duration(days: 1)).day &&
                  date.month == DateTime.now().add(Duration(days: 1)).month) {
                return "Tomorrow - $string";
              }

              return string;
            },
            keepScrollOffset: true,
            timeLineOffset: 9,
            timeLineBuilder:
                (date) => Text(
                  "${date.hour}:${date.minute.toStringAsFixed(0).padLeft(2, "0")}",
                  textAlign: TextAlign.center,
                ),
          ),
          CalendarViewType.week => WeekView(
            scrollOffset: (DateTime.now().hour - 5) * 60 * 0.6,
            keepScrollOffset: true,
            headerStyle: headerStyle,
            heightPerMinute: 0.6,
            backgroundColor: Theme.of(context).colorScheme.surface,
            liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
              color: Theme.of(context).colorScheme.primary,
            ),
            onEventTap: _handleEventTap,
            timeLineOffset: 9,
            timeLineBuilder:
                (date) => Text(
                  "${date.hour}:${date.minute.toStringAsFixed(0).padLeft(2, "0")}",
                  textAlign: TextAlign.center,
                ),
          ),
          CalendarViewType.month => MonthView(
            borderColor: Theme.of(context).dividerColor,
            borderSize: 0,
            headerStyle: headerStyle,
            onEventTap: (event, date) => _handleEventTap([event], date),
          ),
        };

        return CalendarControllerProvider(
          controller: controller,
          child: Scaffold(
            floatingActionButton: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  shape: CircleBorder(),
                  foregroundColor:
                      Theme.of(context).colorScheme.onSecondaryContainer,
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  onPressed: () => context.push("/ev/${widget.id}/details"),
                  heroTag: null,
                  child: Icon(Icons.info_outline),
                ),
                FloatingActionButton.extended(
                  label: Text("New"),
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  onPressed: () async {
                    await showDialog<List<CalendarEventData>>(
                      context: context,
                      builder:
                          (_) => EvConstraintDialog(
                            groupId: const Uuid().v4(),
                            evId: widget.id,
                            title: "New Charging Window",
                          ),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            body: Column(children: [Expanded(child: calendarView)]),
          ),
        );
      },
    );
  }

  void _handleEventTap(List<CalendarEventData> events, DateTime date) {
    final tappedEvent = events.first;
    final constraintId = int.tryParse(tappedEvent.description ?? '');
    if (constraintId == null) return;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Edit or Delete Constraint"),
            content: const Text(
              "What would you like to do with this constraint?",
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  final backendService = BackendService();
                  try {
                    await backendService.deleteConstraint(constraintId);
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Constraint deleted.")),
                    );
                  } catch (e) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Delete failed: $e")),
                    );
                  }
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              TextButton(
                onPressed: () async {
                  context.pop(); // close dialog first
                  ref.invalidate(constraintByIdProvider(constraintId));
                  final constraint = await ref.read(
                    constraintByIdProvider(constraintId).future,
                  );
                  if (constraint == null) return;

                  await showDialog(
                    context: context,
                    builder:
                        (_) => EvConstraintDialog(
                          groupId: tappedEvent.description ?? const Uuid().v4(),
                          evId: widget.id,
                          initialConstraintId: constraint.id,
                          initialStart: constraint.startTime,
                          initialEnd: constraint.endTime,
                          initialPercentage: constraint.targetPercentage * 100,
                          title: 'Edit Charging Window',
                        ),
                  );
                },
                child: const Text("Edit"),
              ),
            ],
          ),
    );
  }

  List<CalendarEventData> splitMultiDayEvent({
    required int constraintId,
    required DateTime start,
    required DateTime end,
    required int minCharge,
  }) {
    final List<CalendarEventData> events = [];
    DateTime current = DateTime(start.year, start.month, start.day);
    DateTime finalDay = DateTime(end.year, end.month, end.day);

    while (!current.isAfter(finalDay)) {
      final isStartDay = current.isAtSameMomentAs(
        DateTime(start.year, start.month, start.day),
      );
      final isEndDay = current.isAtSameMomentAs(
        DateTime(end.year, end.month, end.day),
      );

      final dayStart =
          isStartDay
              ? start
              : DateTime(current.year, current.month, current.day, 0, 0);
      final dayEnd =
          isEndDay
              ? end
              : DateTime(current.year, current.month, current.day, 23, 59);

      events.add(
        CalendarEventData(
          title: "Min charge: $minCharge%",
          description: constraintId.toString(),
          date: current,
          startTime: dayStart,
          endTime: dayEnd,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
      );

      current = current.add(const Duration(days: 1));
    }

    return events;
  }
}

class EvConstraintDialog extends StatefulWidget {
  final String groupId;
  final int evId;
  final int? initialConstraintId;
  final DateTime? initialStart;
  final DateTime? initialEnd;
  final double? initialPercentage;
  final String? title;
  const EvConstraintDialog({
    required this.groupId,
    required this.evId,
    this.initialConstraintId,
    this.initialStart,
    this.initialEnd,
    this.initialPercentage,
    this.title,
    super.key,
  });

  @override
  EvConstraintDialogState createState() => EvConstraintDialogState();
}

class EvConstraintDialogState extends State<EvConstraintDialog> {
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now().add(const Duration(hours: 1));
  double _minCharge = 50;
  int? _constraintId;
  final _backendService = BackendService();

  @override
  void initState() {
    super.initState();
    _start = widget.initialStart ?? DateTime.now();
    _end = widget.initialEnd ?? _start.add(const Duration(hours: 1));
    _minCharge = widget.initialPercentage ?? 50;
    _constraintId = widget.initialConstraintId;
  }

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? _start : _end,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStart ? _start : _end),
    );

    if (time == null) return;

    final selected = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      if (isStart) {
        _start = selected;
        if (_end.isBefore(_start)) {
          _end = _start.add(const Duration(hours: 1));
        }
      } else {
        _end = selected;
      }
    });
  }

  String _getDateString(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.add(const Duration(days: 1)).day) {
      return "Tomorrow";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  DateTime _roundDownToNearestHour(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour);
  }

  DateTime _roundUpToNearestHour(DateTime dateTime) {
    return _roundDownToNearestHour(dateTime).add(const Duration(hours: 1));
  }

  // Helper function to adjust a DateTime by a given number of hours
  DateTime _adjustHour(DateTime dateTime, int hours) {
    if (dateTime.minute != 0) {
      return hours > 0
          ? _roundUpToNearestHour(dateTime)
          : _roundDownToNearestHour(dateTime);
    }
    return dateTime.add(Duration(hours: hours));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? "Constraint"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _selectDateTime(context, true),
                  child: Column(
                    children: [
                      Text(
                        "Start:",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        "${_getDateString(_start)}\n${_start.hour}:${_start.minute.toString().padLeft(2, '0')}",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed:
                                () => setState(() {
                                  _start = _adjustHour(_start, -1);
                                }),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed:
                                () => setState(() {
                                  _start = _adjustHour(_start, 1);
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    size: 40,
                  ),
                ),
                InkWell(
                  onTap: () => _selectDateTime(context, false),
                  child: Column(
                    children: [
                      Text(
                        "End:",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        "${_getDateString(_end)}\n${_end.hour}:${_end.minute.toString().padLeft(2, '0')}",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed:
                                () => setState(() {
                                  _end = _adjustHour(_end, -1);
                                }),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed:
                                () => setState(() {
                                  _end = _adjustHour(_end, 1);
                                }),
                          ),
                        ],
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.calendar_today),
                      //   onPressed: () => _selectDateTime(context, false),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 12),
            Text(
              "Minimum Charge Level:",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text("${_minCharge.toInt()}%"),
            Slider(
              value: _minCharge,
              min: 0,
              max: 100,
              divisions: 100,
              label: _minCharge.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _minCharge = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed:
              _end.isAfter(_start) && _end.isAfter(DateTime.now())
                  ? () async {
                    try {
                      await _backendService.postConstraint(
                        id: _constraintId,
                        evId: widget.evId,
                        startTime: _start,
                        deadline: _end,
                        targetPercentage: _minCharge.toDouble() / 100,
                      );

                      final events = splitMultiDayEvent(
                        start: _start,
                        end: _end,
                        minCharge: _minCharge.toInt(),
                        groupId: widget.groupId,
                      );
                      Navigator.pop(context, events);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add constraint: $e')),
                      );
                    }
                  }
                  : null,
          child: const Text('Save Event'),
        ),
      ],
    );
  }

  final uuid = Uuid();

  List<CalendarEventData> splitMultiDayEvent({
    required DateTime start,
    required DateTime end,
    required int minCharge,
    required String groupId,
  }) {
    List<CalendarEventData> events = [];

    DateTime current = DateTime(start.year, start.month, start.day);
    DateTime finalDay = DateTime(end.year, end.month, end.day);

    while (!current.isAfter(finalDay)) {
      final isStartDay =
          current.year == start.year &&
          current.month == start.month &&
          current.day == start.day;
      final isEndDay =
          current.year == end.year &&
          current.month == end.month &&
          current.day == end.day;

      DateTime dayStart =
          isStartDay
              ? start
              : DateTime(current.year, current.month, current.day, 0, 0);

      DateTime dayEnd =
          isEndDay
              ? end
              : DateTime(current.year, current.month, current.day, 23, 59);

      events.add(
        CalendarEventData(
          title: "(Min charge: $minCharge%)",
          description: groupId,
          date: current,
          startTime: dayStart,
          endTime: dayEnd,
        ),
      );

      current = current.add(const Duration(days: 1));
    }

    return events;
  }
}

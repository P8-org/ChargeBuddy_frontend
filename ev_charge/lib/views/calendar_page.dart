import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:uuid/uuid.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/providers/ev_providers.dart';

enum CalendarViewType { day, week, month }

class EventCalendarPage extends ConsumerStatefulWidget {
  final int id;

  const EventCalendarPage({Key? key, required this.id}) : super(key: key);

  @override
  _EventCalendarPage createState() => _EventCalendarPage();
}

class _EventCalendarPage extends ConsumerState<EventCalendarPage> {
  CalendarViewType _currentView = CalendarViewType.day;

  @override
  Widget build(BuildContext context) {
    final constraintsAsync = ref.watch(
      localConstraintsStreamProvider(widget.id),
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
              end: constraint.chargedBy,
              minCharge: (constraint.targetPercentage * 100).round(),
            ),
          );
        }

        final controller = EventController();
        for (final e in events) {
          controller.add(e);
        }

        final calendarView = switch (_currentView) {
          CalendarViewType.day => DayView(onEventTap: _handleEventTap),
          CalendarViewType.week => WeekView(onEventTap: _handleEventTap),
          CalendarViewType.month => MonthView(),
        };

        return CalendarControllerProvider(
          controller: controller,
          child: Scaffold(
            body: Column(
              children: [
                Expanded(child: calendarView),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        await showDialog<List<CalendarEventData>>(
                          context: context,
                          builder:
                              (_) => EvConstraintDialog(
                                groupId: const Uuid().v4(),
                                evId: widget.id,
                              ),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 16),
                    PopupMenuButton<CalendarViewType>(
                      icon: const Icon(Icons.calendar_view_day),
                      offset: const Offset(115, 0),
                      onSelected: (view) {
                        setState(() {
                          _currentView = view;
                        });
                      },
                      itemBuilder:
                          (context) => [
                            const PopupMenuItem(
                              value: CalendarViewType.day,
                              child: Text("Day View"),
                            ),
                            const PopupMenuItem(
                              value: CalendarViewType.week,
                              child: Text("Week View"),
                            ),
                            const PopupMenuItem(
                              value: CalendarViewType.month,
                              child: Text("Month View"),
                            ),
                          ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
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
      builder: (_) => AlertDialog(
        title: const Text("Edit or Delete Constraint"),
        content: const Text("What would you like to do with this constraint?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final backendService = BackendService();
              try {
                await backendService.deleteConstraint(constraintId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Constraint deleted.")),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Delete failed: $e")),
                );
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // close dialog first
              await showDialog(
                context: context,
                builder: (_) => EvConstraintDialog(
                  groupId: tappedEvent.description ?? const Uuid().v4(),
                  evId: widget.id,
                  initialConstraintId: constraintId,
                  initialStart: tappedEvent.startTime,
                  initialEnd: tappedEvent.endTime,
                  initialPercentage: double.tryParse(
                      tappedEvent.title?.replaceAll(RegExp(r'[^\d]'), '') ?? '50') ?? 50,
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

  const EvConstraintDialog({
    required this.groupId,
    required this.evId,
    this.initialConstraintId,
    this.initialStart,
    this.initialEnd,
    this.initialPercentage,
    super.key,
  });

  @override
  EvConstraintDialogState createState() => EvConstraintDialogState();
}

class EvConstraintDialogState extends State<EvConstraintDialog> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now().add(const Duration(hours: 1));
  double _minCharge = 50;
  int? _constraintId;
  final backend_service = BackendService();

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Event'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("Start: ${_start.toString().substring(0, 16)}"),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDateTime(context, true),
                ),
              ],
            ),
            Row(
              children: [
                Text("End: ${_end.toString().substring(0, 16)}"),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDateTime(context, false),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("Minimum Charge Level: ${_minCharge.toInt()}%"),
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
          onPressed: () async {
            try {
              await backend_service.postConstraint(
                id: _constraintId,
                evId: widget.evId,
                startTime: _start,
                deadline: _end,
                targetPercentage: _minCharge.toDouble() / 100,
              );

              final events = splitMultiDayEvent(
                title: _titleController.text,
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
          },
          child: const Text('Add Event'),
        ),
      ],
    );
  }

  final uuid = Uuid();

  List<CalendarEventData> splitMultiDayEvent({
    required String title,
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
          title: "$title (Min charge: $minCharge%)",
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

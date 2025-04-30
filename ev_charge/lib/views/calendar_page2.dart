import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:uuid/uuid.dart';
import '../core/backend_service.dart';
import '../providers/ev_providers.dart';
enum CalendarViewType { day, week, month }

class EventCalendarPage extends ConsumerStatefulWidget{
  final int id;

  const EventCalendarPage({Key? key, required this.id}) : super(key: key);
  
  @override
  _EventCalendarPage createState() => _EventCalendarPage(); 
}

class _EventCalendarPage extends ConsumerState<EventCalendarPage>{
  final EventController _eventController = EventController();
  CalendarViewType _currentView = CalendarViewType.day;
  final Map<String, List<CalendarEventData>> _groupedEvents = {};

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Widget calendarView;
    final evstate = ref.watch(singleEvDetailProvider(widget.id));
    switch (_currentView) {
      case CalendarViewType.day:
        calendarView = DayView(onEventTap: _handleEventTap);
        break;
      case CalendarViewType.week:
        calendarView = WeekView(onEventTap: _handleEventTap);
        break;
      case CalendarViewType.month:
        calendarView = MonthView();
        break;
    }

    return CalendarControllerProvider(
      controller: _eventController,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: calendarView,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    final uuid = const Uuid().v4();
                    final result = await showDialog<List<CalendarEventData>>(
                      context: context,
                      builder: (_) => EventDialog(groupId: uuid, evId: widget.id, ),
                    );
                    if (result != null) {
                  _groupedEvents[uuid] = result;
                  for (final e in result) {
                    _eventController.add(e);
                  }
                }
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 16),
                PopupMenuButton<CalendarViewType>(
                icon: const Icon(Icons.calendar_view_day),
                offset: const Offset(115,0),
                onSelected: (view) {
                  setState(() {
                    _currentView = view;
                  });
                },
                itemBuilder: (context) => [
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
  }

  void _handleEventTap(List<CalendarEventData> events, DateTime date) {
    final tappedEvent = events.first;

    String? groupId;

    // Find which group this event belongs to
    groupId = tappedEvent.description;

    if (groupId == null) {
      // fallback: delete only the tapped event
      _eventController.remove(tappedEvent);
      return;
    }

    final groupEvents = _groupedEvents[groupId]!;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(tappedEvent.title ?? "Event"),
            content: const Text("Delete all related events in this group?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () { for (final e in groupEvents) { _eventController.remove(e); }
                  _groupedEvents.remove(groupId);
                  Navigator.pop(context);
                },
                child: const Text("Delete All"),
              ),
            ],
          ),
    );
  }
}

class EventDialog extends StatefulWidget {
  final String groupId;
  final int evId; 
  const EventDialog({required this.groupId, super.key, required this.evId});

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now().add(const Duration(hours: 1));
  double _minCharge = 50;
  final backend_service = BackendService();

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
            try{
              await backend_service.postConstraint(
                evId: widget.evId,
                start_time:_start,
                deadline:_end,
                targetPercentage:_minCharge.toDouble()/100,
              );

            final events = splitMultiDayEvent(
              title: _titleController.text,
              start: _start,
              end: _end,
              minCharge: _minCharge.toInt(),
              groupId: widget.groupId,
            );
            Navigator.pop(context, events);
            } catch(e){
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

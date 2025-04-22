import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ev_charge/widgets/charging_constraints_widget.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  OverlayEntry? _popupOverlay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<String>> events = {};
  List<String> _selectedEvents = [];
  Offset? _tapPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },

            eventLoader: (day) {
              final key = DateTime(day.year, day.month, day.day);
              return events[key] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return Listener(
                  onPointerDown: (PointerDownEvent event) {
                    _tapPosition = event.position;
                  },
                  child: GestureDetector(
                    onTap: () {
                      if (_tapPosition == null) return;

                      final size = MediaQuery.of(context).size;
                      if (_tapPosition!.dx < 0 ||
                          _tapPosition!.dy < 0 ||
                          _tapPosition!.dx > size.width ||
                          _tapPosition!.dy > size.height) {
                        _tapPosition = null;
                        return;
                      }

                      // Clean up existing popup
                      _popupOverlay?.remove();
                      _popupOverlay = null;
                      final normalizedDay = _normalizeDate(day);

                      setState(() {
                        _selectedDay = normalizedDay;
                        _focusedDay = normalizedDay;
                        _selectedEvents = events[normalizedDay] ?? [];
                      });

                      // Delay to allow gesture to finish
                      Future.delayed(const Duration(milliseconds: 0), () {
                        if (mounted) {
                          _showCustomPopup(context, _tapPosition!, day);
                        }
                        _tapPosition = null;
                      });
                    },
                    child: Center(child: Text('${day.day}')),
                  ),
                );
              },

              markerBuilder: (context, day, eventsForDay) {
                if (eventsForDay.isEmpty) return SizedBox.shrink();

                return Positioned(
                  bottom: 4,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
          ..._selectedEvents.map((event) => ListTile(title: Text(event))),
        ],
      ),
    );
  }

  void _showCustomPopup(BuildContext context, Offset position, DateTime day) {
    // Close any existing popup
    _popupOverlay?.remove();
    _popupOverlay = null;

    final overlay = Navigator.of(context).overlay!;
    _popupOverlay = OverlayEntry(
      builder:
          (context) => Positioned(
            left: position.dx,
            top: position.dy,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  _popupOverlay?.remove();
                  _popupOverlay = null;
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            _popupOverlay?.remove();
                            _popupOverlay = null;
                            showChargingConstraintsSheet(context, day, (
                              min,
                              deadline,
                            ) {
                              setState(() {
                               final event =
                                  '🔋 $min% | ${_formatDay(day)} → ${_formatDateTime(deadline)}';

                                final dayKey = _normalizeDate(day);
                                if (events.containsKey(dayKey)) {
                                  events[dayKey]!.add(event);
                                } else {
                                  events[dayKey] = [event];
                                }
                                _selectedEvents = events[dayKey]!;

                              // TODO: saveEventsToDB(); first structure data 
                              });
                            });
                          },
                          child: const Text('Add Charging Constraint'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(_popupOverlay!);
  }

  //helpers
  String _pad(int value) => value.toString().padLeft(2, '0');

  String _formatDeadline(DateTime deadline) {
    final time = TimeOfDay.fromDateTime(deadline);
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDay(DateTime date) {
    return '${date.year}-${_pad(date.month)}-${_pad(date.day)}';
  }

  String _formatDateTime(DateTime dt) {
    final date = _formatDay(dt);
    final time = TimeOfDay.fromDateTime(dt);
    return '$date ${_pad(time.hour)}:${_pad(time.minute)}';
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}

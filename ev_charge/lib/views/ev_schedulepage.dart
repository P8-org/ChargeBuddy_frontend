import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../views/calendar_page.dart';

class EvSchedulePage extends StatefulWidget {
  const EvSchedulePage({super.key, required this.id});
  final int id;

  @override
  State<EvSchedulePage> createState() => _EvSchedulePageState();
}

class _EvSchedulePageState extends State<EvSchedulePage> {
  CalendarViewType _currentView = CalendarViewType.day;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV Schedule'),
        actions: [
          PopupMenuButton<CalendarViewType>(
            icon: const Icon(Icons.calendar_view_day),
            offset: const Offset(64, -64),
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
          if (kDebugMode) SizedBox(width: 50),
        ],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Column(
        children: [
          Expanded(
            child: EventCalendarPage(id: widget.id, currentView: _currentView),
          ),
        ],
      ),
    );
  }
}

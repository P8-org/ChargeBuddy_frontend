import 'package:flutter/material.dart';

void showChargingConstraintsSheet(BuildContext context, DateTime selectedDate, void Function(int minCharge, DateTime deadline) onSave) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ChargingConstraintSheet(
          selectedDate: selectedDate,
          onSave: onSave,
        ),
      );
    },
  );
}
class ChargingConstraintSheet extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(int minCharge, DateTime deadline) onSave;

  const ChargingConstraintSheet({
    super.key,
    required this.selectedDate,
    required this.onSave,
  });

  @override
  State<ChargingConstraintSheet> createState() => _ChargingConstraintSheetState();
}

class _ChargingConstraintSheetState extends State<ChargingConstraintSheet> {
  int minCharge = 50;
  DateTime? deadline;

  Future<void> pickDeadline() async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      deadline = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Charging Constraints for ${widget.selectedDate.toLocal().toString().split(' ')[0]}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Minimum charge slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Min Charge:'),
              Text('$minCharge%'),
            ],
          ),
          Slider(
            value: minCharge.toDouble(),
            min: 0,
            max: 100,
            divisions: 20,
            label: '$minCharge%',
            onChanged: (value) {
              setState(() {
                minCharge = value.round();
              });
            },
          ),

          const SizedBox(height: 16),

          // Deadline picker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Deadline:'),
              Text(deadline != null
                  ? deadline.toString()
                  : 'Not set'),
            ],
          ),
          ElevatedButton(
            onPressed: pickDeadline,
            child: const Text('Pick Deadline'),
          ),

          const SizedBox(height: 20),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (deadline != null) {
                    widget.onSave(minCharge, deadline!);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a deadline')),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

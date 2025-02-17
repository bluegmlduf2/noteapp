import 'package:flutter/material.dart';
import 'package:note_app/data/colors.dart';

class TimePicker extends StatefulWidget {
  final String label;

  const TimePicker({super.key, required this.label});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            '${selectedTime.hour.toString().padLeft(2, "0")}:${selectedTime.minute.toString().padLeft(2, "0")}',
            style: const TextStyle(fontSize: 14),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: blue1,
              size: 20,
            ),
            onPressed: () => _selectTime(context),
          ),
        ])
      ],
    );
  }
}

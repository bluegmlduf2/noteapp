import 'package:flutter/material.dart';
import 'package:note_app/data/colors.dart';

class TimePicker extends StatefulWidget {
  final String label;

  const TimePicker({super.key, required this.label});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime; // 초기값을 null로 설정

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(), // null일 경우 현재 시간 사용
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _clearTime() {
    setState(() {
      selectedTime = null; // 시간을 null로 설정하여 초기화
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              selectedTime != null
                  ? '${selectedTime!.hour.toString().padLeft(2, "0")}:${selectedTime!.minute.toString().padLeft(2, "0")}'
                  : 'Please Select',
              style: const TextStyle(fontSize: 15),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: blue1,
                size: 20,
              ),
              onPressed: () => _selectTime(context),
            ),
            if (selectedTime != null) // 선택된 시간이 있을 때만 클리어 버튼 표시
              IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: 20,
                ),
                onPressed: _clearTime,
              ),
          ],
        )
      ],
    );
  }
}

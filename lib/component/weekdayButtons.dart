import 'package:flutter/material.dart';
import 'package:note_app/data/colors.dart';

class WeekdayButtons extends StatefulWidget {
  const WeekdayButtons({super.key});

  @override
  _WeekdayButtonsState createState() => _WeekdayButtonsState();
}

class _WeekdayButtonsState extends State<WeekdayButtons> {
  List<Map<String, dynamic>> list = [
    {'key': 0, 'name': 'mon', 'isSelected': false},
    {'key': 1, 'name': 'tue', 'isSelected': false},
    {'key': 2, 'name': 'wed', 'isSelected': false},
    {'key': 3, 'name': 'thu', 'isSelected': false},
    {'key': 4, 'name': 'fri', 'isSelected': false},
    {'key': 5, 'name': 'sat', 'isSelected': false},
    {'key': 6, 'name': 'sun', 'isSelected': false},
  ];

  void _toggleSelection(int key) {
    setState(() {
      var item = list.firstWhere(
        (element) => element['key'] == key,
        orElse: () => {},
      );

      if (item.isNotEmpty) {
        item['isSelected'] = !item['isSelected'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekdays',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildWeekdayButtons(),
        ),
      ],
    );
  }

  List<Widget> _buildWeekdayButtons() {
    return list.map((weekday) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: WeekdayButton(
          label: "${weekday['name']}",
          isSelected: weekday['isSelected'],
          onTap: () => _toggleSelection(weekday['key']),
        ),
      );
    }).toList();
  }
}

class WeekdayButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const WeekdayButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 17,
        backgroundColor: isSelected ? blue1 : gray2,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:note_app/data/colors.dart';

class DayButtons extends StatefulWidget {
  const DayButtons({super.key});

  @override
  DayButtonsState createState() => DayButtonsState();
}

class DayButtonsState extends State<DayButtons> {
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
          'week',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildDayButtons(),
        ),
      ],
    );
  }

  List<Widget> _buildDayButtons() {
    return list.map((day) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: DayButton(
          label: "${day['name']}",
          isSelected: day['isSelected'],
          onTap: () => _toggleSelection(day['key']),
        ),
      );
    }).toList();
  }
}

class DayButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const DayButton({
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

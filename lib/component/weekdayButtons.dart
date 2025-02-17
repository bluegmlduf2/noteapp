import 'package:flutter/material.dart';
import 'package:note_app/data/colors.dart';

class WeekdayButtons extends StatefulWidget {
  const WeekdayButtons({super.key});

  @override
  _WeekdayButtonsState createState() => _WeekdayButtonsState();
}

class _WeekdayButtonsState extends State<WeekdayButtons> {
  final List<bool> isSelected = List.generate(7, (index) => false);

  void _toggleSelection(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
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
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildWeekdayButtons(),
        ),
      ],
    );
  }

  List<Widget> _buildWeekdayButtons() {
    return List.generate(7, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: WeekdayButton(
          label: "${index + 1}",
          isSelected: isSelected[index],
          onTap: () => _toggleSelection(index),
        ),
      );
    });
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
        radius: 15,
        backgroundColor: isSelected ? blue1 : gray2,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

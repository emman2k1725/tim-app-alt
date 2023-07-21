import 'package:flutter/material.dart';

class OpeningHourForm extends StatefulWidget {
  const OpeningHourForm({super.key});

  @override
  _OpeningHourFormState createState() => _OpeningHourFormState();
}

class _OpeningHourFormState extends State<OpeningHourForm> {
  List<TimeOfDay?> operatingHours = List.filled(7, null);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(getDayOfWeek(index)),
          trailing: ElevatedButton(
            onPressed: () {
              _selectTime(context, index);
            },
            child: Text(
              operatingHours[index] != null
                  ? operatingHours[index]!.format(context)
                  : 'Select Time',
            ),
          ),
        );
      },
    );
  }

  String getDayOfWeek(int dayIndex) {
    switch (dayIndex) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        return '';
    }
  }

  Future<void> _selectTime(BuildContext context, int dayIndex) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != operatingHours[dayIndex]) {
      setState(() {
        operatingHours[dayIndex] = pickedTime;
      });
    }
  }
}

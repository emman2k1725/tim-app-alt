import 'package:flutter/material.dart';
import 'package:tim_app/pages/apply_business/components/business_opening_hour.dart';

class OperatingHours {
  TimeOfDay openingTime;
  TimeOfDay closingTime;

  OperatingHours({required this.openingTime, required this.closingTime});
}

class StepperThree extends StatefulWidget {
  const StepperThree({super.key});

  @override
  State<StepperThree> createState() => _StepperThreeState();
}

class _StepperThreeState extends State<StepperThree> {
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<OperatingHours> operatingHoursList = List.generate(
      7,
      (index) => OperatingHours(
          openingTime: TimeOfDay.now(), closingTime: TimeOfDay.now()));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      height: 700,
      color: Colors.white,
      child: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(daysOfWeek[index]),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: buildTimePicker(
                        'Opening', operatingHoursList[index].openingTime,
                        (time) {
                      setState(() {
                        operatingHoursList[index].openingTime = time;
                      });
                    }),
                  ),
                ),
                Expanded(
                  child: buildTimePicker(
                      'Closing', operatingHoursList[index].closingTime, (time) {
                    setState(() {
                      operatingHoursList[index].closingTime = time;
                    });
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTimePicker(
      String labelText, TimeOfDay time, Function(TimeOfDay) onTimeChanged) {
    return InkWell(
      onTap: () async {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (selectedTime != null) {
          onTimeChanged(selectedTime);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${time.format(context)}',
              style: TextStyle(fontSize: 12),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

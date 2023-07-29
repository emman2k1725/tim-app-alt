import 'package:flutter/material.dart';
import '../../../model/BusinessModel.dart';

class OperatingHours {
  TimeOfDay openingTime;
  TimeOfDay closingTime;

  OperatingHours({required this.openingTime, required this.closingTime});
}

class StepperThree extends StatefulWidget {
  final BusinessModel? businessModel;
  final GlobalKey<FormState> formKey;
  const StepperThree(
      {super.key, required this.formKey, required this.businessModel});

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
          openingTime: const TimeOfDay(hour: 8, minute: 0),
          closingTime: const TimeOfDay(hour: 21, minute: 0)));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
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
                          String? hour = time.hour.toString().padLeft(2, '0');
                          String? min = time.minute.toString().padRight(2, '0');
                          String? cleanTime = '$hour:$min';
                          widget.businessModel
                                  ?.businessHours?[daysOfWeek[index]]![0] =
                              cleanTime;
                        });
                      }),
                    ),
                  ),
                  Expanded(
                    child: buildTimePicker(
                        'Closing', operatingHoursList[index].closingTime,
                        (time) {
                      setState(() {
                        operatingHoursList[index].closingTime = time;
                        String? hour = time.hour.toString().padLeft(2, '0');
                        String? min = time.minute.toString().padRight(2, '0');
                        String? cleanTime = '$hour:$min';
                        widget.businessModel
                            ?.businessHours?[daysOfWeek[index]]![1] = cleanTime;
                      });
                    }),
                  ),
                ],
              ),
            );
          },
        ),
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

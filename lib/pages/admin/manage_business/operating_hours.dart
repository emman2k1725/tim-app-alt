import 'package:flutter/material.dart';

class OperatingHoursPopup extends StatelessWidget {
  final List<Map<String, String>> operatingHours;

  OperatingHoursPopup({required this.operatingHours});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Operating Hours'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: operatingHours.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(operatingHours[index]['day'] ?? ''),
              subtitle: Text(
                'Opening: ${operatingHours[index]['openingTime'] ?? ''}\n'
                'Closing: ${operatingHours[index]['closingTime'] ?? ''}',
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

class OperatingHours extends StatelessWidget {
  final List<Map<String, String>> operatingHours = [
    {'day': 'Monday', 'openingTime': '8:00 AM', 'closingTime': '6:00 PM'},
    {'day': 'Tuesday', 'openingTime': '9:00 AM', 'closingTime': '7:00 PM'},
    {'day': 'Wednesday', 'openingTime': '8:30 AM', 'closingTime': '5:30 PM'},
    // Add more days and times as needed
  ];

  void _showOperatingHoursPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OperatingHoursPopup(operatingHours: operatingHours);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _showOperatingHoursPopup(context),
        child: Text('View Operating Hours'),
      ),
    );
  }
}

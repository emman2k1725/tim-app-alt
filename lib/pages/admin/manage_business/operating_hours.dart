import 'package:flutter/material.dart';

class OperatingHoursPopup extends StatelessWidget {
  final Map<String, dynamic> operatingHours;

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
            String key = operatingHours.keys.elementAt(index);
            dynamic value = operatingHours[key];
            return ListTile(
              title: Text(key ?? ''),
              subtitle: Text(
                'Opening: ${value[0] ?? ''}\n'
                'Closing: ${value[1] ?? ''}',
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
  final Map<String, dynamic> operatingHours;
  OperatingHours({required this.operatingHours});
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

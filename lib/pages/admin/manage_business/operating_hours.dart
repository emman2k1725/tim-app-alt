import 'package:flutter/material.dart';

class OperatingHoursPopup extends StatelessWidget {
  final Map<String, dynamic> operatingHours;

  OperatingHoursPopup({required this.operatingHours});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Operating Hours'),
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
          child: const Text('Close'),
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
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_bottom),
            SizedBox(width: 8.0),
            Text('View Operating Hours'),
          ],
        ),
      ),
    );
  }
}

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tim_app/utils/constants.dart';

class StepperTwo extends StatefulWidget {
  const StepperTwo({super.key});

  @override
  State<StepperTwo> createState() => _StepperTwoState();
}

class _StepperTwoState extends State<StepperTwo> {
  //Phone number international coded
  TextEditingController phoneNumberController = TextEditingController();

  //city picker value
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      height: 850,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Details',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  'Update your business photo and details here',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Business Logo',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Upload your business logo',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: Center(
                    child: ImageUploadCard(
                      icon: const Icon(Icons.cloud_upload_outlined,
                          size: 35, color: Colors.blue),
                      description: 'Click to upload',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Thumbnails',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  'Upload your 3 business thumbnails here',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: Center(
                    child: ImageUploadCard(
                      icon: const Icon(Icons.cloud_upload_outlined,
                          size: 35, color: Colors.blue),
                      description: 'Click to upload',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: Center(
                    child: ImageUploadCard(
                      icon: const Icon(Icons.cloud_upload_outlined,
                          size: 35, color: Colors.blue),
                      description: 'Click to upload',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: Center(
                    child: ImageUploadCard(
                      icon: const Icon(Icons.cloud_upload_outlined,
                          size: 35, color: Colors.blue),
                      description: 'Click to upload',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Description',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  'Describe your business in less or 50 words',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Business Description',
              hintText: 'Business Description max of 50 words',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Business Links',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Google Map Link',
              hintText: 'Google Map Link',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Facebook Link',
              hintText: 'Facebook Link',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Instagram Link',
              hintText: 'Instagram Link',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageUploadCard extends StatelessWidget {
  final Icon icon;
  final String description;

  ImageUploadCard({required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.blue, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

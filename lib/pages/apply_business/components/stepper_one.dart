import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:tim_app/pages/apply_business/components/business_sector_dropdown.dart';

class StepperOne extends StatefulWidget {
  const StepperOne({super.key});

  @override
  State<StepperOne> createState() => _StepperOneState();
}

class _StepperOneState extends State<StepperOne> {
  @override
  Widget build(BuildContext context) {
    //Phone number international coded
    TextEditingController phoneNumberController = TextEditingController();

    String? country = "";
    String? state = "";
    String? city = "";
    String? building = "";
    String? street = "";
    String? postal = "";
    return Container(
      color: Colors.white, // Set the background color of Step 1
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Company Name',
              hintText: 'Company Name',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name of Business *',
              hintText: 'Name of Business',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: const Text(
              'Company Address',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16.0),
          // Row(
          //   children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Building Address',
              hintText: 'Room No./Bldg. No. ',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
            onSaved: (value) {
              building = value;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Street Address',
              hintText: 'Blk. No./Str No.',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
            onSaved: (value) {
              street = value;
            },
          ),
          //   ],
          // ),
          const SizedBox(height: 16.0),
          TextFormField(
              decoration: InputDecoration(
                labelText: 'State',
                hintText: 'State/Province/Region',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your State/Province/Region";
                } else {
                  state = value;
                  return null;
                }
              }),
          const SizedBox(height: 16.0),
          TextFormField(
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'City/Municipality/Town',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your City/Municipality/Town";
                } else {
                  city = value;
                  return null;
                }
              }),
          const SizedBox(height: 10.0),
          TextFormField(
              decoration: InputDecoration(
                labelText: 'Postal code',
                hintText: 'Postal Code',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your Postal code";
                } else {
                  postal = value;
                  return null;
                }
              }),
          const SizedBox(height: 10.0),
          TextFormField(
              decoration: InputDecoration(
                labelText: 'Country',
                hintText: 'Country',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your Country";
                } else {
                  country = value;
                  return null;
                }
              }),
          const SizedBox(height: 16.0),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
            initialCountryCode: 'US', // Set the initial country code
            controller: phoneNumberController,
            onChanged: (phone) {
              // Handle phone number changes
              print(phone.completeNumber);
            },
          ),
          const BUsinessDropdown(),
        ],
      ),
    );
  }
}

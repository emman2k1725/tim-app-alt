import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/businessDataProvider.dart';
import 'package:tim_app/pages/apply_business/components/business_sector_dropdown.dart';
import 'package:tim_app/pages/services/validator_service.dart';

import '../../../backend/firebase/UserDataProvider.dart';
import '../../../model/BusinessModel.dart';
import '../../../model/UserModel.dart';

class StepperOne extends StatefulWidget {
  const StepperOne({super.key});

  @override
  State<StepperOne> createState() => _StepperOneState();
}

final _formKey = GlobalKey<FormState>();

class _StepperOneState extends State<StepperOne> {
  @override
  Widget build(BuildContext context) {
    BusinessDataProvider businessProvider =
        Provider.of<BusinessDataProvider>(context);
    BusinessModel? business = businessProvider.businessData;
    //Phone number international coded
    TextEditingController phoneNumberController = TextEditingController();

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
            onSaved: (value) {
              if (value == null) {
                business?.companyName = null;
              } else {
                business?.companyName = value;
              }
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name of business';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              if (value == null) {
                business?.businessName = null;
              } else {
                business?.businessName = value;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: const Text(
              'Business Address',
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
              business?.businessAddress?['building'] = value;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Street Address *',
              hintText: 'Blk. No./Str No.',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Street/Block Address';
              }
            },
            onSaved: (value) {
              business?.businessAddress?['street'] = value;
            },
          ),
          //   ],
          // ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'State *',
              hintText: 'State/Province/Region',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your State/Province/Region";
              }
            },
            onSaved: (value) {
              business?.businessAddress?['state'] = value;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'City *',
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
              }
            },
            onSaved: (value) {
              business?.businessAddress?['city'] = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Postal code *',
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
                return "Please enter your postal code";
              } else if (containsChar(value)) {
                return "Please enter a valid postal code";
              }
            },
            onSaved: (value) {
              business?.businessAddress?['postal'] = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Country *',
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
                return "Please enter a country";
              }
            },
            onSaved: (value) {
              business?.businessAddress?['country'] = value;
            },
          ),
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
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            validator: (value) {
              if (value?.number == null ||
                  value == null ||
                  value.number!.isEmpty) {
                return 'Please enter a phone number';
              }
              debugPrint(value.toString());
            },
            onSaved: (value) {
              business?.businessPhoneNumber = value.toString();
            },
          ),
          const BUsinessDropdown(),
        ],
      ),
    );
  }
}

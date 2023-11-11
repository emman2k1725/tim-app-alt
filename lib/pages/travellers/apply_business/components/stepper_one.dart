import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tim_app/pages/travellers/apply_business/components/business_sector_dropdown.dart';
import 'package:tim_app/pages/services/validator_service.dart';
import '../../../../model/BusinessModel.dart';

class StepperOne extends StatefulWidget {
  final BusinessModel? businessModel;
  final GlobalKey<FormState> formKey;
  const StepperOne({
    super.key,
    required this.formKey,
    required this.businessModel,
  });

  @override
  State<StepperOne> createState() => _StepperOneState();
}

String? phoneNumber, countryCode;

class _StepperOneState extends State<StepperOne> {
  @override
  Widget build(BuildContext context) {
    //Phone number international coded
    TextEditingController phoneNumberController = TextEditingController();

    return Container(
      color: Colors.transparent, // Set the background color of Step 1
      child: Form(
        key: widget.formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'Company Name',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    onSaved: (value) {
                      if (value == null) {
                        widget.businessModel?.companyName = null;
                      } else {
                        widget.businessModel?.companyName = value;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Name of Business *',
                      hintText: 'Name of Business',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
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
                        widget.businessModel?.businessName = null;
                      } else {
                        widget.businessModel?.businessName = value;
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Business Email *',
                      hintText: 'Business Email',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email of business';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      if (value == null) {
                        widget.businessModel?.businessName = null;
                      } else {
                        widget.businessModel?.businessName = value;
                      }
                    },
                  ),
                ),
                Expanded(
                    child:
                        BUsinessDropdown(businessModel: widget.businessModel)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              initialCountryCode: 'PH', // Set the initial country code
              controller: phoneNumberController,
              onChanged: (phone) {
                phoneNumber = phone.completeNumber.toString();
                countryCode = phone.countryCode.toString();
              },
              onSaved: (newValue) {
                widget.businessModel?.businessPhoneNumber?['number'] =
                    phoneNumber;
                widget.businessModel?.businessPhoneNumber?['countryCode'] =
                    countryCode;
              },
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Business Address',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Country *',
                      hintText: 'Country',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a country";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.businessModel?.businessAddress?['country'] = value;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'City *',
                      hintText: 'City/Municipality/Town',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your City/Municipality/Town";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.businessModel?.businessAddress?['city'] = value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              style: TextStyle(color: Colors.white),
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
                widget.businessModel?.businessAddress?['building'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Street Address *',
                      hintText: 'Blk. No./Str No.',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Street/Block Address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.businessModel?.businessAddress?['street'] = value;
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'State *',
                      hintText: 'State/Province/Region',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your State/Province/Region";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.businessModel?.businessAddress?['state'] = value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Postal code *',
                      hintText: 'Postal Code',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your postal code";
                      } else if (containsChar(value)) {
                        return "Please enter a valid postal code";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.businessModel?.businessAddress?['postal'] = value;
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

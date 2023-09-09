// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';
import 'package:tim_app/utils/responsive.dart';

class DateRangePickerTextField extends StatefulWidget {
  final formKey;
  const DateRangePickerTextField({super.key, required this.formKey});
  @override
  _DateRangePickerTextFieldState createState() =>
      _DateRangePickerTextFieldState();
}

class _DateRangePickerTextFieldState extends State<DateRangePickerTextField> {
  DateTime? _startDate;
  TextEditingController _startTimeController = TextEditingController();
  TimeOfDay? _startTime;

  TextEditingController _endTimeController = TextEditingController();
  TimeOfDay? _endTime;
  
  TextEditingController _startdateController = TextEditingController();
  String? _selectedDateText;

  TextEditingController _enddateController = TextEditingController();
  DateTime? _endDate;

  Future<List<String>>? _dropdowncities;
  
  @override
  void initState() {
    super.initState();
    _dropdowncities = FirebaseService.fetchDropdownItems('cities');
  }
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _selectedDateText = _startDate!.toLocal().toString().split(' ')[0];
        _startdateController.text = _selectedDateText!;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        _selectedDateText = _endDate!.toLocal().toString().split(' ')[0];
        _enddateController.text = _selectedDateText!;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
        _selectedDateText =  _startTime?.format(context) ?? '';
        _startTimeController.text = _selectedDateText!;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
        _selectedDateText =  _endTime?.format(context) ?? '';
        _endTimeController.text = _selectedDateText!;
      });
    }
  }

  String _selectedCity = 'Please select a city'; // Default selected city



  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Responsive.isDesktop(context)
                ? Row(
                    children: [
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: _startdateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Please select starting date";
                            } else if (value.compareTo(DateTime.now().toString()) <= 0){
                              return "Please select a valid starting date";
                            }
                            else {
                              return null;
                            } 
                          },
                          onChanged: (value) => debugPrint(value),
                          readOnly: true,
                          onTap: () => _selectStartDate(context),
                          decoration: InputDecoration(
                            labelText: 'Start Date',
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.white), // White border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors
                                      .blue), // White border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors
                                      .white), // White border color when enabled
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: 250,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Please select end date";
                            } else if(value.compareTo(_startDate.toString()) <= 0)  {
                              return "Please select a valid end date";
                            } else if(DateTime.parse(value).difference(_startDate!).inDays >= 5)  {
                            return "Only 5 days are allowed";
                            }else {
                              return null;
                            } 
                          },
                          readOnly: true,
                          onTap: () => _selectEndDate(context),
                          decoration: InputDecoration(
                            labelText: 'End Date',
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.white), // White border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors
                                      .blue), // White border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors
                                      .white), // White border color when enabled
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          controller: _enddateController,
                          style: TextStyle(
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                            validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Please select starting date";
                            } else if (value.compareTo(DateTime.now().toString()) <= 0){
                              return "Please select a valid starting date";
                            }
                            else {
                              return null;
                            } 
                          },
                        readOnly: true,
                        onTap: () => _selectStartDate(context),
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors.white), // White border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .blue), // White border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // White border color when enabled
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        controller: _startdateController,
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Please select end date";
                          } else if(value.compareTo(_startDate.toString()) <= 0)  {
                            return "Please select a valid end date";
                          } else if(DateTime.parse(value).difference(_startDate!).inDays >= 5)  {
                            return "Only 5 days are allowed";
                          } else {
                            return null;
                          } 
                        },
                        readOnly: true,
                        onTap: () => _selectEndDate(context),
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors.white), // White border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .blue), // White border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // White border color when enabled
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        controller: _enddateController,
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 16),
            Responsive.isDesktop(context)
                ? Row(
                    children: [
                      Container(
                        width: 250,
                        child: TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Please select starting time";
                          } else {
                            return null;
                          } 
                        },
                          onTap: () => _selectStartTime(context),
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Start Time',
                            suffixIcon: Icon(
                              Icons.access_time,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.white), // White border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors
                                      .blue), // White border color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors
                                      .white), // White border color when enabled
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          controller: _startTimeController,
                          style: TextStyle(
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "Please select end time";
                              } else {
                                return null;
                              } 
                            },
                              onTap: () => _selectEndTime(context),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'End Time',
                                suffixIcon: Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.white), // White border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors
                                          .blue), // White border color when focused
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors
                                          .white), // White border color when enabled
                                ),
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              controller: _endTimeController,
                              style: TextStyle(
                                color: Colors.white, // Set text color to white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Please select starting time";
                          } else {
                            return null;
                          } 
                        },
                        onTap: () => _selectStartTime(context),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors.white), // White border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .blue), // White border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // White border color when enabled
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        controller: _startTimeController,
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Please select end time";
                          } else {
                            return null;
                          } 
                        },
                        onTap: () => _selectEndTime(context),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors.white), // White border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .blue), // White border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors
                                    .white), // White border color when enabled
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        controller: _endTimeController,
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 16),
            Responsive.isDesktop(context)
                ? Row(
                    children: [
                      Container(
                        width: 520,
                        child: FutureBuilder(
                          future: _dropdowncities,
                          builder: (context, snapshot) {
                          List<String> fetchedItems = snapshot.data ?? [];
                          return DropdownButtonFormField<String>(
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Please select a city";
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: fetchedItems.map((city) {
                              return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(
                                    city,
                                  ));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCity = newValue!;
                              });
                            },
                            style: TextStyle(
                              color: Colors
                                  .black, // Set text color for non-selected items
                            ),
                            selectedItemBuilder: (BuildContext context) {
                              return fetchedItems.map<Widget>((String item) {
                                return Text(
                                  item,
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Set text color for selected item
                                  ),
                                );
                              }).toList();
                            },
                            decoration: InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.white), // White border color
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors
                                        .blue), // White border color when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors
                                        .white), // White border color when enabled
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.white), // Label text color
                            ),
                          );
                          }
                        ),
                      ),
                    ],
                  )
                : FutureBuilder(
                  future: _dropdowncities,
                  builder: (context, snapshot) {
                  List<String> fetchedItems = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return "Please select a city";
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      value: _selectedCity,
                      items: fetchedItems.map((city) {
                        return DropdownMenuItem<String>(
                            value: city,
                            child:
                                Text(city, style: TextStyle(color: Colors.black)));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCity = newValue!;
                        });
                      },
                      style: TextStyle(
                        color:
                            Colors.black, // Set text color for non-selected items
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return fetchedItems.map<Widget>((String item) {
                          return Text(
                            item,
                            style: TextStyle(
                              color:
                                  Colors.white, // Set text color for selected item
                            ),
                          );
                        }).toList();
                      },
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.white), // White border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  Colors.blue), // White border color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  Colors.white), // White border color when enabled
                        ),
                        labelStyle:
                            TextStyle(color: Colors.white), // Label text color
                      ),
                    );
                  }
                ),
          ],
        ),
      ),
    );
  }
}

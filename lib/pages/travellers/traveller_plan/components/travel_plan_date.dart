// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tim_app/utils/responsive.dart';

class DateRangePickerTextField extends StatefulWidget {
  @override
  _DateRangePickerTextFieldState createState() =>
      _DateRangePickerTextFieldState();
}

class _DateRangePickerTextFieldState extends State<DateRangePickerTextField> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _startDate;
  DateTime? _endDate;

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
      });
    }
  }

  String _selectedCity = 'New York'; // Default selected city

  final List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Philadelphia',
    // Add more cities here
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      child: TextField(
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
                        controller: TextEditingController(
                            text: _startDate?.toString().split(' ')[0] ?? ''),
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 250,
                      child: TextField(
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
                        controller: TextEditingController(
                            text: _endDate?.toString().split(' ')[0] ?? ''),
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
                    TextField(
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
                      controller: TextEditingController(
                          text: _startDate?.toString().split(' ')[0] ?? ''),
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
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
                      controller: TextEditingController(
                          text: _endDate?.toString().split(' ')[0] ?? ''),
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
                        controller: TextEditingController(
                          text: _startTime?.format(context) ?? '',
                        ),
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
                            controller: TextEditingController(
                              text: _endTime?.format(context) ?? '',
                            ),
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
                      controller: TextEditingController(
                        text: _startTime?.format(context) ?? '',
                      ),
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
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
                      controller: TextEditingController(
                        text: _endTime?.format(context) ?? '',
                      ),
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
                      child: DropdownButtonFormField<String>(
                        value: _selectedCity,
                        items: cities.map((city) {
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
                          return cities.map<Widget>((String item) {
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
                      ),
                    ),
                  ],
                )
              : DropdownButtonFormField<String>(
                  value: _selectedCity,
                  items: cities.map((city) {
                    return DropdownMenuItem<String>(
                        value: city, child: Text(city));
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
                    return cities.map<Widget>((String item) {
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
                ),
        ],
      ),
    );
  }
}

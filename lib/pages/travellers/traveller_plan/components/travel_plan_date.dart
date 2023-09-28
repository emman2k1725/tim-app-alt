// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';
import 'package:tim_app/utils/responsive.dart';

class DateRangePickerTextField extends StatefulWidget {
  final formKey;
  final travelSearchParameters;
  const DateRangePickerTextField(
      {super.key, required this.formKey, required this.travelSearchParameters});
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
  Future<List<Map<String, dynamic>>>? _fetchDropDownCities;
  @override
  void initState() {
    super.initState();
    _fetchDropDownCities = FirebaseService.fetchCities();
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
      initialTime: _startTime ?? TimeOfDay(hour: 08, minute: 00),
    );

    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
        _selectedDateText = _startTime?.format(context) ?? '';
        _startTimeController.text = _selectedDateText!;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay(hour: 19, minute: 00),
    );

    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
        _selectedDateText = _endTime?.format(context) ?? '';
        _endTimeController.text = _selectedDateText!;
      });
    }
  }

  String convertTo24HourFormat(String? timeString) {
    final inputFormat = DateFormat('hh:mm a');
    final outputFormat = DateFormat('HH:mm');

    DateTime dateTime = inputFormat.parse(timeString!);
    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  DateTime currentTime = DateTime.now();

  TimeOfDay convertStringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(' ');
    List<int> timeParts = parts[0].split(':').map(int.parse).toList();

    int hour = timeParts[0];
    int minute = timeParts[1];

    if (parts[1].toLowerCase() == 'pm' && hour != 12) {
      hour += 12;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  int compareTimeOfDay(TimeOfDay a, TimeOfDay b) {
    if (a.hour < b.hour) {
      return -1;
    } else if (a.hour > b.hour) {
      return 1;
    } else {
      if (a.minute < b.minute) {
        return -1;
      } else if (a.minute > b.minute) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  List<String> getDatesInBetween(DateTime startDate, DateTime endDate) {
    List<String> dates = [];
    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      dates.add(DateFormat('yyyy-MM-dd').format(currentDate));
      currentDate = currentDate.add(Duration(days: 1));
    }

    return dates;
  }

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
                            if (value == null || value.isEmpty) {
                              return "Please select starting date";
                            } else if (DateTime.parse(value).isBefore(DateTime(
                                currentTime.year,
                                currentTime.month,
                                currentTime.day))) {
                              return "Please select a valid starting date";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            widget.travelSearchParameters['startDate'] = value;
                          },
                          onChanged: (value) => debugPrint(value),
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
                            if (value == null || value.isEmpty) {
                              return "Please select end date";
                            } else if (DateTime.parse(value)
                                .isBefore(_startDate!)) {
                              return "Please select a valid end date";
                            } else if (DateTime.parse(value)
                                    .difference(_startDate!)
                                    .inDays >=
                                5) {
                              return "Only 5 days of travel is allowed";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            widget.travelSearchParameters['days'] =
                                DateTime.parse(value!)
                                        .difference(_startDate!)
                                        .inDays +
                                    1;
                            widget.travelSearchParameters['endDate'] = value;
                          },
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select starting date";
                          } else if (DateTime.parse(value).isBefore(DateTime(
                              currentTime.year,
                              currentTime.month,
                              currentTime.day))) {
                            return "Please select a valid starting date";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          widget.travelSearchParameters['startDate'] = value;
                        },
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select end date";
                          } else if (DateTime.parse(value)
                              .isBefore(_startDate!)) {
                            return "Please select a valid end date";
                          } else if (DateTime.parse(value)
                                  .difference(_startDate!)
                                  .inDays >=
                              5) {
                            return "Only 5 days are allowed";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          widget.travelSearchParameters['days'] =
                              DateTime.parse(value!)
                                  .difference(_startDate!)
                                  .inDays;
                          widget.travelSearchParameters['endDate'] = value;
                        },
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select starting time";
                            } else if (compareTimeOfDay(
                                    convertStringToTimeOfDay(value),
                                    TimeOfDay(hour: 8, minute: 00)) <
                                0) {
                              return "Select start time after 8:00 AM";
                            } else {
                              return null;
                            }
                          },
                          onTap: () => _selectStartTime(context),
                          onSaved: (value) {
                            widget.travelSearchParameters['startTime'] =
                                convertTo24HourFormat(value);
                          },
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select end time";
                                } else if (compareTimeOfDay(
                                        convertStringToTimeOfDay(value),
                                        TimeOfDay(hour: 22, minute: 00)) >
                                    0) {
                                  return "Select end time before 10:00 PM";
                                } else {
                                  return null;
                                }
                              },
                              onTap: () => _selectEndTime(context),
                              onSaved: (value) {
                                widget.travelSearchParameters['endTime'] =
                                    convertTo24HourFormat(value);
                                for (String days in getDatesInBetween(
                                    _startDate!, _endDate!)) {
                                  widget.travelSearchParameters['dates']
                                      .add(days.toString());
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'End Time',
                                suffixIcon: Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color:
                                          Colors.white), // White border color
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select starting time";
                          } else if (compareTimeOfDay(
                                  convertStringToTimeOfDay(value),
                                  TimeOfDay(hour: 8, minute: 00)) <
                              0) {
                            return "Select a time above 8:00 AM";
                          } else {
                            return null;
                          }
                        },
                        onTap: () => _selectStartTime(context),
                        onSaved: (value) {
                          widget.travelSearchParameters['startTime'] =
                              convertTo24HourFormat(value);
                        },
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select end time";
                          } else if (compareTimeOfDay(
                                  convertStringToTimeOfDay(value),
                                  TimeOfDay(hour: 22, minute: 00)) >
                              0) {
                            return "Select an end time before 10:00 PM";
                          } else {
                            return null;
                          }
                        },
                        onTap: () => _selectEndTime(context),
                        onSaved: (value) {
                          widget.travelSearchParameters['endTime'] =
                              convertTo24HourFormat(value);
                          for (String days
                              in getDatesInBetween(_startDate!, _endDate!)) {
                            widget.travelSearchParameters['dates']
                                .add(days.toString());
                          }
                        },
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
                            future: _fetchDropDownCities,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              List<Map<String, dynamic>> dropdownItems =
                                  snapshot.data!;
                              return DropdownButtonFormField<
                                  Map<String, dynamic>>(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a city";
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (Map<String, dynamic>? newValue) {
                                  widget.travelSearchParameters['city'] =
                                      newValue!['city'];
                                  widget.travelSearchParameters['lat'] =
                                      newValue['lat'];
                                  widget.travelSearchParameters['long'] =
                                      newValue['long'];
                                },
                                items: dropdownItems
                                    .map((Map<String, dynamic> item) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                      value: item,
                                      child: Text(
                                        item['city'],
                                      ));
                                }).toList(),
                                style: TextStyle(
                                  color: Colors
                                      .black, // Set text color for non-selected items
                                ),
                                selectedItemBuilder: (BuildContext context) {
                                  return dropdownItems
                                      .map<Widget>((Map<String, dynamic> item) {
                                    return Text(
                                      item['city'],
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
                                        color:
                                            Colors.white), // White border color
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
                            }),
                      ),
                    ],
                  )
                : FutureBuilder(
                    future: _fetchDropDownCities,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      List<Map<String, dynamic>> dropdownItems = snapshot.data!;
                      return DropdownButtonFormField<Map<String, dynamic>>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a city";
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (Map<String, dynamic>? newValue) {
                          widget.travelSearchParameters['city'] =
                              newValue!['city'];
                          widget.travelSearchParameters['lat'] =
                              newValue['lat'];
                          widget.travelSearchParameters['long'] =
                              newValue['long'];
                        },
                        items: dropdownItems.map((Map<String, dynamic> item) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                              value: item,
                              child: Text(
                                item['city'],
                              ));
                        }).toList(),
                        style: TextStyle(
                          color: Colors
                              .black, // Set text color for non-selected items
                        ),
                        selectedItemBuilder: (BuildContext context) {
                          return dropdownItems
                              .map<Widget>((Map<String, dynamic> item) {
                            return Text(
                              item['city'],
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
                    }),
          ],
        ),
      ),
    );
  }
}

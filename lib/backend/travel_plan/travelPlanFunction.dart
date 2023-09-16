import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';

Future<List<List<Map<String, dynamic>>>> planTravel(List<dynamic>? cruisines,
    List<dynamic>? hangouts, Map<String, dynamic> travelPlanParams) async {
  // Build 2D array for itenerary storage based on days
  double lat = double.parse(travelPlanParams['lat']),
      long = double.parse(travelPlanParams['long']);
  List<List<Map<String, dynamic>>> travelItinerary =
      createDynamicColumn2DArray(travelPlanParams['days']);
  List<Map<String, dynamic>> selectHotels =
      await fetchPlaces('Hotel', lat, long);
  List<Map<String, dynamic>> hangoutPlaces =
      await FirebaseService.fetchHangout();
  try {
    // Hotel to stay
    Map<String, dynamic> selectedHotel = evaluateParameters(selectHotels);
    for (int x = 0; x < travelPlanParams['days']; x++) {
      String currentTime = travelPlanParams['startTime'];
      String endTime = travelPlanParams['endTime'];
      List<Map<String, dynamic>> travelItineraryPerDay = [];
      travelItineraryPerDay.add(selectedHotel);
      bool hadBreakfast = false;
      bool hadLunch = false;
      bool hadDinner = false;
      while (true) {
        if (isTimeInRange(currentTime, "07:00", "09:00") &&
            hadBreakfast == false) {
          String hangOutPlace = getRandomElement(cruisines!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay.add(await getPlace(getPlaceParams));
          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', 'Restaurant')!);
          hadBreakfast = true;
        } else if (isTimeInRange(currentTime, "11:00", "13:00") &&
            hadLunch == false) {
          String hangOutPlace = getRandomElement(cruisines!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay.add(await getPlace(getPlaceParams));
          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', 'Restaurant')!);
          hadLunch = true;
        } else if (isTimeInRange(currentTime, "18:00", "20:00") &&
            hadDinner == false) {
          String hangOutPlace = getRandomElement(cruisines!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay.add(await getPlace(getPlaceParams));
          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', 'Restaurant')!);
          hadDinner = true;
        } else {
          String hangOutPlace = getRandomElement(hangouts!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay.add(await getPlace(getPlaceParams));
          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', hangOutPlace)!);
        }

        if (isTime1BeforeTime2(currentTime, endTime) == false) {
          String hangOutPlace = getRandomElement(hangouts!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'long': long,
            'lat': lat,
            'currentTime': endTime,
          };
          travelItineraryPerDay.add(await getPlace(getPlaceParams));
          travelItinerary[x] = travelItineraryPerDay;
          break;
        }
      }
    }
    return travelItinerary;
  } catch (e) {
    debugPrint(e.toString());
  }
  return travelItinerary;
}

Future<Map<String, dynamic>> getPlace(
    Map<String, dynamic> fetchPlaceParams) async {
  List<Map<String, dynamic>>? tempList;
  Map<String, dynamic>? temp;
  tempList = await fetchPlaces(fetchPlaceParams['hangoutPlace'],
      fetchPlaceParams['lat'], fetchPlaceParams['long']);
  temp = evaluateParameters(tempList);
  temp!['timeSchedule'] = fetchPlaceParams['currentTime'];
  return temp;
}

List<List<Map<String, dynamic>>> createDynamicColumn2DArray(int rows) {
  List<List<Map<String, dynamic>>> array2D = List.generate(rows, (i) => []);
  return array2D;
}

dynamic getRandomElement(List list) {
  if (list.isEmpty) {
    throw ArgumentError("The list must not be empty");
  }
  final random = Random();
  final randomIndex = random.nextInt(list.length);
  return list[randomIndex];
}

bool isTime1BeforeTime2(String time1, String time2) {
  final inputFormat = DateFormat('HH:mm');
  DateTime dateTime1 = inputFormat.parse(time1);
  DateTime dateTime2 = inputFormat.parse(time2);

  return dateTime1.isBefore(dateTime2);
}

bool isTimeInRange(String timeToCheck, String startTime, String endTime) {
  final inputFormat = DateFormat('HH:mm');
  DateTime time = inputFormat.parse(timeToCheck);
  DateTime start = inputFormat.parse(startTime);
  DateTime end = inputFormat.parse(endTime);

  return time.isAfter(start) && time.isBefore(end);
}

Future<List<Map<String, dynamic>>> fetchPlaces(
    String find, double latitude, double longtitude) async {
  List<Map<String, dynamic>> places = [];
  try {
    GoogleMapsPlaces _places =
        GoogleMapsPlaces(apiKey: 'AIzaSyC_tT3e0KsDdyQ0VhjRi8-xhlFsdUztbB0');
    PlacesSearchResponse response = await _places.searchByText(find,
        location: Location(lat: latitude, lng: longtitude));
    for (var result in response.results) {
      if (result.permanentlyClosed == false) {
        List<String> splitAddress = result.formattedAddress!.split(',');
        Map<String, dynamic> placeResult = {
          "businessName": result.name,
          "address": result.formattedAddress,
          "city": splitAddress[2],
          "rating": result.rating,
          "openingHours": result.openingHours,
          "displayImage": result.icon,
          "business_status": result.permanentlyClosed,
          "timeSchedule": ""
        };
        places.add(placeResult);
      }
      return places;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return places;
}

String addMinutesToTime(String time, int minutesToAdd) {
  List<String> parts = time.split(':');

  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);

  // Add minutesToAdd to existing minutes
  minutes += minutesToAdd;

  // Handle carry-over from minutes to hours
  hours += minutes ~/ 60;
  minutes %= 60;

  // Handle carry-over from hours to the next day
  hours %= 24;

  String result =
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

  return result;
}

int? getAveTimeSpent(
    List<Map<String, dynamic>> list, String key, String targetValue) {
  for (var map in list) {
    if (map.containsKey(key) && map[key] == targetValue) {
      return map['ave_time_mins'];
    }
  }
  return null; // Return null if no match is found
}

evaluateParameters(List<Map<String, dynamic>> places) {
  Map<String, dynamic> highestRatedPlace = places.reduce((a, b) {
    return (a['rating'] > b['rating']) ? a : b;
  });
  return highestRatedPlace;
}

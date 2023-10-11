import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';

Future<List<List<Map<String, dynamic>>>> planTravel(List<dynamic>? cruisines,
    List<dynamic>? hangouts, Map<String, dynamic> travelPlanParams) async {
  // Build 2D array for itenerary storage based on days
  double lat = double.parse(travelPlanParams['lat']),
      long = double.parse(travelPlanParams['long']);
  List<List<Map<String, dynamic>>> travelItinerary =
      createDynamicColumn2DArray(travelPlanParams['days']);
  List<Map<String, dynamic>> selectHotels =
      await fetchPlaces('Hotel', lat, long, travelPlanParams['city'], 'Hotel');
  List<Map<String, dynamic>> hangoutPlaces =
      await FirebaseService.fetchHangout();
  try {
    // Hotel to stay
    Map<String, dynamic> selectedHotel =
        evaluateParameters(selectHotels, travelItinerary, null);
    for (int x = 0; x < travelPlanParams['days']; x++) {
      String currentTime = travelPlanParams['startTime'][x];
      String endTime = travelPlanParams['endTime'][x];
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
            'findWhat': 'Restaurant',
            'city': travelPlanParams['city'],
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay
              .add(await getPlace(getPlaceParams, travelItinerary));

          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', 'Restaurant')!);
          hadBreakfast = true;
        } else if (isTimeInRange(currentTime, "11:00", "13:00") &&
            hadLunch == false) {
          String hangOutPlace = getRandomElement(cruisines!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'findWhat': 'Restaurant',
            'city': travelPlanParams['city'],
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay
              .add(await getPlace(getPlaceParams, travelItinerary));
          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', 'Restaurant')!);
          hadLunch = true;
        } else if (isTimeInRange(currentTime, "18:00", "20:00") &&
            hadDinner == false) {
          String hangOutPlace = getRandomElement(cruisines!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'city': travelPlanParams['city'],
            'findWhat': 'Restaurant',
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay
              .add(await getPlace(getPlaceParams, travelItinerary));
          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', 'Restaurant')!);
          hadDinner = true;
        } else {
          String hangOutPlace = getRandomElement(hangouts!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'city': travelPlanParams['city'],
            'findWhat': 'Hangout',
            'long': long,
            'lat': lat,
            'currentTime': currentTime,
          };
          travelItineraryPerDay
              .add(await getPlace(getPlaceParams, travelItinerary));
          currentTime = addMinutesToTime(currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout', hangOutPlace)!);
        }

        if (isTime1BeforeTime2(currentTime, endTime) == false) {
          String hangOutPlace = getRandomElement(hangouts!);
          Map<String, dynamic> getPlaceParams = {
            'hangoutPlace': hangOutPlace,
            'city': travelPlanParams['city'],
            'findWhat': 'Hangout',
            'long': long,
            'lat': lat,
            'currentTime': endTime,
          };
          travelItineraryPerDay
              .add(await getPlace(getPlaceParams, travelItinerary));
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

Future<Map<String, dynamic>> getPlace(Map<String, dynamic> fetchPlaceParams,
    List<List<Map<String, dynamic>>> travelItinerary) async {
  List<Map<String, dynamic>>? tempList;
  Map<String, dynamic>? temp;
  debugPrint(fetchPlaceParams.toString());
  debugPrint(travelItinerary.toString());
  tempList = await fetchPlaces(
      fetchPlaceParams['hangoutPlace'],
      fetchPlaceParams['lat'],
      fetchPlaceParams['long'],
      fetchPlaceParams['city'],
      fetchPlaceParams['findWhat']);

  temp = evaluateParameters(
      tempList, travelItinerary, fetchPlaceParams['currentTime']);

  if (temp == null) {}
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

Future<List<Map<String, dynamic>>> fetchPlaces(String find, double latitude,
    double longtitude, String city, String findWhat) async {
  List<Map<String, dynamic>> places = [];
  List<Map<String, dynamic>> dataBusiness = [];
  Map<String, dynamic> placeResult = {
    "businessName": "",
    "address": "",
    "city": "",
    "rating": "",
    "openingHours": "",
    "displayImage": "",
    "business_status": "",
    "timeSchedule": "",
    "placeID": "",
  };
  try {
    if (findWhat == 'Hangout') {
      dataBusiness = await getBusinessesQuery(find, city, 'Hangout');
    } else if (findWhat == 'Restaurant') {
      dataBusiness = await getBusinessesQuery(find, city, 'Restaurant');
    }
    if (dataBusiness.isNotEmpty) {
      debugPrint("true");
      for (int index = 0; index < dataBusiness.length; index++) {
        debugPrint(" ${index}: ${dataBusiness[index]['businessName']}");

        // placeResult = {
        //   "businessName": dataBusiness[index]['businessName'],
        //   "address":
        //       "${dataBusiness[index]['businessName']['building']} ${dataBusiness[index]['businessName']['street']} ${dataBusiness[index]['businessName']['city']} ${dataBusiness[index]['businessName']['country']}",
        //   "city": dataBusiness[index]['businessName']['city'],
        //   "rating": dataBusiness[index]['rating'],
        //   "openingHours": "",
        //   "displayImage": dataBusiness[index]['businessImages']['image1'],
        //   "business_status": dataBusiness[index]['status'],
        //   "timeSchedule": "",
        //   "placeID": dataBusiness[index]['placeID'],
        // };

        // places.add(placeResult);
      }
    } else {
      debugPrint("false");
      String? displayImage, photoReference;
      dynamic openingHours;
      GoogleMapsPlaces _places =
          GoogleMapsPlaces(apiKey: 'AIzaSyC_tT3e0KsDdyQ0VhjRi8-xhlFsdUztbB0');
      PlacesSearchResponse response = await _places.searchByText(find,
          location: Location(lat: latitude, lng: longtitude));
      String baseURL = "https://maps.googleapis.com/maps/api/place/photo";
      for (var result in response.results) {
        if (result.permanentlyClosed == false) {
          List<String> splitAddress = result.formattedAddress!.split(',');
          if (result.photos.isEmpty) {
            displayImage = result.icon;
          } else {
            photoReference = result.photos[0].photoReference;
            displayImage =
                "$baseURL?maxwidth=400&maxheight=400&photoreference=$photoReference&key=AIzaSyC_tT3e0KsDdyQ0VhjRi8-xhlFsdUztbB0";
          }
          if (result.openingHours is Object) {
            openingHours = null;
          } else {
            openingHours = result.openingHours.toString();
          }
          placeResult = {
            "businessName": result.name,
            "address": result.formattedAddress,
            "city": splitAddress[2],
            "rating": result.rating,
            "openingHours": openingHours,
            "displayImage": displayImage,
            "business_status": result.permanentlyClosed,
            "timeSchedule": "",
            "placeID": result.placeId,
          };
          places.add(placeResult);
        }
      }
    }
    places.sort((a, b) => b['rating'].compareTo(a['rating']));
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

evaluateParameters(List<Map<String, dynamic>> places,
    List<List<Map<String, dynamic>>> travelItinerary, String? currentTime) {
  Map<String, dynamic>? chosenPlace;
  if (travelItinerary.isEmpty) {
    // for hotel
    return places[0];
  }
  bool traverseToItenerary(Map<String, dynamic> place,
      List<List<Map<String, dynamic>>> travelItinerary) {
    // LOCAL FUNCTION
    bool flag = false;
    for (int x = 0; x < travelItinerary.length; x++) {
      for (int y = 0; y < travelItinerary[x].length; y++) {
        if (place['placeID'] == travelItinerary[x][y]['placeID']) {
          flag = true;
          break;
        }
      }
    }
    return flag;
  }

  int i = 0;
  while (i < places.length) {
    if (traverseToItenerary(places[i], travelItinerary) == false) {
      chosenPlace = places[i];
      break;
    }
    i++;
  }
  return chosenPlace;
}

Future<bool> iteneraryToDatabase(List<List<Map<String, dynamic>>> itenerary,
    Map<String, dynamic> itenerarySearchParams) async {
  bool result = false;
  Map<String, dynamic> iteneraryData = {
    "city": itenerarySearchParams['city'],
    "day": itenerarySearchParams['dates'].length,
    "dates": [],
    "itenerary": [],
    "createdAt": DateTime.now(),
    "ownedBy": itenerarySearchParams['userID']
  };
  for (int i = 0; i < itenerarySearchParams['dates'].length; i++) {
    iteneraryData['dates'].add(itenerarySearchParams['dates'][i]);
  }
  for (int x = 0; x < itenerary.length; x++) {
    for (int y = 0; y < itenerary[x].length; y++) {
      iteneraryData['itenerary'].add(itenerary[x][y]);
    }
  }
  await saveItenerary(iteneraryData).then((value) {
    if (value == 'success') {
      result = true;
    }
  });
  return result;
}

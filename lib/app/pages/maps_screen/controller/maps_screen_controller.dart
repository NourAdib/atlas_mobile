import 'dart:developer';

import 'package:atlas_mobile/app/model/event_goal.model.dart';
import 'package:atlas_mobile/app/services/clue/clue.service.dart';
import 'package:atlas_mobile/app/services/event/event.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

import '../../../model/event.model.dart';
import '../../../services/memories/memories.service.dart';
import '../../../utility/get_location.dart';
import '../../../utility/shared_preferences.dart';
import '../../../utility/snackbar.dart';
import '../../../widgets/map_popup.dart';

class MapsScreenController extends GetxController {
  var currentPosition = LatLng(0, 0).obs;
  var markers = <Marker>[].obs;
  var currentMarker = <Marker>[].obs;
  var data = [].obs;
  var goalEventName = <String>[].obs;

  var selectedValue = "memories".obs;

  // Dropdown menu items
  final List<DropdownMenuItem<String>> dropdownMenuItems = [
    const DropdownMenuItem<String>(
      value: "memories",
      child: Text("Memories"),
    ),
    const DropdownMenuItem<String>(
      value: "clues",
      child: Text("Clues"),
    ),
    const DropdownMenuItem<String>(
      value: "events",
      child: Text("Events"),
    ),
    const DropdownMenuItem<String>(
      value: "goals",
      child: Text("Goals"),
    ),
  ];

  late final MapController mapController;
  late final PopupController popupLayerController;

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    popupLayerController = PopupController();
  }

  /// This function is called when the user selects a dropdown menu item
  void startUp(isLoading) async {
    toggleLoading(isLoading);

    popupLayerController.hideAllPopups();
    data.value.clear();
    currentMarker.value.clear();
    markers.value.clear();
    goalEventName.value.clear();

    await locationService();

    // Get data from the selected dropdown menu item
    if (selectedValue.value == "memories") {
      await getMemories();
    } else if (selectedValue.value == "clues") {
      await getClues();
    } else if (selectedValue.value == "events") {
      await getEvents();
    } else if (selectedValue.value == "goals") {
      await getGoals();
    }

    await addMarkers();
    await modifyMarkers();

    toggleLoading(isLoading);
  }

  /// This function gets the current location of the user
  locationService() async {
    var tmp = await LocationService.getCurrentLocation();
    currentPosition.value = LatLng(tmp!.latitude, tmp.longitude);
  }

  /// This function gets memories from the API
  Future<void> getMemories() async {
    final dio = Dio();
    final memoriesService = MemoriesService(dio);

    // Create a request object
    final MemoriesRequest memoriesRequest = MemoriesRequest();

    // Set the latitude and longitude of the request object
    memoriesRequest.latitude = currentPosition.value.latitude.toString();
    memoriesRequest.longitude = currentPosition.value.longitude.toString();

    // Get the access token from shared preferences
    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    // Get the memories from the API
    await memoriesService
        .getMemories('Bearer $accessToken', memoriesRequest)
        .then((response) {
      // Add the memories to the data list
      data.value.addAll(response.memories!);

      // If no memories are found, show a snackbar
      if (data.value.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Memories not found", "No nearby memories found");
      }
    }).catchError((error) {
      log(error.response.toString());
    });
  }

  /// This function gets clues from the API
  Future<void> getClues() async {
    final dio = Dio();
    final clueService = CluesService(dio);

    // Create a request object
    final ProximityCluesRequest proximityCluesRequest = ProximityCluesRequest();

    // Set the latitude and longitude of the request object
    proximityCluesRequest.latitude = currentPosition.value.latitude.toString();
    proximityCluesRequest.longitude =
        currentPosition.value.longitude.toString();

    // Get the access token from shared preferences
    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    // Get the clues from the API
    await clueService
        .getProximityClues('Bearer $accessToken', proximityCluesRequest)
        .then((response) {
      // Add the clues to the data list
      data.value.addAll(response);

      // If no clues are found, show a snackbar
      if (data.value.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Clues not found", "No nearby clues found");
      }
    }).catchError((error) {
      log(error.response.toString());
    });
  }

  /// This function gets events from the API
  Future<void> getEvents() async {
    final dio = Dio();
    final eventService = EventsService(dio);

    // Create a request object
    final ProximityEventsRequest proximityEventsRequest =
        ProximityEventsRequest();

    // Set the latitude and longitude of the request object
    proximityEventsRequest.latitude = currentPosition.value.latitude.toString();
    proximityEventsRequest.longitude =
        currentPosition.value.longitude.toString();

    // Get the access token from shared preferences
    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    // Get the events from the API
    await eventService
        .getProximityEvents('Bearer $accessToken', proximityEventsRequest)
        .then((response) {
      // Add the events to the data list
      data.value.addAll(response);

      // If no events are found, show a snackbar
      if (data.value.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Events not found", "No nearby events found");
      }
    }).catchError((error) {
      log(error.response.toString());
    });
  }

  /// This function gets goals from the API
  Future<void> getGoals() async {
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    // Get the access token from shared preferences
    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    // Get the events from the API
    await eventsService
        .getJoinedEvents('Bearer $accessToken', 1)
        .then((response) {
      setGoals(response.events!);
    }).catchError((error) {
      log(error.toString());
    });
  }

  /// This function sets the goals from joined events nearby
  Future<void> setGoals(List<Event> events) async {
    for (Event event in events) {
      // distance between device and goal less than 10
      if (Geolocator.distanceBetween(
              currentPosition.value.latitude,
              currentPosition.value.longitude,
              double.parse(event.goal!.latitude!),
              double.parse(event.goal!.longitude!)) <
          10.0) {
        // Add the goal to the data list
        data.value.add(event.goal!);

        // Add the event name to the goalEventName list
        goalEventName.value.add(event.name!);
      }
    }

    // If no goals are found, show a snackbar
    if (data.value.isEmpty) {
      SnackBarService.showErrorSnackbar(
          "Goals not found", "No nearby goals found");
    }
  }

  /// This function adds markers to the map
  addMarkers() async {
    // Add the current location marker to the currentMarker list
    currentMarker.value.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: currentPosition.value,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 50,
        ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      ),
    );

    // Add the markers to the markers list
    for (var i = 0; i < data.length; i++) {
      markers.value.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(
            double.parse(data[i].latitude!),
            double.parse(data[i].longitude!),
          ),
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
      );
    }
  }

  /// This function modifies the markers to avoid overlapping
  modifyMarkers() async {
    // Create a list of pairs to store the latitude and longitude of the markers
    List<Pair> pairs = [];

    // Add the latitude and longitude of the current location marker to the list
    for (var i = 0; i < markers.value.length; i++) {
      Marker tmp = markers.value[i];

      // Add the latitude and longitude of the marker to the list
      for (var j = 0; j < data.length; j++) {
        if (i != j) {
          Marker tmp2 = markers.value[j];

          // Calculate the distance between the two markers
          double distance = Geolocator.distanceBetween(tmp.point.latitude,
              tmp.point.longitude, tmp2.point.latitude, tmp2.point.longitude);

          // If they are overlapping, modify the marker
          if (distance == 0) {
            var lat = tmp.point.latitude;
            var lon = tmp.point.longitude;

            // Modify the latitude
            while (true) {
              lon += 0.0001;

              // If the new latitude and longitude is not in the list, break
              if (!pairs.contains(Pair(lat, lon))) {
                break;
              }
            }

            // Modify the marker
            markers.value[i] = Marker(
                width: tmp.width,
                height: tmp.height,
                point: LatLng(lat, lon),
                builder: (ctx) =>
                    const Icon(Icons.location_on, color: Colors.blue, size: 40),
                anchorPos: AnchorPos.align(AnchorAlign.top));
          }
        }
      }

      // Add the latitude and longitude of the marker to the list
      pairs.add(Pair(
          markers.value[i].point.latitude, markers.value[i].point.longitude));
    }
  }

  /// This function returns the popup for the marker
  Widget onTapMarker(Marker marker) {
    if (selectedValue.value == 'memories') {
      // Memory popup
      return MemoryMarkerPopup(
          memory: data.value[markers.value.indexOf(marker)]);
    } else if (selectedValue.value == 'clues') {
      // Clue popup
      return ClueMarkerPopup(clue: data.value[markers.value.indexOf(marker)]);
    } else if (selectedValue.value == 'events') {
      // Event popup
      return EventMarkerPopup(event: data.value[markers.value.indexOf(marker)]);
    } else {
      // Goal popup
      return GoalMarkerPopup(
          goal: data.value[markers.value.indexOf(marker)],
          eventName: goalEventName.value[markers.value.indexOf(marker)]);
    }
  }

  /// This function is called when the dropdown value is changed
  onDropdownChanged(String? value, isLoading) {
    if (selectedValue.value != value) {
      // Hide all popups
      popupLayerController.hideAllPopups();

      // Clear the markers list
      selectedValue.value = value!;

      // Get new markers from the API based on the selected value
      startUp(isLoading);
    }
  }

  void toggleLoading(isLoading) {
    isLoading.value = !isLoading.value;
  }
}

/// This class is used to store the latitude and longitude of a marker
class Pair {
  final double latitude;
  final double longitude;

  Pair(this.latitude, this.longitude);

  @override
  bool operator ==(other) {
    return other is Pair &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

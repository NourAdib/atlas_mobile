import 'dart:developer';

import 'package:atlas_mobile/app/services/clue/clue.service.dart';
import 'package:atlas_mobile/app/services/event/event.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

import '../../../services/memories/memories.service.dart';
import '../../../utility/get_location.dart';
import '../../../utility/shared_preferences.dart';
import '../../../utility/snackbar.dart';

class MapsScreenController extends GetxController {
  var currentPosition = LatLng(0, 0).obs;
  var markers = <Marker>[].obs;
  var currentMarker = <Marker>[].obs;
  var data = [].obs;

  var selectedValue = "memories".obs;

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
  ];

  late final MapController mapController;
  late final PopupController popupLayerController;

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    popupLayerController = PopupController();
  }

  void startUp(isLoading) async {
    toggleLoading(isLoading);

    data.value.clear();
    currentMarker.value.clear();
    markers.value.clear();

    await locationService();

    if (selectedValue.value == "memories") {
      await getMemories();
    } else if (selectedValue.value == "clues") {
      await getClues();
    } else if (selectedValue.value == "events") {
      await getEvents();
    }

    await addMarkers();
    await modifyMarkers();

    toggleLoading(isLoading);
  }

  locationService() async {
    var tmp = await LocationService.getCurrentLocation();
    currentPosition.value = LatLng(tmp!.latitude, tmp.longitude);
  }

  Future<void> getMemories() async {
    final dio = Dio();
    final memoriesService = MemoriesService(dio);

    final MemoriesRequest memoriesRequest = MemoriesRequest();
    memoriesRequest.latitude = currentPosition.value.latitude.toString();
    memoriesRequest.longitude = currentPosition.value.longitude.toString();

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    await memoriesService
        .getMemories('Bearer $accessToken', memoriesRequest)
        .then((response) {
      data.value.addAll(response.memories!);
      if (data.value.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Memories not found", "No nearby memories found");
      }
      log("Memories: ${data.value.length}");
    }).catchError((error) {
      log(error.response.toString());
    });
  }

  Future<void> getClues() async {
    final dio = Dio();
    final clueService = CluesService(dio);

    final ProximityCluesRequest proximityCluesRequest = ProximityCluesRequest();
    proximityCluesRequest.latitude = currentPosition.value.latitude.toString();
    proximityCluesRequest.longitude =
        currentPosition.value.longitude.toString();

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    await clueService
        .getProximityClues('Bearer $accessToken', proximityCluesRequest)
        .then((response) {
      data.value.addAll(response);
      if (data.value.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Clues not found", "No nearby clues found");
      }
      log("Clues: ${data.value.length}");
    }).catchError((error) {
      log(error.response.toString());
    });
  }

  Future<void> getEvents() async {
    final dio = Dio();
    final eventService = EventsService(dio);

    final ProximityEventsRequest proximityEventsRequest =
        ProximityEventsRequest();

    proximityEventsRequest.latitude = currentPosition.value.latitude.toString();
    proximityEventsRequest.longitude =
        currentPosition.value.longitude.toString();

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    await eventService
        .getProximityEvents('Bearer $accessToken', proximityEventsRequest)
        .then((response) {
      data.value.addAll(response);
      if (data.value.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Events not found", "No nearby events found");
      }
      log("Events: ${data.value.length}");
    }).catchError((error) {
      log(error.response.toString());
    });
  }

  addMarkers() async {
    currentMarker.value.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: currentPosition.value,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      ),
    );

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

  modifyMarkers() async {
    List<Pair> pairs = [];

    for (var i = 0; i < markers.value.length; i++) {
      Marker tmp = markers.value[i];

      for (var j = 0; j < data.length; j++) {
        if (i != j) {
          Marker tmp2 = markers.value[j];

          double distance = Geolocator.distanceBetween(tmp.point.latitude,
              tmp.point.longitude, tmp2.point.latitude, tmp2.point.longitude);

          if (distance == 0) {
            var lat = tmp.point.latitude;
            var lon = tmp.point.longitude;
            while (true) {
              lon += 0.0001;

              if (!pairs.contains(Pair(lat, lon))) {
                break;
              }
            }
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
      pairs.add(Pair(
          markers.value[i].point.latitude, markers.value[i].point.longitude));
    }
  }

  void toggleLoading(isLoading) {
    isLoading.value = !isLoading.value;
  }
}

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

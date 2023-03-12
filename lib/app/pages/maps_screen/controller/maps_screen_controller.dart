import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../utility/get_location.dart';

class MapsScreenController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;
  Position? currentPosition;
  var markers = <Marker>[];
  final mapController = MapController();

  getMemories(isLoading) async {
    toggleLoading(isLoading);
    if (markers.isNotEmpty) {
      markers.clear();
    }
    currentPosition = await LocationService.getCurrentLocation();
    markers.add(Marker(
      width: 80,
      height: 80,
      point: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      builder: (ctx) => Container(
        key: const Key('blue'),
        child: const FlutterLogo(),
      ),
    ));
    toggleLoading(isLoading);
  }

  void toggleLoading(isLoading) {
    isLoading.value = !isLoading.value;
  }
}

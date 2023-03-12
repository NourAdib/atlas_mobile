import 'dart:math';
import 'dart:developer' as dev;

import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:atlas_mobile/app/services/memories/memories.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:atlas_mobile/app/widgets/memory_details/memory_details.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:dio/dio.dart';

import 'package:get/get.dart';

class ArScreenController extends GetxController {
  var memories = [].obs;

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  Position? currentPosition;

  @override
  void dispose() {
    arSessionManager!.dispose();
    super.dispose();
  }

  void exitAR() {
    arSessionManager?.dispose();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> createNodes() async {
    for (var i = 0; i < memories.length; i++) {
      ARNode newNode = ARNode(
        type: NodeType.webGLB,
        name: i.toString(),
        uri: "https://github.com/xzodia1000/test-glb-gltf/raw/master/pin.glb",
        scale: Vector3(0.1, 0.1, 0.1),
        // rotation: Vector4(0.0, 0.0, 0.0, 0.0),
        position: getPosition(double.parse(memories[i].latitude),
            double.parse(memories[i].longitude)),
      );

      await arObjectManager!.addNode(newNode);
    }
  }

  Vector3 getPosition(double lat, double long) {
    double relativeX =
        (long - currentPosition!.longitude) * (40075.704 / 360.0);
    double relativeY = log(tan(lat * pi / 180.0)) -
        log(tan(currentPosition!.latitude * pi / 180.0));
    relativeY *= (40075.704 / (2 * pi));

    return Vector3(relativeX, relativeY, 0);
  }

  Future<void> getMemories(isLoading) async {
    toggleLoading(isLoading);
    await getCurrentLocation();
    final dio = Dio();
    final memoriesService = MemoriesService(dio);

    final MemoriesRequest memoriesRequest = MemoriesRequest();
    memoriesRequest.latitude = currentPosition!.latitude.toString();
    memoriesRequest.longitude = currentPosition!.longitude.toString();

    dev.log("stuff: ${memoriesRequest.toJson().toString()}");

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    memoriesService
        .getMemories('Bearer $accessToken', memoriesRequest)
        .then((response) {
      memories.value.addAll(response.memories!);
      toggleLoading(isLoading);
      if (memories.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Memories not found", "No nearby memories found");
      }
    }).catchError((error) {
      dev.log(error.response.toString());
    });
  }

  toggleLoading(isLoading) {
    isLoading.value = !isLoading.value;
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showAnimatedGuide: false,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arObjectManager!.onNodeTap = (nodes) {
      exitAR();
      Get.to(() => MemoryDetailsScreen(memory: memories[int.parse(nodes[0])]));
    };

    createNodes();
  }
}

import 'dart:developer';
import 'dart:math' as Math;

import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:atlas_mobile/app/services/memories/memories.service.dart';
import 'package:atlas_mobile/app/utility/get_location.dart';
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

  startUp(isLoading) async {
    toggleLoading(isLoading);
    memories.value.clear();
    await getCurrentLocation();
    await getMemories();
    toggleLoading(isLoading);
  }

  void exitAR() {
    arSessionManager?.dispose();
  }

  Future<void> getCurrentLocation() async {
    currentPosition = await LocationService.getCurrentLocation();
  }

  Future<void> createNodes() async {
    for (var i = 0; i < memories.length; i++) {
      ARNode newNode = ARNode(
        type: NodeType.webGLB,
        name: i.toString(),
        uri: "https://github.com/xzodia1000/test-glb-gltf/raw/master/pin.glb",
        scale: Vector3(0.1, 0.1, 0.1),
        rotation: Vector4(1.0, 0.0, 0.0, 0.0),
        position: getPosition(0.0, 0.0, i),
      );

      newNode.rotationFromQuaternion =
          Quaternion.axisAngle(Vector3(1.0, 0.0, 0.0), radians(-90));

      await arObjectManager!.addNode(newNode);
    }
  }

  Vector3 getPosition(double lat, double long, i) {
    final Vector3 earthCenter = Vector3.zero();

    double x = Math.cos(lat) * Math.cos(long);
    double y = Math.cos(lat) * Math.sin(long);
    double z = Math.sin(lat);

    Vector3 vectorCoordinates = Vector3(x, y, z);
    vectorCoordinates.normalize();

    Vector3 finalVector = vectorCoordinates - earthCenter;

    finalVector =
        i % 2 == 0 ? Vector3(0.0, 0.0, 1.0 * i) : Vector3(1.0 * i, 0.0, 0.0);

    return finalVector;
  }

  Future<void> getMemories() async {
    final dio = Dio();
    final memoriesService = MemoriesService(dio);

    final MemoriesRequest memoriesRequest = MemoriesRequest();
    memoriesRequest.latitude = currentPosition!.latitude.toString();
    memoriesRequest.longitude = currentPosition!.longitude.toString();

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    await memoriesService
        .getMemories('Bearer $accessToken', memoriesRequest)
        .then((response) {
      memories.value.addAll(response.memories!);
      if (memories.value.isEmpty) {
        SnackBarService.showErrorSnackbar(
            "Memories not found", "No nearby memories found");
      }
    }).catchError((error) {
      log(error.response.toString());
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
      Get.to(() => MemoryDetailsScreen(memory: memories[int.parse(nodes[0])]));
    };

    this.arSessionManager!.onPlaneOrPointTap = (nodes) {};
    createNodes();
  }
}

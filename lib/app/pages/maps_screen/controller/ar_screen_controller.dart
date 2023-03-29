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

  /// This function is called when the user presses the button to start the AR session
  startUp(isLoading) async {
    toggleLoading(isLoading);
    memories.value.clear();
    await getCurrentLocation();
    await getMemories();
    toggleLoading(isLoading);
  }

  /// This function is called when the user exits the AR session
  void exitAR() {
    arSessionManager?.dispose();
  }

  /// This function gets the current location of the user
  Future<void> getCurrentLocation() async {
    currentPosition = await LocationService.getCurrentLocation();
  }

  /// This function creates the nodes that will be displayed in the AR session
  Future<void> createNodes() async {
    // Create a node for each memory
    for (var i = 0; i < memories.length; i++) {
      ARNode newNode = ARNode(
        type: NodeType.webGLB,
        name: i.toString(),
        uri: "https://github.com/xzodia1000/test-glb-gltf/raw/master/pin.glb",
        scale: Vector3(0.1, 0.1, 0.1),
        rotation: Vector4(1.0, 0.0, 0.0, 0.0),
        position: getPosition(0.0, 0.0, i),
      );

      // Rotate the node so that it is facing the user
      newNode.rotationFromQuaternion =
          Quaternion.axisAngle(Vector3(1.0, 0.0, 0.0), radians(-90));

      // Add the node to the AR session
      await arObjectManager!.addNode(newNode);
    }
  }

  /// This function returns the position of the node
  Vector3 getPosition(double lat, double long, i) {
    final Vector3 earthCenter = Vector3.zero();

    // Calculate the vector coordinates of the node
    double x = Math.cos(lat) * Math.cos(long);
    double y = Math.cos(lat) * Math.sin(long);
    double z = Math.sin(lat);

    // Normalize the vector coordinates
    Vector3 vectorCoordinates = Vector3(x, y, z);
    vectorCoordinates.normalize();

    // Calculate the relative position of the node by comparing it to the center of the earth
    Vector3 finalVector = vectorCoordinates - earthCenter;

    // Multiply the vector coordinates by the distance from the center of the earth
    finalVector =
        i % 2 == 0 ? Vector3(0.0, 0.0, 1.0 * i) : Vector3(1.0 * i, 0.0, 0.0);

    // Return the vector coordinates
    return finalVector;
  }

  /// This function gets the memories from the API
  Future<void> getMemories() async {
    final dio = Dio();
    final memoriesService = MemoriesService(dio);

    // Create the request body
    final MemoriesRequest memoriesRequest = MemoriesRequest();

    // Set the latitude and longitude of the user
    memoriesRequest.latitude = currentPosition!.latitude.toString();
    memoriesRequest.longitude = currentPosition!.longitude.toString();

    // Get the access token from shared preferences
    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    // Get the memories from the API
    await memoriesService
        .getMemories('Bearer $accessToken', memoriesRequest)
        .then((response) {
      // Add the memories to the list
      memories.value.addAll(response.memories!);
      if (memories.value.isEmpty) {
        // Show a snackbar if no memories are found
        SnackBarService.showErrorSnackbar(
            "Memories not found", "No nearby memories found");
      }
    }).catchError((error) {
      log(error.response.toString());
    });
  }

  /// This function toggles the loading state
  toggleLoading(isLoading) {
    isLoading.value = !isLoading.value;
  }

  // This function is called when the AR view is created
  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    // Initialize the AR session
    this.arSessionManager!.onInitialize(
          showAnimatedGuide: false,
          handlePans: true,
          handleRotation: true,
        );

    // Initialize the AR object manager
    this.arObjectManager!.onInitialize();

    // This function is called when the user taps on a node
    this.arObjectManager!.onNodeTap = (nodes) {
      // Navigate to the memory details screen
      Get.to(() => MemoryDetailsScreen(memory: memories[int.parse(nodes[0])]));
    };

    // This function is called when the user taps on a plane or point
    this.arSessionManager!.onPlaneOrPointTap = (nodes) {
      // Empty function to prevent errors
    };

    createNodes();
  }
}

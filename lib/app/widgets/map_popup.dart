import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/clue.model.dart';
import '../model/event.model.dart';
import 'event_details/event_details.dart';
import 'memory_details/memory_details.dart';

class MemoryMarkerPopup extends StatelessWidget {
  const MemoryMarkerPopup({Key? key, required this.memory}) : super(key: key);
  final Memory memory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MemoryDetailsScreen(memory: memory));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          height: 10 * 16,
          width: 10 * 9,
          imageUrl: memory.imageUrl!,
          fadeInDuration: const Duration(milliseconds: 0),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class ClueMarkerPopup extends StatelessWidget {
  const ClueMarkerPopup({Key? key, required this.clue}) : super(key: key);
  final Clue clue;

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

    return InkWell(
      onTap: () {
        Get.defaultDialog(
          title: clue.event!.name!,
          middleText: "Clue: ${clue.text!}",
          confirm: ElevatedButton(
            onPressed: () async {
              Get.back();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF182335),
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(width * 0.46, height * 0.07),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        );
      },
      child: Container(
        height: 100,
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffFFF6E9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF182335), width: 5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Clue: ${clue.text!}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF182335)),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Event: ${clue.event!.name!}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF182335)),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class EventMarkerPopup extends StatelessWidget {
  const EventMarkerPopup({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => EventDetailsScreen(event: event));
      },
      child: Container(
        height: 100,
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffFFF6E9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF182335), width: 5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Event: ${event.name!}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF182335)),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "User: ${event.creator!.username!}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF182335)),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

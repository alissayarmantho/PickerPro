import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/models/waypoint.dart';
import 'package:picker_pro/services/waypoints.dart';

class WaypointController extends GetxController {
  var waypoints = Waypoints(waypoints: {"random": []}).obs;
  var isLoading = false.obs;

  void fetchWaypoints() async {
    isLoading(true);

    try {
      await WaypointService.fetchWaypoints().then((res) {
        waypoints.value = res;
        Get.snackbar(
          "Success",
          "Successfully Getting All Waypoints",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Getting All Waypoints",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Successfully Getting All Waypoints",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }
}

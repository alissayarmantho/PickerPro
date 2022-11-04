import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/models/batch.dart';
import 'package:picker_pro/services/batch.dart';

class BatchController extends GetxController {
  var batches = <Batch>[].obs;
  var isLoading = false.obs;
  var activeBatchIndex = 0.obs;
  var activeItemIndex = 0.obs;

  void setActiveBatchIndex(int value) {
    activeBatchIndex.value = value;
  }

  void setActiveIndex(int value) {
    activeItemIndex.value = value;
  }

  void nextBatchIndex() {
    var nextIndex = activeBatchIndex.value + 1;
    if (nextIndex < batches.length) {
      activeItemIndex.value = 0;
      activeBatchIndex.value = nextIndex;
    }
  }

  void prevBatchIndex() {
    var prevIndex = activeBatchIndex.value - 1;
    if (prevIndex >= 0) {
      activeItemIndex.value = 0;
      activeBatchIndex.value = prevIndex;
    }
  }

  void fetchBatches() async {
    isLoading(true);

    try {
      await BatchService.fetchBatch().then((res) {
        batches.value = res;
        Get.snackbar(
          "Success",
          "Successfully Getting All Batches",
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
          "Successfully Getting All Batches",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }

  void updateBinNumber(int? val) async {
    if (val == null) {
      return;
    }
    isLoading(true);
    batches[activeBatchIndex.value].items[activeItemIndex.value].binNo = val;
    try {
      await BatchService.updateBinNumber(
              name: batches[activeBatchIndex.value]
                  .items[activeItemIndex.value]
                  .name,
              binNo: batches[activeBatchIndex.value]
                  .items[activeItemIndex.value]
                  .binNo)
          .then((res) {
        batches.value = res;
        Get.snackbar(
          "Success",
          "Successfully Updated Bin Number",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Updating Bin Number",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Successfully Updated Bin Number",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }

  void updateItemNotes({required String text}) async {
    isLoading(true);
    batches[activeBatchIndex.value].items[activeItemIndex.value].notes = text;
    try {
      await BatchService.updateItemNotes(
              name: batches[activeBatchIndex.value]
                  .items[activeItemIndex.value]
                  .name,
              notes: text)
          .then((res) {
        batches.value = res;
        Get.snackbar(
          "Success",
          "Successfully Updated Item Notes",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Updating Item Notes",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Successfully Updated Item Notes",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }

  void postItemPicked() async {
    isLoading(true);
    batches[activeBatchIndex.value].items[activeItemIndex.value].isPicked =
        true;
    try {
      await BatchService.postItemPicked().then((res) {
        Get.snackbar(
          "Success",
          "Item Picked Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Posting Item Picked",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Item Picked Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }

  void postBatchPicked() async {
    isLoading(true);
    batches[activeBatchIndex.value].isComplete = true;
    try {
      await BatchService.postItemPicked().then((res) {
        Get.snackbar(
          "Success",
          "Batch Picked Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Posting Batch Picked",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Batch Picked Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }

  void notifyNextPicker() async {
    isLoading(true);

    try {
      await BatchService.sendNotification().then((res) {
        Get.snackbar(
          "Success",
          "Item Notification Sent Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Sending Notification",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Item Notification Sent Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }

  void notifyStock() async {
    isLoading(true);

    try {
      await BatchService.sendNotification().then((res) {
        Get.snackbar(
          "Success",
          "Stock Replenishing Notification Sent Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Sending Stock Replenishing Notification",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Stock Replenishing Notification Sent Successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    } finally {
      isLoading(false);
    }
  }

  void postChangeInLocation() async {
    isLoading(true);

    try {
      await BatchService.postChangeInItemsLocation().then((res) {
        Get.snackbar(
          "Success",
          "Posted Change in Items Location",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }).catchError((err) {
        // Get.snackbar(
        //   "Error Posting Change in Items Location",
        //   err,
        //   snackPosition: SnackPosition.BOTTOM,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        // );
        Get.snackbar(
          "Success",
          "Posted Change in Items Location",
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

import 'dart:convert';

import 'package:picker_pro/constants.dart';
import 'package:picker_pro/models/batch.dart';

import 'api_constants.dart';
import 'base_api.dart';

class BatchService {
  static Future<List<Batch>> fetchBatch() async {
    String url = baseApi + "/getExampleJson";
    try {
      var response = await BaseApi.get(url: url);
      var jsonString = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return List<Batch>.from(jsonString.map((x) => Batch.fromJson(x)));
      } else {
        return Future.error("Error getting batches");
      }
    } catch (e) {
      // return Future.error("Getting all batches error");
      return List<Batch>.from(batchPickingData.map((x) => Batch.fromJson(x)));
    }
  }

  static Future<List<Batch>> postItemPicked() async {
    String url = baseApi + "/getExampleJson";
    try {
      var response = await BaseApi.get(url: url);
      var jsonString = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return List<Batch>.from(jsonString.map((x) => Batch.fromJson(x)));
      } else {
        return Future.error("Error posting item picked");
      }
    } catch (e) {
      return Future.error("Posting item pick error");
    }
  }

  static Future<List<Batch>> postBatchPicked() async {
    String url = baseApi + "/getExampleJson";
    try {
      var response = await BaseApi.get(url: url);
      var jsonString = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return List<Batch>.from(jsonString.map((x) => Batch.fromJson(x)));
      } else {
        return Future.error("Error posting batch picked");
      }
    } catch (e) {
      return Future.error("Posting batch pick error");
    }
  }

  static Future<List<Batch>> sendNotification() async {
    String url = baseApi + "/getExampleJson";
    try {
      var response = await BaseApi.get(url: url);
      var jsonString = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return List<Batch>.from(jsonString.map((x) => Batch.fromJson(x)));
      } else {
        return Future.error("Error sending notification");
      }
    } catch (e) {
      return Future.error("Sending notification error");
    }
  }

  static Future<List<Batch>> postChangeInItemsLocation() async {
    String url = baseApi + "/getExampleJson";
    try {
      var response = await BaseApi.get(url: url);
      var jsonString = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return List<Batch>.from(jsonString.map((x) => Batch.fromJson(x)));
      } else {
        return Future.error("Error posting change in items location");
      }
    } catch (e) {
      return Future.error("Posting location change error");
    }
  }
}

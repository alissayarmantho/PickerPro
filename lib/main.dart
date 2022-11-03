import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/constants.dart';
import 'package:picker_pro/controller/batch_controller.dart';
import 'package:picker_pro/widgets/item_draggable_scroll_sheet.dart';

void main() => runApp(const PickerProApp());

class PickerProApp extends StatelessWidget {
  const PickerProApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BatchController batchController =
        Get.put<BatchController>(BatchController());
    batchController.fetchBatches();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'NunitoSans',
              fontSizeFactor: 1,
            ),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: primaryColor,
            onPrimary: Colors.white,
            secondary: primaryLightColor,
            onSecondary: Colors.black,
            error: Colors.black,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Picker Pro'),
          backgroundColor: primaryColor,
        ),
        body: Obx(
          () => batchController.isLoading.value
              ? Center(child: CircularProgressIndicator(key: UniqueKey()))
              : Stack(
                  children: [
                    Positioned.fill(
                        bottom: 130,
                        child: Image.asset(batchController
                            .batches[batchController.activeBatchIndex.value]
                            .items[batchController.activeItemIndex.value]
                            .img)),
                    const ItemDraggableScrollSheet(),
                  ],
                ),
        ),
      ),
    );
  }
}

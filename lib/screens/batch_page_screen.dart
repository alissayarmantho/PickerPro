import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/constants.dart';
import 'package:picker_pro/controller/batch_controller.dart';
import 'package:picker_pro/widgets/item_draggable_scroll_sheet.dart';

class BatchPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BatchController batchController = Get.find<BatchController>();
    return Scaffold(
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
                        .img),
                  ),
                  const ItemDraggableScrollSheet(),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/constants.dart';
import 'package:picker_pro/controller/batch_controller.dart';
import 'package:picker_pro/screens/batch_page_screen.dart';

class BatchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BatchController batchController =
        Get.put<BatchController>(BatchController());
    batchController.fetchBatches();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Picker Pro'),
        backgroundColor: primaryColor,
      ),
      body: Obx(() => batchController.isLoading.value
          ? Center(child: CircularProgressIndicator(key: UniqueKey()))
          : ListView.builder(
              itemCount: batchController.batches.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      batchController.setActiveBatchIndex(index);
                      batchController.setActiveIndex(0);
                      Get.to(() => BatchPageScreen());
                    },
                    title: Text(batchController.batches[index].name),
                    subtitle: Obx(() => Text((batchController
                                .batches[index].isComplete
                            ? 'Completed'
                            : 'Incomplete') +
                        ' - ' +
                        batchController.batches[index].items
                            .fold<int>(
                                0,
                                (previousValue, element) => element.isPicked
                                    ? previousValue + 1
                                    : previousValue)
                            .toString() +
                        "/" +
                        batchController.batches[index].items.length.toString() +
                        " items picked")),
                    leading: CircleAvatar(
                      child: Image.asset("assets/box.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    trailing: Obx(
                      () => Icon(
                        batchController.batches[index].isComplete
                            ? Icons.check
                            : Icons.pending,
                        color: batchController.batches[index].isComplete
                            ? Colors.green
                            : null,
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

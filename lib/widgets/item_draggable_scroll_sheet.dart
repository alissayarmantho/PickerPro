import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/controller/batch_controller.dart';
import 'package:picker_pro/widgets/stepper_widget.dart';

class ItemDraggableScrollSheet extends StatefulWidget {
  const ItemDraggableScrollSheet({Key? key}) : super(key: key);

  @override
  _ItemDraggableScrollSheetState createState() =>
      _ItemDraggableScrollSheetState();
}

class _ItemDraggableScrollSheetState extends State<ItemDraggableScrollSheet> {
  final double _initialSheetChildSize = 0.3;
  double _dragScrollSheetExtent = 0;

  double _widgetHeight = 0;
  double _fabPosition = 0;
  final double _fabPositionPadding = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size size = MediaQuery.of(context).size;
      setState(() {
        _fabPosition = _initialSheetChildSize * size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final BatchController batchController = Get.find<BatchController>();
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: _fabPosition + _fabPositionPadding,
          right: _fabPositionPadding,
          child: Row(children: [
            Obx(
              () => FloatingActionButton(
                child: const Icon(Icons.arrow_back_rounded),
                disabledElevation: 0,
                backgroundColor: batchController.activeBatchIndex.value == 0
                    ? Colors.grey.shade300
                    : null,
                onPressed: batchController.activeBatchIndex.value == 0
                    ? null
                    : () {
                        batchController.prevBatchIndex();
                      },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Obx(
              () => FloatingActionButton(
                backgroundColor: batchController.activeBatchIndex.value ==
                        batchController.batches.length - 1
                    ? Colors.grey.shade300
                    : null,
                disabledElevation: 0,
                child: const Icon(Icons.arrow_forward_rounded),
                onPressed: batchController.activeBatchIndex.value ==
                        batchController.batches.length - 1
                    ? null
                    : () {
                        batchController.nextBatchIndex();
                      },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Obx(
              () => FloatingActionButton(
                backgroundColor: batchController.activeBatchIndex.value ==
                        batchController.batches.length - 1
                    ? Colors.grey.shade300
                    : Colors.green,
                disabledElevation: 0,
                child: const Icon(Icons.check),
                onPressed: batchController.activeBatchIndex.value ==
                        batchController.batches.length - 1
                    ? null
                    : () {
                        // showAboutDialog(context: context);
                        batchController.postBatchPicked();
                        if (batchController.activeBatchIndex.value <
                            batchController.batches.length - 1) {
                          batchController.nextBatchIndex();
                        }
                      },
              ),
            ),
          ]),
        ),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification notification) {
            setState(() {
              _widgetHeight = size.height;
              _dragScrollSheetExtent = notification.extent;

              _fabPosition = _dragScrollSheetExtent * _widgetHeight;
            });
            return true;
          },
          child: DraggableScrollableSheet(
            maxChildSize: 0.6,
            minChildSize: 0.2,
            initialChildSize: _initialSheetChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 15,
                      blurRadius: 15,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return const StepperWidget();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picker_pro/constants.dart';
import 'package:picker_pro/controller/batch_controller.dart';
import 'package:picker_pro/models/batch.dart';
import 'package:picker_pro/widgets/primary_button.dart';
import 'package:picker_pro/widgets/secondary_button.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final BatchController batchController = Get.find<BatchController>();
    return Obx(
      () => Stepper(
        physics: const ClampingScrollPhysics(),
        currentStep: _index,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  PrimaryButton(
                    key: UniqueKey(),
                    text: "Picked",
                    press: () async {
                      batchController.postItemPicked();
                    },
                    widthRatio: 0.20,
                    marginLeft: 0,
                    marginRight: 5,
                  ),
                  SecondaryButton(
                    key: UniqueKey(),
                    text: "Out of Stock",
                    press: () async {
                      batchController.notifyStock();
                    },
                    widthRatio: 0.30,
                    marginLeft: 0,
                    marginRight: 5,
                  ),
                  TextButton(
                    onPressed: _index > 0 ? details.onStepCancel : null,
                    child: const Text('Back'),
                  ),
                ],
              ),
            ],
          );
        },
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
              batchController.setActiveIndex(_index);
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
              batchController.setActiveIndex(_index);
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
            batchController.setActiveIndex(index);
          });
        },
        steps: batchController
            .batches[batchController.activeBatchIndex.value].items
            .map((Items item) {
          return Step(
            title: Text(
              item.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Bin no: " + item.binNo.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: primaryColor,
                              size: 18,
                            ))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        item.orders
                            .map((order) =>
                                order.quantity +
                                " #" +
                                order.orderNo.toString())
                            .join(", "),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Add Notes'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

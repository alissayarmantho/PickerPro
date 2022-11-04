import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:picker_pro/constants.dart';
import 'package:picker_pro/controller/batch_controller.dart';
import 'package:picker_pro/models/batch.dart';
import 'package:picker_pro/widgets/primary_button.dart';
import 'package:picker_pro/widgets/secondary_button.dart';

Widget _buildAddNotesPopUpDialog(
    BuildContext context, BatchController batchController) {
  TextEditingController _notesController = TextEditingController(
      text: batchController.batches[batchController.activeBatchIndex.value]
          .items[batchController.activeItemIndex.value].notes);
  return new AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: const Text('Add/View Notes'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _notesController,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Notes for the Next Picker',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    ),
    actions: <Widget>[
      new SecondaryButton(
        key: UniqueKey(),
        text: "Cancel",
        press: () {
          Navigator.pop(context);
        },
        widthRatio: 0.3,
      ),
      new PrimaryButton(
        text: "Save",
        key: UniqueKey(),
        press: () {
          batchController.updateItemNotes(text: _notesController.text);
          Navigator.pop(context);
        },
        widthRatio: 0.3,
      ),
    ],
  );
}

Widget _buildEditBinPopUpDialog(
    BuildContext context, BatchController batchController) {
  TextEditingController _binNumController = TextEditingController();
  return new AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: const Text('Edit Bin Location'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _binNumController,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Bin Number',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please input the new bin number';
            }
            return null;
          },
        ),
      ],
    ),
    actions: <Widget>[
      new SecondaryButton(
        key: UniqueKey(),
        text: "Cancel",
        press: () {
          Navigator.pop(context);
        },
        widthRatio: 0.3,
      ),
      new PrimaryButton(
        text: "Save",
        key: UniqueKey(),
        press: () {
          batchController.updateBinNumber(_binNumController.text);
          Navigator.pop(context);
        },
        widthRatio: 0.3,
      ),
    ],
  );
}

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
        key: Key(Random.secure().nextDouble().toString()),
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
                    widthRatio: 0.21,
                    marginLeft: 0,
                    marginRight: 5,
                  ),
                  SecondaryButton(
                    key: UniqueKey(),
                    text: "Out of Stock",
                    press: () async {
                      batchController.notifyStock();
                    },
                    onPressColor: Colors.red.shade50,
                    widthRatio: 0.32,
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Obx(() => batchController.isLoading.value
                    ? item.isPicked
                        ? SizedBox(width: 10)
                        : Container()
                    : item.isPicked
                        ? SizedBox(width: 10)
                        : Container()),
                Obx(() => batchController.isLoading.value
                    ? item.isPicked
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Container()
                    : item.isPicked
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Container()),
              ],
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
                        Obx(
                          () => Text(
                            batchController.isLoading.value
                                ? "Bin no: " + item.binNo.toString()
                                : "Bin no: " + item.binNo.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildEditBinPopUpDialog(
                                        context, batchController),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: primaryColor,
                              size: 18,
                            ))
                      ],
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildAddNotesPopUpDialog(
                                    context, batchController),
                          );
                        },
                        child: const Text('Notes'),
                      ),
                      // SizedBox(height: 10),
                      // ElevatedButton.icon(
                      //   style: ButtonStyle(
                      //     elevation: MaterialStateProperty.all(0),
                      //     backgroundColor:
                      //         MaterialStateProperty.resolveWith<Color>(
                      //       (Set<MaterialState> states) {
                      //         if (states.contains(MaterialState.pressed)) {
                      //           return Colors.red.shade50;
                      //         }
                      //         return primaryLightColor;
                      //       },
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) =>
                      //           _buildAddNotesPopUpDialog(
                      //               context, batchController),
                      //     );
                      //   },
                      //   icon: Icon(
                      //     Icons.note_alt_rounded,
                      //     color: primaryColor,
                      //   ),
                      //   label: Text(
                      //     'Add/View Notes',
                      //     style: TextStyle(color: Colors.black),
                      //   ),
                      // ),
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

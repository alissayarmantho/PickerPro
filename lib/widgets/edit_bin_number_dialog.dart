import 'package:flutter/material.dart';

class EditBinNumberDialog extends StatelessWidget {
  const EditBinNumberDialog({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _binNumController = TextEditingController();
    return new AlertDialog(
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
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
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
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

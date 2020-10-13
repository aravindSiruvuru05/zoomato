import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zoomato/widgets/build_bottom_sheet.dart';

class DialogPopUp {
  static Widget showlocationPermissionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('location Permissions needed !'),
        content:
        Text("you must have to provide permissons to get neat by resturents"),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              showLocationChooserBottomSheet(context);
            },
            child: Text(
              "select manually",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton(
            onPressed: () async {
              Navigator.pop(context);
              //await openAppSettings();
              await openLocationSettings();
            },
            child: Text(
              "yes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );

  }

  static void showLocationChooserBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BuildBottomSheet();
      },
    );
  }
}


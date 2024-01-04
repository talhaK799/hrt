import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/colors.dart';
import 'package:hart/core/constants/style.dart';
import 'package:hart/ui/custom_widgets/right_navigation.dart';
import 'package:hart/ui/screens/profile_screen/maestro_screen/maestro_screen.dart';

showMyDialog(context, String? error) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: whiteColor,
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${error}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // TextButton(
          //   child: Text('Cancel'),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
        ],
      );
    },
  );
}

becomeMaestroDialog(context, String? error) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: whiteColor,
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${error}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF980000),
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              child: Text(
                'Become a Maestro',
                style: bodyTextStyle.copyWith(fontSize: 16, color: whiteColor),
              ),
              onPressed: () {
                Get.back();
                // Get.to(MaestroScreen());
                Navigator.push(
                  context,
                  PageFromRight(
                    page: MaestroScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

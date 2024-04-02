import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../core/constants/colors.dart';

class FullScreenImage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final memoryImage;
  const FullScreenImage(
    this.memoryImage, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PhotoView(
          imageProvider: NetworkImage(memoryImage),
          loadingBuilder:
              (BuildContext context, ImageChunkEvent? loadingProgress) {
            return Container(
              height: 0.35.sh,
              color: Colors.grey.withOpacity(0.1),
              child: Center(
                // Display a linear progress indicator until the image is fully loaded.
                child: loadingProgress == null
                    ? Container()
                    : CircularProgressIndicator(
                        color: primaryColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
              ),
            );
          },
        ),
        Positioned(
          top: 50,
          left: 10,
          child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              )),
        )
      ],
    ));
  }
}

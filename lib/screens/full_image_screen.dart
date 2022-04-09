import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../api/nasa_apod_service.dart';
import '../components/circular_material_button.dart';
import '../models/apod.dart';

class FullImageScreen extends StatelessWidget {
  final ApodModel apod;

  const FullImageScreen({
    Key? key,
    required this.apod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(apod.imageUrlHD),
            ),
            Positioned(
              top: 15,
              left: 10,
              child: CircularMaterialButton(
                icon: Icons.download,
                onPressed: saveImage,
              ),
            ),
            Positioned(
              top: 15,
              right: 10,
              child: CircularMaterialButton(
                icon: Icons.close,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveImage() async {
    if (await Permission.storage.request().isGranted) {
      final service = ApodService();

      Fluttertoast.showToast(msg: 'Image is saving...');
      bool isSuccess = await service.saveApodImageToGallery(apod);

      if (isSuccess) {
        Fluttertoast.showToast(msg: 'Image saved successfully.');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong!');
      }
    }
  }
}

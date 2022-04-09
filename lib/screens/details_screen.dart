import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nasa_apod/components/circular_material_button.dart';

import '../constants.dart';
import '../models/apod.dart';
import 'full_image_screen.dart';

class DetailsScreen extends StatelessWidget {
  final ApodModel apod;

  const DetailsScreen({
    Key? key,
    required this.apod,
  }) : super(key: key);

  void _pushFullImageScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) => FullImageScreen(apod: apod),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: buildImage(context),
          onTap: () => _pushFullImageScreen(context),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: buildDetails(),
          ),
        ),
      ],
    );
  }

  ListView buildDetails() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      primary: false,
      children: [
        const SizedBox(height: 12),
        Text(
          apod.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            apod.explanation.isEmpty ? 'No description' : apod.explanation,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(apod.date),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Copyright: ${apod.copyright}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ],
    );
  }

  Container buildImage(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 250),
      decoration: BoxDecoration(
        borderRadius: kBottomSheetRadius,
        image: DecorationImage(
          image: CachedNetworkImageProvider(apod.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 8,
            child: CircularMaterialButton(
              icon: Icons.close,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants.dart';
import '../models/apod.dart';
import '../screens/details_screen.dart';

class ApodCard extends StatelessWidget {
  final ApodModel apod;

  const ApodCard({
    Key? key,
    required this.apod,
  }) : super(key: key);

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DetailsScreen(apod: apod);
      },
      shape: const RoundedRectangleBorder(
        borderRadius: kBottomSheetRadius,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.95,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        constraints: const BoxConstraints.expand(height: 300),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: CachedNetworkImageProvider(apod.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 15,
              left: 15,
              child: buildTitle(context),
            )
          ],
        ),
      ),
    );
  }

  SizedBox buildTitle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        apod.title,
        maxLines: 2,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

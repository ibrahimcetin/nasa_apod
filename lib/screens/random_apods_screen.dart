import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../api/nasa_apod_service.dart';
import '../components/apod_card.dart';
import '../models/apod.dart';

class RandomApodsScreen extends StatefulWidget {
  const RandomApodsScreen({Key? key}) : super(key: key);

  @override
  _RandomApodsScreenState createState() => _RandomApodsScreenState();
}

class _RandomApodsScreenState extends State<RandomApodsScreen> {
  late final ScrollController controller;

  final apodService = ApodService();
  final apods = <ApodModel>[];
  bool isFetching = false;

  @override
  void initState() {
    _fetchApods();

    controller = ScrollController();
    controller.addListener(_controllerListener);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Future<void> _fetchApods() async {
    setState(() => isFetching = true);

    final newApods = await apodService.getRandomApods(5);
    apods.addAll(newApods);

    setState(() => isFetching = false);
  }

  void _controllerListener() async {
    if (controller.offset >= controller.position.maxScrollExtent * 0.9 &&
        !controller.position.outOfRange &&
        !isFetching) {
      await _fetchApods();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (apods.isEmpty) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.primary,
        highlightColor: Theme.of(context).colorScheme.secondary,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final apod = apods[index];
              return ApodCard(apod: apod);
            },
            childCount: apods.length,
          ),
        ),
        if (isFetching)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../models/apod.dart';

class ApodService {
  static const _apodApi = 'DEMO_KEY';

  final _dio = Dio(
    BaseOptions(baseUrl: "https://api.nasa.gov/planetary/"),
  );

  Future<List<ApodModel>> getRandomApods(int count) async {
    List<ApodModel> apods = [];

    Response response = await _dio.get(
      '/apod',
      queryParameters: {
        'api_key': _apodApi,
        'count': count,
      },
    );

    response.data.forEach((i) {
      if (i['media_type'] == 'image') apods.add(ApodModel.fromJson(i));
    });

    return apods;
  }

  Future<bool> saveApodImageToGallery(ApodModel apod) async {
    final tempDir = await getTemporaryDirectory();
    final savePath = path.join(
      tempDir.path,
      "${apod.date}${path.extension(apod.imageUrlHD)}",
    );

    await _dio.download(apod.imageUrlHD, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);

    await File(savePath).delete();

    return result['isSuccess'];
  }
}

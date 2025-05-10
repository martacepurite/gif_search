import 'gif_object_model.dart';

class GiphyResponseModel {
  List<GifObjectModel> data;
  Map<String, dynamic> pagination;
  Map<String, dynamic> meta;

  GiphyResponseModel({required this.data, required this.pagination, required this.meta});

  factory GiphyResponseModel.fromJson(Map<String, dynamic> json) {
    var gifList =
        (json['data'] as List)
            .map((item) => GifObjectModel.fromJson(item as Map<String, dynamic>))
            .toList();

    return GiphyResponseModel(
      data: gifList,
      pagination: json['pagination'],
      meta: json['meta'],
    );
  }
}
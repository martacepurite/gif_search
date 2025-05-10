import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'giphy_response_model.dart';
import 'package:http/http.dart' as http;

Future<GiphyResponseModel> fetchGiphyResponse(String query, int limit, int fetchedIndex) async {
  
  final httpsUri = Uri.https('api.giphy.com', '/v1/gifs/search', {
    'api_key': dotenv.env['API_KEY'],
    'q': query,
    'limit': limit.toString(),
    'offset': fetchedIndex.toString(),
  });

  final response = await http.get(httpsUri);

  if (response.statusCode == 200) {
    return GiphyResponseModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    return Future.error(ErrorDescription);
  }
}

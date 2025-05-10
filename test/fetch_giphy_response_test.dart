// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gif_search_app/fetch_giphy_response.dart';
import 'package:gif_search_app/giphy_response_model.dart';
import 'package:gif_search_app/gif_object_model.dart';

void main() {
  test('fetch should return correct data', () async {
    int fetchIndex = 0;
    int itemsCount = 10;
    final response = await fetchGiphyResponse("the office", itemsCount, fetchIndex);

    expect(response, isNotNull);
    expect(response.runtimeType, GiphyResponseModel);
    expect(response.data, isNotNull);
    expect(response.data.first.runtimeType, GifObjectModel);

  });
  test('repeated fetch should return offset results', () async {
    int fetchIndex = 0;
    int itemsCount = 10;
    final response = await fetchGiphyResponse("the office", itemsCount, fetchIndex);

    expect(response.data.length, itemsCount);
    fetchIndex += response.pagination["count"] as int;

    final response2 = await fetchGiphyResponse("the office", itemsCount, fetchIndex);

    expect(response2.pagination["offset"], fetchIndex);
  });
  test('fetch should return correct data2', () async {
    int fetchIndex = 0;
    int itemsCount = 10;
    final response = await fetchGiphyResponse("the office", itemsCount, fetchIndex);

    expect(response, isNotNull);
    expect(response.runtimeType, GiphyResponseModel);
    expect(response.data, isNotNull);
    expect(response.data.first.runtimeType, GifObjectModel);
    
    print(response.data.length);
    print(response.pagination.toString());
  //  itemsCount += 10;
    fetchIndex += 10;
    final response2 = await fetchGiphyResponse("the office", itemsCount, fetchIndex);
    print(response2.data.length);
    print(response2.pagination.toString());
  });
}

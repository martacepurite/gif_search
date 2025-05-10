import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'detail_view.dart';
import 'gif_object_model.dart';
import 'giphy_response_model.dart';
import 'fetch_giphy_response.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<GifObjectModel> gifs = [];
  Future<GiphyResponseModel>? _futureGiphyResponseModel;
  int itemsCount = 10;
  int fetchedIndex = 0;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_autoSearch);
    _scrollController.addListener(_loadMoreOnScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    setState(() {
      _futureGiphyResponseModel = fetchGiphyResponse(
        _controller.text,
        itemsCount,
        fetchedIndex,
      );

      _futureGiphyResponseModel!.then((fetchedGifs) {
        setState(() {
          gifs.addAll(fetchedGifs.data);
          fetchedIndex += fetchedGifs.pagination["count"] as int;
        });
      });
    });
  }

  void _loadMoreOnScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 40) {
      _loadMore();
    }
  }

  void _autoSearch() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final queryInput = _controller.text;
      if (queryInput != '') {
        setState(() {
          gifs = [];
          itemsCount = 10;
          fetchedIndex = 0;
          _loadMore();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gif Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 38, 6, 94),
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          title: const Text(
            'Gif Search',
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: GifViewWidget(
                  scrollController: _scrollController,
                  gifs: gifs,
                ),
              ),
              SearchBarWidget(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required TextEditingController controller})
    : _controller = controller;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {

        return SearchBar(
          controller: _controller,
          hintText: "Search gifs...",
          autoFocus: true,
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),

        );
    
  }
}

class GifViewWidget extends StatelessWidget {
  const GifViewWidget({
    super.key,
    required ScrollController scrollController,
    required this.gifs,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<GifObjectModel> gifs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    int cols;
    if (width > height) {
      cols = 4;
    } else {
      cols = 2;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
      ),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      itemCount: gifs.length,

      itemBuilder: (context, index) {
        return GridItemGifWidget(gif: gifs[index]);
      },
    );
  }
}

class GridItemGifWidget extends StatelessWidget {
  const GridItemGifWidget({super.key, required this.gif});
  final GifObjectModel gif;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(gif: gif)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            gif.images["fixed_height"]["webp"],
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              );
            },
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) {
              return Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              );
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

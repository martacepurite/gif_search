import 'package:flutter/material.dart';
import 'gif_object_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.gif});
  final GifObjectModel gif;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(
                    gif.images["original"]["url"],

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
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                    fit: BoxFit.contain,
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    gif.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    gif.sourceTld,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

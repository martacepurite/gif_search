import 'package:flutter/material.dart';
import 'gif_object_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.gif});
  final GifObjectModel gif;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Powered by Giphy', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                  Image.network(
                    gif.images["original"]["url"],

                    loadingBuilder: (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        // return child;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: child,
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          padding: EdgeInsets.symmetric(
                           horizontal: 50,
                            vertical: 50,
                          ),
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
                //),

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
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: SelectableText(
                    gif.url,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class GifObjectModel {
  Map<String, dynamic> images;
  final String type;
  final String id;
  final String url;
  final String embed_url;
  final String title;
  final String username;
  final String createDatetime;
  final String source;
  final String sourceTld;

  GifObjectModel ({
    required this.images,
    required this.type,
    required this.id,
    required this.url,
    required this.embed_url,
    required this.title,
    required this.username,
    required this.createDatetime,
    required this.source,
    required this.sourceTld,
  });

  factory GifObjectModel .fromJson(Map<String, dynamic> json) {
    return GifObjectModel (
      images: json['images'] ?? '',
      type: json['type'] ?? '',
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      embed_url: json['embed_url'] ?? '',
      title: json['title'] ?? '',
      username: json['username'] ?? '',
      createDatetime: json['create_datetime'] ?? '',
      source: json['source'] ?? '',
      sourceTld: json['source_tld'] ?? '',
    );
  }
}

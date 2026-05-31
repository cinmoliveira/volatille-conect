class ImagemPlanta {
  final String url;

  ImagemPlanta(this.url);

  factory ImagemPlanta.fromJson(Map<String, dynamic> json) {
    return ImagemPlanta(
      json['src']['large'] ?? '',
    );
  }
}
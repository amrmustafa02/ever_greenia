class Image {
  Image({
    required this.secureUrl,
    required this.publicId,
  });

  final String? secureUrl;
  final String? publicId;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      secureUrl: json["secure_url"],
      publicId: json["public_id"],
    );
  }
}

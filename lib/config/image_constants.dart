import 'dart:convert';
import 'dart:io';

class ImageConstants {
  static final ImageConstants constants = ImageConstants._();
  factory ImageConstants() => constants;

  ImageConstants._();

  dynamic convertToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    return 'data:image/jpeg;base64,$base64Image';
  }

  dynamic pngToBase64(List<int> file) {
    String encoded = base64Encode(file);

    return encoded;
  }

  dynamic decodeBase64(String encoded) {
    String decoded = utf8.decode(base64Url.decode(encoded));

    return decoded;
  }
}
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> assetToFile(String assetPath, String fileName) async {
  final byteData = await rootBundle.load(assetPath);
  final buffer = byteData.buffer;

  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/$fileName');

  await file.writeAsBytes(
    buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
  );

  return file;
}

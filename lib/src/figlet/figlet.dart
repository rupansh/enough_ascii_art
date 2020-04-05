import 'dart:io';
import 'dart:isolate';
import 'package:enough_ascii_art/src/package_file_loader.dart';
import 'package:resource/resource.dart' show Resource;
import 'package:enough_ascii_art/src/figlet/parser.dart';
import 'package:enough_ascii_art/src/figlet/renderer.dart';

import 'font.dart';

/// Helper class to render a FIGure
class FIGlet {
  static Future<String> renderFIGureForFontName(
      String text, String fontName) async {
    fontName ??= 'cosmic';
    List<String> fontDefinition;
    String path;
    try {
      path = await PackageFileLoader.resolveLibraryPath(
          'enough_ascii_art', './lib/src/figlet/fonts/$fontName.flf');
      //print('Font path: $path');
      fontDefinition = await File(path).readAsLines();
    } catch (e) {
      print('Unable to load font from $path: $e');
      return text;
    }
    var parser = Parser();
    var font = parser.parseFontDefinition(fontDefinition);
    return renderFIGure(text, font);
  }

  static String renderFIGure(String text, Font font) {
    var renderer = Renderer();
    return renderer.render(text, font);
  }
}

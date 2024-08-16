import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex_example/tex_view_document_example.dart';
import 'package:flutter_tex_example/tex_view_fonts_example.dart';
import 'package:flutter_tex_example/tex_view_image_video_example.dart';
import 'package:flutter_tex_example/tex_view_ink_well_example.dart';
import 'package:flutter_tex_example/tex_view_markdown_example.dart';
import 'package:flutter_tex_example/tex_view_quiz_example.dart';

main() {
  runApp(const FlutterTeXExample());
}

class FlutterTeXExample extends StatelessWidget {
  const FlutterTeXExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TexViewFullExample(),
    );
  }
}


class TexViewFullExample extends StatelessWidget {
  const TexViewFullExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

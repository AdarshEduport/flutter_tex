// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'dart:ui_web' as ui;

late ValueNotifier<double> _widgetHeightNotifier ;

class TeXViewState extends State<TeXView> {
  String? _lastData;

  final String _viewId = UniqueKey().toString();

  @override
  Widget build(BuildContext context) {
  

    _initTeXView();
    return ValueListenableBuilder(
      valueListenable: _widgetHeightNotifier,
      builder:(context,double ht,child) =>SizedBox(
        height: ht,
        child: HtmlElementView(
          key: widget.key ?? ValueKey(_viewId),
          viewType: _viewId,
          onPlatformViewCreated: (id) {
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _widgetHeightNotifier = ValueNotifier(minHeight);
    _initWebview();
    super.initState();
  }

  void _initWebview() {
    ui.platformViewRegistry.registerViewFactory(
        _viewId,
        (int id) => html.IFrameElement()
          ..src =
              "assets/packages/flutter_tex/js/${widget.renderingEngine?.name ?? "katex"}/index.html"
          ..id = _viewId
          ..style.height = '100%'
          ..style.width = '100%'
          ..style.border = '0');

    js.context['TeXViewRenderedCallback'] = (message) {
      double viewHeight = double.parse(message.toString());
      if (viewHeight !=  _widgetHeightNotifier.value) {
        log('After rendering View height $viewHeight view id $_viewId');

        _widgetHeightNotifier.value = viewHeight;
      }
    };

    js.context['OnTapCallback'] = (id) {
      widget.child.onTapCallback(id);
    };
  }

  void _initTeXView() {
    if (getRawData(widget) != _lastData) {
      js.context.callMethod('initWebTeXView', [
        _viewId,
        getRawData(widget),
        widget.renderingEngine?.name ?? "katex"
      ]);
      _lastData = getRawData(widget);
    }
  }
}

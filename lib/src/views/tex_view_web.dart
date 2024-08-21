// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/utils/core_utils.dart';
import 'dart:ui' as ui;

late ValueNotifier<double> _widgetHeightNotifier;

class TeXViewState extends State<TeXView> {
  String? _lastData;

  final String _viewId = UniqueKey().toString();

  @override
  Widget build(BuildContext context) {
    _initTeXView();
    return ValueListenableBuilder(
      valueListenable: _widgetHeightNotifier,
      builder: (context, double ht, child) => SizedBox(
        height: ht,
        child: Stack(
          children: [
            HtmlElementView(
              key: widget.key ?? ValueKey(_viewId),
              viewType: _viewId,
              onPlatformViewCreated: (id) {
                setState(() {});
              },
            ),
            Positioned.fill(
              child: PointerInterceptor(
                intercepting: false,
                child: const MouseRegion(
                    opaque: true,
                    child: SizedBox(
                      height: 300,
                      width: 300,
                    )),
              ),
            )
          ],
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
    // ignore: undefined_prefixed_name
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
      if (viewHeight != _widgetHeightNotifier.value) {
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

const String _viewType = '__webPointerInterceptorViewType__';
const String _debug = 'debug__';

// Computes a "view type" for different configurations of the widget.
String _getViewType({bool debug = false}) {
  return debug ? _viewType + _debug : _viewType;
}

// Registers a viewFactory for this widget.
void _registerFactory({bool debug = false}) {
  final String viewType = _getViewType(debug: debug);
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final html.Element htmlElement = html.DivElement()
      ..style.width = '100%'
      ..style.height = '100%';
    if (debug) {
      htmlElement.style.backgroundColor = 'rgba(255, 0, 0, .5)';
    }
    return htmlElement;
  }, isVisible: false);
}

/// The web implementation of the `PointerInterceptor` widget.
///
/// A `Widget` that prevents clicks from being swallowed by [HtmlElementView]s.
class PointerInterceptor extends StatelessWidget {
  /// Creates a PointerInterceptor for the web.
  PointerInterceptor({
    required this.child,
    this.intercepting = true,
    this.debug = false,
    super.key,
  }) {
    if (!_registered) {
      _register();
    }
  }

  /// The `Widget` that is being wrapped by this `PointerInterceptor`.
  final Widget child;

  /// Whether or not this `PointerInterceptor` should intercept pointer events.
  final bool intercepting;

  /// When true, the widget renders with a semi-transparent red background, for debug purposes.
  ///
  /// This is useful when rendering this as a "layout" widget, like the root child
  /// of a [Drawer].
  final bool debug;

  // Keeps track if this widget has already registered its view factories or not.
  static bool _registered = false;

  // Registers the view factories for the interceptor widgets.
  static void _register() {
    assert(!_registered);

    _registerFactory();
    _registerFactory(debug: true);

    _registered = true;
  }

  @override
  Widget build(BuildContext context) {
    if (!intercepting) {
      return child;
    }

    final String viewType = _getViewType(debug: debug);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          child: HtmlElementView(
            viewType: viewType,
          ),
        ),
        child,
      ],
    );
  }
}

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plants_app/core/extensions/context_extension.dart';

class StretchableWidget extends StatefulWidget {
  final bool isRight;

  const StretchableWidget({super.key, required this.isRight});

  @override
  // ignore: library_private_types_in_public_api
  _StretchableWidgetState createState() => _StretchableWidgetState();
}

class _StretchableWidgetState extends State<StretchableWidget> {
  late double _width; // Initial width of the widget
  late double _minWidth; // Initial width of the widget
  late double _maxWidth; // Initial width of the widget

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _width = context.width / 3;
    _minWidth = context.width / 3;
    _maxWidth = context.width / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.isRight ? TextDirection.rtl : TextDirection.ltr,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _width,
        alignment:
            widget.isRight ? Alignment.centerRight : Alignment.centerLeft,
        height: _width + 50,
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        child: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onHorizontalDragUpdate: (details) {
            setState(() {
              if (widget.isRight) {
                _width -= details.delta.dx; // Reduce width on drag left
              } else {
                _width += details.delta.dx; // Increase width on drag right
              }
              if (_width > _maxWidth) _width = _maxWidth; // Clamp to max width
              if (_width < _minWidth) _width = _minWidth; // Clamp to min width
            });
          },
          onHorizontalDragEnd: (details) {
            _width = _minWidth;
            log("width: $_width");
            setState(() {});
          },
          child: SvgPicture.asset(
            widget.isRight
                ? "assets/images/arrow_2.svg"
                : "assets/images/arrow.svg",
            width: _width,
            height: _width + 50,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  
  }
}

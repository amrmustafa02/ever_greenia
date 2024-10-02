import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_app/core/extensions/context_extension.dart';

class CounterButton extends StatefulWidget {
  final bool isRight;
  final void Function() onPressed;

  const CounterButton(
      {super.key, required this.isRight, required this.onPressed});

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
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
    _width = context.width * 0.30;
    _minWidth = context.width * 0.30;
    _maxWidth = context.width * 0.35;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.down,
      onHorizontalDragUpdate: (details) {

        setState(() {
          if (widget.isRight) {
            _width -= details.delta.dx; // Reduce width on drag left
          } else {
            _width += details.delta.dx; // Increase width on drag right
          }

          if (_width > _maxWidth) {
            _width = _maxWidth; // Clamp to max width
          }
          if (_width < _minWidth) {
            _width = _minWidth; // Clamp to min width
          }
        });
      },
      onHorizontalDragEnd: (details) {
        _width = _minWidth;
        // setState(() {});
        widget.onPressed();
      },
      child: Stack(
        alignment:
            widget.isRight ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: _width,
            alignment:
                widget.isRight ? Alignment.centerRight : Alignment.centerLeft,
            height: _width + 50,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            child: SvgPicture.asset(
              widget.isRight
                  ? "assets/images/arrow_2.svg"
                  : "assets/images/arrow.svg",
              width: _width,
              height: _width + 50,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _minWidth / 4,
            ),
            child: Icon(
              widget.isRight ? Icons.add : Icons.remove,
            ),
          ),
        ],
      ),
    );
  }
}

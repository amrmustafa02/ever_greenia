import 'dart:math';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer' as dev;
import '../../../../core/theme/app_colors.dart';

class AnimSearchBar extends StatefulWidget {
  final double width;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final Function onCloseTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final Function() onOpen;
  final Function() onChange;

  const AnimSearchBar({
    super.key,
    required this.width,
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",
    this.color = Colors.white,
    this.textFieldColor = Colors.white,
    this.searchIconColor = Colors.black,
    this.textFieldIconColor = Colors.black,
    required this.onCloseTap,
    this.animationDurationInMilli = 375,
    required this.onSubmitted,
    this.rtl = false,
    this.autoFocus = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
    this.boxShadow = true,
    this.inputFormatters,
    required this.onOpen,
    required this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimSearchBarState();
  }
}

int toggle = 0;

String textFieldValue = '';

class _AnimSearchBarState extends State<AnimSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unFocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  focusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus) {
      FocusManager.instance.primaryFocus?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    dev.log("Build search bar");
    return Container(
      height: 10.h,
      alignment:
          Alignment.centerRight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: 48.0,
        width: (toggle == 0) ? 48.0 : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: toggle == 1 ? AppColors.darkBlueColor : Colors.transparent,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 6.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                    child: GestureDetector(
                      onTap: _closeSearch,
                      child: widget.suffixIcon ??
                          Icon(
                            EneftyIcons.close_circle_outline,
                            size: 20.0,
                            color: widget.textFieldIconColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    focusNode: focusNode,
                    cursorRadius: const Radius.circular(10.0),
                    cursorWidth: 2.0,
                    onSubmitted: (value) {
                      // dont close keyboard
                      focusKeyboard();
                      widget.onChange();
                    },
                    style: widget.style ?? const TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.helpText,
                      labelStyle: const TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: widget.prefixIcon != null
                  ? toggle == 1
                      ? Icon(
                          Icons.arrow_back_ios,
                          color: widget.textFieldIconColor,
                        )
                      : widget.prefixIcon!
                  : Icon(
                      toggle == 1
                          ? EneftyIcons.search_normal_outline
                          : EneftyIcons.search_normal_outline,
                      // search icon color when closed
                      color: toggle == 0
                          ? widget.searchIconColor
                          : widget.textFieldIconColor,
                      size: 20.0,
                    ),
              onPressed: () {
                setState(
                  () {
                    if (toggle == 0) {
                      widget.onOpen();
                      toggle = 1;
                      FocusScope.of(context).requestFocus(focusNode);
                      setState(() {});
                      _con.forward();
                    } else {
                      widget.onChange();
                      // _closeSearch();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _closeSearch() async {
    _con.reverse();
    unFocusKeyboard();
    widget.onCloseTap();
    toggle = 0;
    setState(() {});
  }
}

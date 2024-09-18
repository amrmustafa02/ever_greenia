import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/features/product_details/presentation/widgets/counter_button.dart';

class CounterSection extends StatefulWidget {
  const CounterSection({super.key});

  @override
  State<CounterSection> createState() => _CounterSectionState();
}

class _CounterSectionState extends State<CounterSection> {
  int counter = 0;
  final switcherKey = const ValueKey<String>("switcher");
  bool curClickIsRight = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CounterButton(
            isRight: false,
            onPressed: () {
              if (counter > 0) {
                counter--;
              }
              curClickIsRight = false;
              setState(() {});
            },
          ),
        ),
        curClickIsRight
            ? AnimatedSwitcherPlus.translationLeft(
                switchInCurve: Curves.easeInCubic,
                key: switcherKey,
                duration: const Duration(milliseconds: 750),
                child: _buildText(),
              )
            : AnimatedSwitcherPlus.translationRight(
                key: switcherKey,
                switchInCurve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 750),
                child: _buildText(),
              ),
        Align(
          alignment: Alignment.topRight,
          child: CounterButton(
            isRight: true,
            onPressed: () {
              counter++;
              curClickIsRight = true;
              setState(() {});
            },
          ),
        )
      ],
    );
  }

  Text _buildText() {
    return Text(
      counter.toString(),
      key: ValueKey<int>(counter),
      style: GoogleFonts.readexPro().copyWith(
        color: Colors.black,
        fontSize: 62,
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plants_app/features/home/presentation/widgets/tab_item.dart';

class TabBarSection extends StatefulWidget {
  const TabBarSection({super.key});

  @override
  State<TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Colors.transparent,
      physics: const BouncingScrollPhysics(),
      indicator: const BoxDecoration(),
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
        log(value.toString());
      },
      enableFeedback: false,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      padding: const EdgeInsets.all(0),
      indicatorPadding: const EdgeInsets.all(0),
      tabAlignment: TabAlignment.start,
      tabs: [
        TabItem(
          isActive: selectedIndex == 0,
          text: 'Plants',
        ),
        TabItem(
          isActive: selectedIndex == 1,
          text: 'Plants',
        ),
        TabItem(
          isActive: selectedIndex == 2,
          text: 'Plants',
        ),
        TabItem(
          isActive: selectedIndex == 3,
          text: 'Plants',
        ),
      ],
      isScrollable: true,
    );
  }
}

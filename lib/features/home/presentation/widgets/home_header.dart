import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:plants_app/features/home/presentation/widgets/search_bar.dart';
import 'package:plants_app/features/home/presentation/widgets/text_fade_in_left.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
    required this.onTap,
    this.showDrawer = true,
  });

  final Function() onTap;
  final bool showDrawer;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  // Declare a GlobalKey to track the widget size
  final GlobalKey _headerKey = GlobalKey();
  double? _widgetHeight;

  @override
  void initState() {
    super.initState();
    // Wait until after the first frame is rendered to get the height
    WidgetsBinding.instance.addPostFrameCallback((_) => _getWidgetHeight());
  }

  void _getWidgetHeight() {
    final RenderBox renderBox =
        _headerKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    setState(() {
      _widgetHeight = size.height;
      log("Widget Height: ${_widgetHeight}px"); // Log the height
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Stack(
          key: _headerKey, // Attach the GlobalKey to this Row
          children: [
            ValueListenableBuilder(
              valueListenable: context.read<HomeCubit>().isSearchOpen,
              builder: (context, value, child) {
                return const FadeInLeftText();
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimSearchBar(
                    width: 80.w,
                    helpText: "Search",
                    animationDurationInMilli: 2000,
                    textController: context.read<HomeCubit>().controllerSearch,
                    onCloseTap: context.read<HomeCubit>().onCloseSearch,
                    onSubmitted: (value) {
                      context.read<HomeCubit>().onCloseSearch();
                    },
                    onOpen: () {
                      context.read<HomeCubit>().onSearchOpen();
                    },
                    onChange: () {
                      context.read<HomeCubit>().search();
                    },
                  ),
                  Visibility(
                    visible: widget.showDrawer,
                    child: FadeInRight(
                      child: IconButton(
                        onPressed: widget.onTap,
                        icon: const Icon(
                          Icons.menu,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


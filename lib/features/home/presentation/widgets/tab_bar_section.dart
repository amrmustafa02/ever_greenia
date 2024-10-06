import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/features/home/domain/entities/category_data.dart';
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:plants_app/features/home/presentation/widgets/tab_item.dart';

class TabBarSection extends StatefulWidget {
  final List<CategoryData> categories;

  const TabBarSection({super.key, required this.categories});

  @override
  State<TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicator: const BoxDecoration(),
        onTap: cubit.changeTab,
        enableFeedback: false,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: const EdgeInsets.all(0),
        indicatorPadding: const EdgeInsets.all(0),
        tabAlignment: TabAlignment.start,
        tabs: widget.categories
            .map(
              (e) => TabItem(
                isActive: cubit.curTabIndex == widget.categories.indexOf(e),
                text: e.name,
              ),
            )
            .toList(),
        isScrollable: true,
      ),
    );
  }
}

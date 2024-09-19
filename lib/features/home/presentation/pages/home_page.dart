import 'package:draggable_carousel_slider/draggable_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/features/home/presentation/widgets/product_item.dart';
import 'package:plants_app/features/home/presentation/widgets/cart_section.dart';
import 'package:plants_app/features/home/presentation/widgets/home_header.dart';
import 'package:plants_app/features/home/presentation/widgets/tab_bar_section.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return AdvancedDrawer(
            backdrop: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    AppColors.primaryColor,
                  ],
                ),
              ),
            ),
            controller: _advancedDrawerController,
            openRatio: 0.50,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: true,
            disabledGestures: true,
            drawer: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text(
                        'Love',
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'Settings',
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.close),
                      title: const Text(
                        'Close',
                      ),
                      onTap: () {
                        _advancedDrawerController.hideDrawer();
                      },
                    ),
                  ],
                ),
              ),
            ),
            child: _HomePageBody(
              onTap: () {
                _advancedDrawerController.showDrawer();
              },
            ),
          );
        },
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  final Function() onTap;

  const _HomePageBody({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            AppColors.primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: DefaultTabController(
            length: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeHeader(onTap: onTap),
                const TabBarSection(),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "Plants Collections",
                        style: GoogleFonts.abel().copyWith(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: DraggableSlider(
                    onPressed: null,
                    loop: true,
                    children: List.generate(
                      4,
                      (index) => ProductItem(
                        text: "The Potted Head ${index + 1}",
                        index: index,
                      ),
                    ),
                  ),
                ),
                const CartSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

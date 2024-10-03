import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../cubit/bot_cubit.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class BotPage extends StatelessWidget {
  const BotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BotCubit()..load(),
      child: const _BotPageBody(),
    );
  }
}

class _BotPageBody extends StatelessWidget {
  const _BotPageBody();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BotCubit>();
    return BlocBuilder<BotCubit, BotState>(
      builder: (context, state) {
        return MyScaffold(
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                const DefaultHeader(title: "Flora Bot"),
                Expanded(
                  child: Chat(
                    disableImageGallery: false,
                    dateFormat: DateFormat("HH:mm"),
                    scrollPhysics: const BouncingScrollPhysics(),
                    emptyState: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: "bot",
                          child: Lottie.asset(
                            'assets/lottie/bot2.json',
                            height: 20.h,
                            // animate: !cubit.isPlaying,
                            repeat: !cubit.isPlaying,
                          ),
                        ),
                        Visibility(
                          visible: cubit.isPlaying,
                          child: AnimatedTextKit(
                            repeatForever: false,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                "Hi, I'm Flora Bot\nHow can I help you?",
                                textStyle: AppFontStyles.readexProBold_16,
                                textAlign: TextAlign.center,
                                speed: const Duration(milliseconds: 70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    theme: DefaultChatTheme(
                      backgroundColor: Colors.transparent,
                      inputBackgroundColor: AppColors.darkGreen,
                      inputTextColor: Colors.white,
                      // secondaryColor: AppColors.li,
                      messageBorderRadius: 25,
                      attachmentButtonIcon: const Icon(
                        Icons.attach_file,
                        color: Colors.white,
                        size: 20,
                      ),
                      inputTextStyle: AppFontStyles.readexProBold_16,
                      primaryColor: AppColors.darkGreen,
                      highlightMessageColor: AppColors.lightGreen.withOpacity(0.9),

                    ),

                    messages: cubit.messages.reversed.toList(),
                    isAttachmentUploading: true,
                    onSendPressed: (text) {
                      log("text");
                      cubit.sendMessage(text.text);
                    },
                    user:cubit.user,
                    // onAttachmentPressed: _handleImageSelection,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _handleImageSelection() async {

}
// AIzaSyCa4KIqdrbpw0tLMeIJLFsEc3m6Etp4LEM

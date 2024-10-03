import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'bot_state.dart';

class BotCubit extends Cubit<BotState> {
  BotCubit() : super(BotInitial());

  final player = AudioPlayer();
  final botUser = const types.User(
    id: 'bot',
    firstName: 'Flora Bot',
    // imageUrl: 'https://avatars.githubusercontent.com/u/10099900?v=4',
  );
  final user = const types.User(
    id: 'user',
    firstName: 'User',
    // imageUrl: 'https://avatars.githubusercontent.com/u/10099900?v=4',
  );

  bool isPlaying = false;
  List<types.Message> messages = [];

  void load() async {
    await Future.wait([
      player.setSourceAsset(
        "audio/Flora Bot.wav",
      ),
      Future.delayed(const Duration(seconds: 1))
    ]);

    player.play(AssetSource("audio/Flora Bot.wav")).then(
          (value) {},
        );
    isPlaying = true;
    emit(BotLoadedSuccess());
  }

  Future<void> sendMessage(String message) async {
    messages.add(
      types.TextMessage(
        author: user,
        id: '${DateTime.now().millisecondsSinceEpoch}',
        text: message,
      ),
    );
    emit(BotLoading());
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyCa4KIqdrbpw0tLMeIJLFsEc3m6Etp4LEM",
    );

    // var prompt =
    //     'Hi gemini i want to check this message { $message } is question about plants or not , if not reply me with this message{this question is not about plants} if yes reply me with your answer normally';
    //
    var prompt = "Hi gemini i want to check this message { $message }\n and act like your name is flora bot and your model is train to answer question about plants only";
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    log(response.text ?? "");

    messages.add(
      types.TextMessage(
        author: botUser,
        id: '${DateTime.now().millisecondsSinceEpoch}',
        text: response.text ?? "",
      ),
    );

    emit(BotLoadedSuccess());
  }

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}

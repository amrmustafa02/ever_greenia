
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bot_state.dart';

class BotCubit extends Cubit<BotState> {
  BotCubit() : super(BotInitial());

  final player = AudioPlayer();
  bool isPlaying = false;

  load() async {
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

 @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}

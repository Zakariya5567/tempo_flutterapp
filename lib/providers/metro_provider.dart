import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tempo_bpm/utils/app_constant.dart';

class MetroProvider extends ChangeNotifier{


  bool isPlay = false;

  List<String> tapButtonList = ['4/4', '3/4','6/8'];

  double? tapTimestamp;
  double? bpm ;

  int selectedButton = 0;

  setSelectedButton(int value){
    selectedButton = value;
    notifyListeners();
  }


  double offsetX = 0;
  double offsetY = 0;
  double angle = 0;


  Timer? timer1;
  Timer? timer2;
  final player = AudioPlayer();

  play() async {

    if(isPlay == true){
      offsetX = 0;
      offsetY = 0;
      angle = 0;
      notifyListeners();
      await player.stop();
    }else {
      isPlay = true;
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) async {
        offsetX = 70;
        offsetY = 1;
        angle = 0.5;
        notifyListeners();
        await player.setAudioSource(AudioSource.asset(AppConstant.clickSound));
        await player.play();
        timer2 = Timer.periodic(const Duration(seconds: 1), (timer) async {
          offsetX = -70;
          offsetY = 1;
          angle = -0.5;
          notifyListeners();
          await player.setAudioSource(AudioSource.asset(AppConstant.clickSound));
          await player.play();
        });
      });

    }


    // if(player.playing){
    //   isPlay = false;
    //   notifyListeners();
    //   await player.stop();
    // }else{
    //   isPlay = true;
    //   notifyListeners();
    //   await player.setAudioSource(AudioSource.asset(AppConstant.beat1));
    //   await player.play();
    // }

    //Changes the current position (note: this does not affect the "playing" status).
    //await player.seek(Duration(milliseconds: 1200));



    //Disposes the player. It is calling release and also closes all open streams.
    // This player instance must not be used anymore!
    // await player.dispose();



    //Changes the playback rate (i.e. the "speed" of playback).
    //Defaults to 1.0 (normal speed). 2.0 would be 2x speed, etc.
    //await player.setPlaybackRate(0.5);


    //.loop: starts over after completion, looping over and over again.

    // audioPlayer.onPlayerComplete.listen((event) async {
    //   await audioPlayer.play(AssetSource(AppConstant.beat1));
    // });
    //
    // audioPlayer.onSeekComplete.listen((event) async {
    //   await audioPlayer.play(AssetSource(AppConstant.beat1));
    // });


    // timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
    //
    //   switch (audioPlayer.state) {
    //     case PlayerState.playing:
    //       await audioPlayer.stop();
    //       isPlay = false;
    //       notifyListeners();
    //       break;
    //     case PlayerState.stopped:
    //       isPlay = true;
    //       notifyListeners();
    //        await audioPlayer.play(AssetSource(AppConstant.beat1));
    //       break;
    //     case PlayerState.completed:
    //       isPlay = true;
    //       notifyListeners();
    //       await audioPlayer.play(AssetSource(AppConstant.beat1));
    //       break;
    //     default:
    //       print("${audioPlayer.state}");
    //       break;
    //   }
    // });

    // switch (audioPlayer.state) {
    //   case PlayerState.playing:
    //     audioPlayer.pause();
    //      isPlay = false;
    //      notifyListeners();
    //     break;
    //   case PlayerState.stopped:
    //     isPlay = true;
    //     notifyListeners();
    //    await audioPlayer.play(AssetSource(AppConstant.beat1));
    //
    //     break;
    //   case PlayerState.paused:
    //     await audioPlayer.resume();
    //     isPlay = true;
    //     notifyListeners();
    //     break;
    //   case PlayerState.completed:
    //     await audioPlayer.play(AssetSource(AppConstant.beat1));
    //     break;
    //   default:
    //     print("${audioPlayer.state}");
    //     break;
    // }

  }


}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tempo_bpm/utils/app_constant.dart';

class MetroProvider extends ChangeNotifier{


   double bpmMin = 1.0;
   double bpmMax = 300.0;
   double sliderMin = 1.0;
   double sliderMax = 300.0;

  List<String> tapButtonList = ['4/4', '3/4','6/8'];


  double position = 0;
  double bpm = 120;
  final player = AudioPlayer();
  int totalBeat = 4;
  int totalTick = 0;
  bool isPlaying = false;
  Timer? _timer;

   AnimationController? controller;
   Animation<double>? animation;


  initializeAnimationController(TickerProviderStateMixin ticker){
    controller = AnimationController(
      duration: Duration(milliseconds: (60000 / bpm).round()),
      vsync: ticker,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller!);
  }


  void disposeController() {
    isPlaying = false;
    if(controller != null){
      controller!.dispose();
    }
    if(_timer != null){
      _timer!.cancel();
    }
   }


  setPosition(double value){
    position = value;
    bpm  = value;
    notifyListeners();
  }

  void startStop(TickerProviderStateMixin ticker) {
      totalTick = 0;
      if (isPlaying) {
        if(_timer != null){
          _timer!.cancel();
        }
        controller!.reset();
        animation = Tween<double>(begin: 0, end: 1).animate(controller!);
      } else {
       setTimer(ticker);
      }
      isPlaying = !isPlaying;
    notifyListeners();


  }

  void increaseBpm(TickerProviderStateMixin ticker){
    if( bpm < bpmMax) {
        bpm += 1;
        notifyListeners();
      if(isPlaying == true){
        setTimer(ticker);
      }
    }
  }

  void decreaseBpm(TickerProviderStateMixin ticker) {
    if(bpm > bpmMin){
        bpm -= 1;
        if (bpm < 1) {
          bpm = 1;
        }
        notifyListeners();
      if(isPlaying == true){
        setTimer(ticker);
      }
    }
  }

  bool firstTime = true;

  setTimer(TickerProviderStateMixin ticker){

    if(_timer != null){
      _timer!.cancel();
    }
    _timer = Timer.periodic(
      Duration( milliseconds: (60000 / bpm).round()),
          (Timer timer) {
        playSound();
      },
    );

      controller = AnimationController(
        duration:  Duration( milliseconds: (60000 / bpm).round()),
        vsync: ticker,
      );
      animation = Tween<double>(begin: -1, end: 1).animate(controller!);
      controller!.repeat(reverse: true);


  }

  int selectedButton = 0;
  setBeats(index){
    if(index == 0 ){
        totalBeat = 4;
        selectedButton = index;
      notifyListeners();


    }else if(index == 1 ){
        totalBeat = 3;
        selectedButton = index;
        notifyListeners();
    }else if(index == 2 ){
        totalBeat = 6;
        selectedButton = index;
        notifyListeners();
    }

  }

  Future playSound()async{

    totalTick = totalTick+1;
    notifyListeners();
    if(totalTick == 1){
      await player.setAudioSource(AudioSource.asset(AppConstant.clickSound));
      if(player.playing == false){
        await player.play();
      }
    }else{
      if(totalTick<totalBeat){
        await player.setAudioSource(AudioSource.asset(AppConstant.tapSound));
        if(player.playing == false){
          await player.play();
        }
      }else{
        await player.setAudioSource(AudioSource.asset(AppConstant.tapSound));
        if(player.playing == false){
          await player.play();
        }
        totalTick = 0;
      }
    }
  }

  Future stopSound()async{
    if(player.playing){
      await player.stop();
    }
    totalTick = 0;
  }



}
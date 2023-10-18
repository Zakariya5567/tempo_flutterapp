import 'package:flutter/foundation.dart';
import 'package:tempo_bpm/utils/app_constant.dart';

class TapTempoProvider extends ChangeNotifier{

  List<double> tapIntervals = [];
  double? tapTimestamp;
  double? bpm ;
  String audioName = '';

  void handleTap() {

    final currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();

    if (tapTimestamp != null) {
      final interval = currentTime - tapTimestamp!;
      tapIntervals.add(interval);

      // Calculate average BPM
      final averageInterval = tapIntervals.reduce((a, b) => a + b) / tapIntervals.length;
      final newBpm = 60000 / averageInterval;
        bpm = newBpm;
        notifyListeners();
    }

    tapTimestamp = currentTime;
    //   setAudioName();
  }

  setAudioName(){
    if(bpm! < 20){
      audioName = '';
      notifyListeners();
    } else if(bpm! > 20){
      audioName = AppConstant.grave;
      notifyListeners();
    } else if(bpm! > 40){
      audioName = AppConstant.lento;
      notifyListeners();
    } else if(bpm! > 45){
      audioName = AppConstant.largo;
      notifyListeners();
    } else if(bpm! > 50){
      audioName = AppConstant.adagio;
      notifyListeners();
    } else if(bpm! > 55){
      audioName = AppConstant.adagio;
      notifyListeners();
    } else if(bpm! > 65){
      audioName = AppConstant.adagietto;
      notifyListeners();
    } else if(bpm! > 69){
      audioName = AppConstant.andante;
      notifyListeners();
    } else if(bpm! > 20){
      audioName = '';
      notifyListeners();
    } else if(bpm! > 168){
      audioName = AppConstant.presto;
      notifyListeners();
    } else if(bpm! > 177){
      audioName = AppConstant.prestissimo;
      notifyListeners();
    }
  }

  void clearBPM() {
      tapTimestamp = null;
      audioName = '';
      tapIntervals.clear();
      bpm = null;
      notifyListeners();
  }


}
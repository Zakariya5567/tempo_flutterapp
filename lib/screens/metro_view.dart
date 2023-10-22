import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:tempo_bpm/providers/metro_provider.dart';
import 'package:tempo_bpm/utils/images.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';



class MetroView extends StatefulWidget {
  const MetroView({super.key});

  @override
  State<MetroView> createState() => _MetroViewState();
}


class _MetroViewState extends State<MetroView> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    final metroProvider = Provider.of<MetroProvider>(context,listen: false);
     metroProvider.initializeAnimationController(this);
  }

  MetroProvider? metroProvider;

  @override
  void didChangeDependencies() {
    metroProvider = Provider.of<MetroProvider>(context,listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    metroProvider!.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<MetroProvider>(builder: (context, controller, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SPACER
            SizedBox(height: height * 0.04),

            Row(
              children: [

                // Button selection 3/3 ....
                SizedBox(
                  height: height * 0.40,
                  width: width * 0.165,
                  child: ListView.builder(
                      itemCount: controller.tapButtonList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return
                          GestureDetector(
                            onTap: () async {
                              controller.setBeats(index);
                            },
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                              child: Container(
                                height: height * 0.08,
                                width: height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:   controller.selectedButton == index ? AppColors.greySecondary : AppColors.greyPrimary,
                                ),
                                child: Center(
                                  child: Text(
                                    controller.tapButtonList[index],
                                    style: TextStyle(
                                      fontFamily: AppConstant.sansFont,
                                      color: AppColors.whitePrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                      }),),

                // SPACER
                SizedBox(width: width * 0.03),

                // Metronome
                Container(
                  alignment: Alignment.center,
                  height: height * 0.40,
                  width: width * 0.60,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: height * 0.40,
                        width: width * 0.60,
                        child: Image.asset(
                          Images.metronome,
                          height: height * 0.40,
                          width: width * 0.60,
                          fit: BoxFit.fill,
                        ),
                      ),

                      Positioned(
                        top: height * 0.052,
                        child: Container(
                          height:  height * 0.23,
                          width: width * 0.60,
                          alignment: Alignment.bottomCenter,
                          child: AnimatedBuilder(
                            animation:   controller.animation!,
                            builder: (context, child) {


                              //You can customize the translation and rotation values
                              double translationValue = 0 *   controller.animation!.value;
                              double rotationValue = 180 *   controller.animation!.value;
                              //

                              return Transform(
                                alignment: Alignment.bottomCenter,
                                transform: Matrix4.identity()
                                  ..translate(translationValue, 0.0)
                                  ..rotateZ(rotationValue * 0.0034533), // Convert degrees to radians
                                child: Stack(
                                  children: [

                                    Container(
                                      height: height * 0.40,
                                      width: width * 0.095,
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        Images.stalk,
                                        height: height * 0.40,
                                        width: width * 0.020,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Positioned(
                                      top:  height *controller.bpm*0.00058,
                                      left: width*0.002,
                                      child: Image.asset(
                                        Images.slider,
                                        height: height * 0.045,
                                        width: height * 0.045,
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        top: height*0.08,
                        left:width*0.003 ,
                        child: Container(
                          height: height * 0.40,
                          width: width * 0.60,
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            Images.metronomeBottom,
                            height: height * 0.40,
                            width: width * 0.42,
                          ),
                        ),
                      ),


                      Positioned(
                        left: width * 0.270,
                        top: height * 0.050,

                        child: Container(
                          alignment: Alignment.topCenter,
                          height: height * 0.21,
                          width: width * 0.060,
                          color: Colors.transparent,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child:
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 0.0, // Set trackHeight to 0 to remove the track
                                overlayShape: SliderComponentShape.noOverlay, // Remove overlay
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0), // Remove thumb
                                overlayColor: Colors.transparent, // Make overlay transparent
                              ),
                              child: Slider(
                                divisions: 300,
                                activeColor: Colors.red,
                                inactiveColor: Colors.green,
                                thumbColor: Colors.transparent,
                                value:  controller.bpm,
                                min: 1,
                                max:300,
                                onChanged: (value) {
                                    controller.setPosition(value,this);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),


            // SPACER
            SizedBox(
              height: height * 0.035,
            ),

            //Sound button with arrow down
            GestureDetector(
              onTap: () async {
                // controller.setSelectedButton(index);
              },
              child: Container(
                height: height * 0.065,
                width: width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.greyPrimary,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppConstant.sound,
                        style: TextStyle(
                          fontFamily: AppConstant.sansFont,
                          color: AppColors.whitePrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image.asset(Images.arrowDown,
                          width: width * 0.09,
                          height: width * 0.09,
                          color: AppColors.whiteSecondary)
                    ],
                  ),
                ),
              ),
            ),

            // SPACER
            SizedBox(
              height: height * 0.025,
            ),

            // BPM VALUE SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.decreaseBpm(this);
                  },
                  child: Container(
                    height: height * 0.038,
                    width: height * 0.038,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:  AppColors.redPrimary,
                    ),
                    child: Center(
                        child:
                        Icon(Icons.remove,color: AppColors.whitePrimary,)
                    ),
                  ),
                ),

                SizedBox(
                  width: width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstant.bpm,
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.whiteSecondary,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      controller.bpm == null
                          ? AppConstant.bpmNull
                          :  controller.bpm.toStringAsFixed(0),
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.whiteSecondary,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                GestureDetector(
                  onTap: (){
                    controller.increaseBpm(this);
                  },
                  child: Container(
                    height: height * 0.038,
                    width: height * 0.038,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:  AppColors.redPrimary,
                    ),
                    child: Center(
                        child:
                        Icon(Icons.add,color: AppColors.whitePrimary,)
                    ),
                  ),
                ),
              ],
            ),

            // SPACER
            SizedBox(
              height: height * 0.02,
            ),

            Center(
              child: GestureDetector(
                onTap: ()async{
                  controller.startStop(this);
                },
                child: Container(
                  height: height * 0.095,
                  width: height * 0.095,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:  AppColors.redPrimary,
                  ),
                  child: Center(
                      child:
                      Icon(
                        controller.isPlaying == true ? Icons.pause :
                        Icons.play_arrow,color: AppColors.whitePrimary,size: width*0.13,)
                  ),
                ),
              ),
            ),

          ],
        ),
      );
    });
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempo_bpm/providers/metro_provider.dart';
import 'package:tempo_bpm/providers/speed_provider.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';

class SpeedView extends StatelessWidget {
   SpeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<SpeedProvider>(builder: (context, controller, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal:0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // SPACER
            SizedBox(height: height * 0.08),

            const Heading(title: AppConstant.startingTempo, numbers: "100"),
            SizedBox(height: height * 0.020),
            SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: height*0.015,
                ),
                  overlayShape: SliderComponentShape.noOverlay,
                trackHeight: height*0.008
              ),
              child: Slider(

                activeColor: AppColors.whitePrimary,
                thumbColor: AppColors.whitePrimary,
                 min: 0,
                  max: 1,
                  value: 0.3, onChanged: (values){}),
            ),

            SizedBox(height: height * 0.04),

            const Heading(title: AppConstant.targetTempo, numbers: "240"),
            SizedBox(height: height * 0.020),
            SliderTheme(
              data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: height*0.015,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  trackHeight: height*0.008
              ),
              child: Slider(

                  activeColor: AppColors.whitePrimary,
                  thumbColor: AppColors.whitePrimary,
                  min: 0,
                  max: 1,
                  value: 0.3,
                  onChanged: (values){}
              ),
            ),

            SizedBox(height: height * 0.06),
            AddAndSubtractButton(
                title: AppConstant.bars,
                numbers: "2",
                description: AppConstant.howManyBars,
                onAdd: (){},
                onSubtract: (){}
            ),

            SizedBox(height: height*0.05,),

            AddAndSubtractButton(
                title: AppConstant.interval,
                numbers: "23",
                description:  AppConstant.howMuchItShouldIncrease,
                onAdd: (){},
                onSubtract: (){}
            ),

            SizedBox(height: height * 0.06),

            // BPM VALUE SECTION
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
                      : controller.bpm!.toStringAsFixed(1),
                  style: TextStyle(
                    fontFamily: AppConstant.sansFont,
                    color: AppColors.whiteSecondary,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

          ],
        ),
      );
    });
  }
}


class Heading extends StatelessWidget {
  const Heading({super.key,required this.title,required this.numbers});
  final String  title;
  final String  numbers;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return   Padding(
      padding:  EdgeInsets.symmetric(horizontal:width*0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: AppConstant.sansFont,
              color: AppColors.whitePrimary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),

          Text(
            numbers,
            style: TextStyle(
              fontFamily: AppConstant.sansFont,
              color: AppColors.whitePrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),


        ],
      ),
    );
  }
}


class AddAndSubtractButton extends StatelessWidget {
  const AddAndSubtractButton({super.key,
    required this.title,
    required this.numbers,
    required this.description,
    required this.onAdd,
    required this.onSubtract});

  final String  title;
  final String  description;
  final String  numbers;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;



  @override
  Widget build(BuildContext context) {


    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return   Padding(
      padding: EdgeInsets.symmetric(horizontal:width*0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height*0.07,
            width: width,

            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //how many bars

                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppConstant.sansFont,
                    color: AppColors.whiteLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),


                Row(

                  children: [

                    // MINUS BUTTON
                    GestureDetector(
                      onTap: (onSubtract),
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

                    SizedBox(width: width * 0.05),



                      Container(
                        height: height * 0.055,
                        width: width * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:  AppColors.greyPrimary,
                        ),
                        child: Center(
                          child:
                          Text(
                            numbers,
                            style: TextStyle(
                              fontFamily: AppConstant.sansFont,
                              color: AppColors.whitePrimary,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),


                    SizedBox(width: width * 0.05),
                    // PLUS BUTTON

                    GestureDetector(
                      onTap: (onAdd),
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

                  ],)

              ],
            ),
          ),

          SizedBox(height: height*0.01,),

          Text(
            description,
            style: TextStyle(
              fontFamily: AppConstant.sansFont,
              color: AppColors.whiteLight,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

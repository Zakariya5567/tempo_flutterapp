import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reg_page/reg_page.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';
import 'bpm_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    routes();
  }

  routes() async {
    bool? isLogin  = await LocalDB.getLogin;
    Timer(const Duration(seconds: 3), () {
   // if(isLogin == true){
   //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BPMScreen()));
   //  }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignUp()));
    //}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        color:AppColors.primaryBlack,
        child: Center(
          child: Text(
            AppConstant.jamieHarrison,
            style: TextStyle(
              color:AppColors.primaryWhite,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }
}

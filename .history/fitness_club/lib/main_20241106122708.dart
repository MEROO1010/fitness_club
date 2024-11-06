import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fitness_club/screens/LoginScreen.dart';
import 'package:fitness_club/screens/Onboarding.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': ((context) => Home()),
      '/login': (context) => Loginscreen(),
      //'/signup': (context) => signup(),
      //'/cappuccino': (context) => cappuccino(),
      //'/latte': (context) => latte(),
      //'/Espresso': (context) => Espresso(),
      //'/mocha': (context) => mocha(),
      //'/details': (context) => details(),
      //'/cardlist': (context) => cardlist(),
      //'/order': (context) => order()
    },
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: HexColor("#0F1B26"),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("assets/Logo.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const Onboarding(),
    );
  }
}

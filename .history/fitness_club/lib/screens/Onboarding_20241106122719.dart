import 'package:flutter/material.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:fitness_club/screens/LoginScreen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _HomePageState();
}

class _HomePageState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      items: [
        IntroductionSliderItem(
          logo: Image.asset("assets/Logo.png", alignment: Alignment.topCenter),
          title: Text("Fitness program that get the result"),
          subtitle: Text(
              'Tailored exercise routines designed just for you based on your fitness level and goals.'),
          backgroundImageDecoration: BackgroundImageDecoration(
              image: AssetImage("assets/onboarding1.png")),
        ),
        IntroductionSliderItem(
          logo: Image.asset("assets/Logo.png"),
          title: Text("Find the coach just is right for you"),
          subtitle: Text(
              'Expert trainers and nutritionists are here to provide guidance and answer your questions.'),
          backgroundImageDecoration: BackgroundImageDecoration(
              image: AssetImage("assets/onboarding2.png")),
        ),
      ],
      done: Done(
        child: Icon(Icons.done),
        home: Loginscreen(),
      ),
      next: Next(child: Icon(Icons.arrow_forward)),
      back: Back(child: Icon(Icons.arrow_back)),
      dotIndicator: DotIndicator(),
    );
  }
}

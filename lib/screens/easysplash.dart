import 'package:chat/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

class easysplash extends StatefulWidget {
  const easysplash({super.key});

  @override
  State<easysplash> createState() => _easysplashState();
}

class _easysplashState extends State<easysplash> {
// ignore: prefer_const_literals_to_create_immutables
  MaterialColor mycolor = MaterialColor(
    const Color.fromARGB(255, 14, 142, 159).value,
    // ignore: prefer_const_literals_to_create_immutables
    <int, Color>{
      50: const Color.fromARGB(255, 14, 142, 159),
      100: const Color.fromARGB(255, 14, 142, 159),
      200: const Color.fromARGB(255, 14, 142, 159),
      300: const Color.fromARGB(255, 14, 142, 159),
      400: const Color.fromARGB(255, 14, 142, 159),
      500: const Color.fromARGB(255, 14, 142, 159),
      600: const Color.fromARGB(255, 14, 142, 159),
      700: const Color.fromARGB(255, 14, 142, 159),
      800: const Color.fromARGB(255, 14, 142, 159),
      900: const Color.fromARGB(255, 14, 142, 159),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: mycolor,
            accentColor: mycolor,
            backgroundColor: Colors.pink,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        home: EasySplashScreen(
          logoWidth: 100,
          logo: Image.asset('images/filename.jpg',fit: BoxFit.fill,),
          backgroundImage: const AssetImage('images/73.png'),
          title: const Text('Welcome to Friends Chat',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),textAlign: TextAlign.center,),
          navigator: MyApp(),
          durationInSeconds: 5,
        ));
  }
}

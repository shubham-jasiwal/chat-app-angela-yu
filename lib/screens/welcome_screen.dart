import 'package:flutter/material.dart';
import 'package:wave/screens/camera_screen.dart';
import 'package:wave/screens/registration_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wave/Components/Roundbutton.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  // Animation colori;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    // animation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    // colori = ColorTween(begin: Colors.black12, end: Colors.green)
    //     .animate(controller);

    controller.forward();
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                ),
                DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Flash Chat1',
                          speed: const Duration(milliseconds: 500),
                          textStyle: const TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 20.0,
                                color: Colors.black87,
                                offset: Offset(10.0, 10.0),
                              ),
                            ],
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            padd(
              txt: 'LOGIN',
              color: Colors.blueAccent,
              onpress: () {
                // Navigator.pushNamed(context, LoginScreen.id);
                Navigator.pushNamed(context, TakePictureScreen.id);
              },
            ),
            padd(
              txt: 'REGISTER',
              color: Colors.amber,
              onpress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_assistant/screens/acc_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String routename = "/welcomescreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(animatedTexts: 
            [
              TyperAnimatedText('welcome to my app' , 
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              speed: Duration(milliseconds: 100)
              ),
              
            ],
            isRepeatingAnimation: false,
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AccountPage() ));
            },
            child: Text('Create an Account')
             )

          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mobile_app/login_screen.dart';
import 'reg_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build( BuildContext context) {
    return  Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:[
              Color(0xFF000000),
              Color(0xFF000000)
          ])
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top:50.0),
              child: Center(
                child: Center(
                  child: SizedBox(
                  height: 250,
                  width: 250,
                   child: Image(image: AssetImage('assets/img/splash_logo.png')),
                 ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text('Welcome Back!', style: TextStyle(
              fontSize: 30,
              color: Colors.white
            ),),
           const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
           const SizedBox(height: 30,),
           GestureDetector(
             onTap: (){
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => const RegScreen()));
             },
             child: Container(
               height: 53,
               width: 300,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(30),
                 border: Border.all(color: Colors.white),
               ),
               child: const Center(child: Text('SIGN UP',
                  style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.black
               ),),),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

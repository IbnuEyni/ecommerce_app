import 'package:ecommerce_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/splash.jpg'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            width: 390,
            height: 844,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF3F51F3).withOpacity(0),
                  const Color(0xFF3F51F3).withOpacity(1),
                ],
                stops: const [0.0, 3.0288],
              ),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          // Centered box
          Positioned(
            top: 279,
            left: 63,
            child: Center(
              child: InkWell(
                onTap: () {
                  context.push('/signin');
                },
                child: Container(
                  width: 294,
                  height: 121,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(31.03),
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 9.31,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'ECOM',
                      style: TextStyle(
                        fontFamily: 'Caveat Brush',
                        fontSize: 82.89,
                        fontWeight: FontWeight.w900,
                        height: 102.41 / 121.89,
                        letterSpacing: 0.02,
                        color: Color(0xFF3F51F3),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Text under the box
          Positioned(
            top: 426,
            left: 39,
            child: Container(
              width: 331,
              height: 38,
              child: const Center(
                child: Text(
                  'ECOMMERCE APP',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 35.98,
                    fontWeight: FontWeight.w500,
                    height: 37.42 / 35.98,
                    letterSpacing: 0.02,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

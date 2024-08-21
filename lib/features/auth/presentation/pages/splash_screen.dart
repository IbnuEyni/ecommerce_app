import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            // ECOM Box
            Positioned(
              top: 122,
              left: 124,
              child: Container(
                width: 144,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6.41),
                  ),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0.93,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'ECOM',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            // "Sign into your account" Text
            const Positioned(
              top: 252,
              left: 50,
              child: Text(
                'Sign into your account',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26.72,
                  fontWeight: FontWeight.w600,
                  height: 111.58,
                  letterSpacing: 0.02,
                  // textAlign: TextAlign.left,
                  color: Colors.black,
                ),
              ),
            ),
            // Email Label
            const Positioned(
              top: 322.84,
              left: 51,
              child: Text(
                'Email',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 49.85,
                  letterSpacing: 0.02,
                  // textAlign: TextAlign.left,
                  color: Color(0xFF6F6F6F),
                ),
              ),
            ),
            // Email TextField
            Positioned(
              top: 346.84,
              left: 51,
              child: Container(
                width: 288,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Password Label
            const Positioned(
              top: 401.84,
              left: 51,
              child: Text(
                'Password',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 49.85,
                  letterSpacing: 0.02,
                  // textAlign: TextAlign.left,
                  color: Color(0xFF6F6F6F),
                ),
              ),
            ),
            // Password TextField
            Positioned(
              top: 425.84,
              left: 51,
              child: Container(
                width: 288,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Sign In Button
            Positioned(
              top: 504.84,
              left: 51,
              child: InkWell(
                onTap: () {
                  // Handle sign-in action
                },
                child: Container(
                  width: 288,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3F51F3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Row for "Don’t have an account? Sign up"
            Positioned(
              top: 698.84,
              left: 51,
              child: Row(
                children: [
                  const Text(
                    'Don’t have an account? ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 49.85,
                      letterSpacing: 0.02,
                      // textAlign: TextAlign.left,
                      color: Color(0xFF888888),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle sign-up navigation
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 49.85,
                        letterSpacing: 0.02,
                        // textAlign: TextAlign.left,
                        color: Color(0xFF3F51F3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscurePassword =
      true; // This variable controls the visibility of password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            const Center(child: CircularProgressIndicator());
          } else if (state is LoginLoaded) {
            _emailController.clear();
            _passwordController.clear();
            context.push('/home');
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 122), // Spacing from the top
                // ECOM Box
                Container(
                  width: 144,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.41),
                    ),
                    border: Border.all(
                      color: const Color(0xFF3F51F3),
                      width: 0.93,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x66000000),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'ECOM',
                        style: TextStyle(
                          fontFamily: 'Caveat Brush', // Updated font family
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          height:
                              24.26 / 48, // Line height divided by font size
                          letterSpacing: 0.02,
                          color: Color(0xFF3F51F3), // Text color
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height:
                        80), // Spacing between ECOM and "Sign into your account"
                // "Sign into your account" Text
                const Text(
                  'Sign into your account',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26.72,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                    letterSpacing: 0.02,
                    color: Color.fromARGB(255, 90, 87, 87),
                  ),
                  textAlign: TextAlign.left,
                ),

                const SizedBox(height: 45),
                // Email Label
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        letterSpacing: 0.02,
                        color: Color(0xFF6F6F6F),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 8),
                    // Email TextField
                    Container(
                      width: 288,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        letterSpacing: 0.02,
                        color: Color(0xFF6F6F6F),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 8),
                    // Password TextField
                    Container(
                      width: 288,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF6F6F6F),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 45),
                    InkWell(
                      onTap: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (email.isNotEmpty && password.isNotEmpty) {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginRequested(email: email, password: password));
                        }
                      },
                      child: Container(
                        width: 288,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3F51F3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
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
                  ],
                ),
                const SizedBox(height: 130),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        letterSpacing: 0.02,
                        color: Color(0xFF888888),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/signup');
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                          letterSpacing: 0.02,
                          color: Color(0xFF3F51F3),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Spacing for the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

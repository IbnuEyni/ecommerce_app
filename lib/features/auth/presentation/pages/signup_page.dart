import 'package:ecommerce_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/custom_password_tex_field_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Main SignUpPage
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF3F51F3)),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Container(
                width: 78,
                height: 30,
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
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'ECOM',
                    style: TextStyle(
                      fontFamily: 'Caveat Brush',
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 24.26 / 48,
                      letterSpacing: 0.02,
                      color: Color(0xFF3F51F3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is SignupLoaded) {
            context.push('/signin');
          } else if (state is SignupError) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 72),
                const Center(
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26.72,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                        letterSpacing: 0.02,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextFields(
                  label: 'Name',
                  hintText: 'Enter your full name',
                  controller: _nameController,
                ),
                const SizedBox(height: 24),
                CustomTextFields(
                  label: 'Email',
                  hintText: 'Enter your email address',
                  controller: _emailController,
                ),
                const SizedBox(height: 24),
                CustomPasswordField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  isPasswordVisible: _isPasswordVisible,
                  onVisibilityChanged: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 24),
                CustomPasswordField(
                  label: 'Confirm Password',
                  hintText: 'Confirm your password',
                  controller: _confirmPasswordController,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onVisibilityChanged: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsAccepted = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      'I understand the ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'terms & policy',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF3F51F3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                InkWell(
                  onTap: () {
                    BlocProvider.of<SignupBloc>(context).add(
                      SignUpRequested(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3F51F3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'SIGN UP',
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF888888),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/signin');
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3F51F3),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

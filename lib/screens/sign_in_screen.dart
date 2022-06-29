import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sugoi/api/api.dart';

import 'main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Api _api = Api();

  bool _signInLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Masuk",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buttonItem("assets/phone.svg", "Masuk dengan no. HP", 30,
                      () {}),
              const SizedBox(height: 20),
              const Text("Atau",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 20),
              _textItem("Username....", _usernameController, false),
              const SizedBox(height: 18),
              _textItem("Password....", _passwordController, true),
              const SizedBox(height: 40),
              _signInButton(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Belum memiliki akun?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 3),
                  InkWell(
                    onTap: () {},   // TODO: Implement moving to sign up page
                    child: const Text(
                      "Daftar sekarang!",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                       ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Lupa Password?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonItem(String imagePath, String buttonName, double imageSize,
      Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                height: imageSize,
                width: imageSize,
              ),
              const SizedBox(width: 15),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textItem(
      String labelText, TextEditingController controller, bool obscureText) {
    const fontStyle = TextStyle(
      fontSize: 17,
      color: Colors.white,
    );

    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: fontStyle,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: fontStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1.5, color: Colors.amber),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1.5, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          _signInLoading = true;
        });
        bool isSuccess = await _api.signIn(
          _usernameController.text, _passwordController.text
        );
        setState(() {
          _signInLoading = false;
        });

        if (!isSuccess || !mounted) {
          return;
        }

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const MainScreen()),
            (route) => false,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c)
            ],
          ),
        ),
        child: Center(
          child: _signInLoading
              ? const CircularProgressIndicator()
              : const Text("Masuk",
                style: TextStyle(color: Colors.white, fontSize: 20,),
          ),
        ),
      ),
    );
  }
}

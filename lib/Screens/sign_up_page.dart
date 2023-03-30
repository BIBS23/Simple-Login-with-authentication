import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/btn.dart';
import '../components/text_field.dart';
import '../provider/signup_controller.dart';
import 'login_screen.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<SignUpController>(builder: (context, signup, child) {
      final emailController = signup.emailcontroller;
      final passwordController = signup.passwordcontroller;
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                0,
                0.5,
                1
              ],
                  colors: [
                Colors.grey.shade200,
                Colors.blue.shade100,
                Colors.blueAccent.withOpacity(0.3),
              ])),
          child: Column(children: [
            const SizedBox(height: 200),
            Text('Create Account',
                style: TextStyle(fontSize: 25, color: Colors.grey.shade700)),
            const SizedBox(height: 20),
            MyTextField(
                obscureText: false,
                controller: emailController,
                hint: 'Email',
                color: Colors.white.withOpacity(0.3)),
            const SizedBox(height: 15),
            MyTextField(
                obscureText: true,
                controller: passwordController,
                hint: 'Password',
                color: Colors.white.withOpacity(0.3)),
            const SizedBox(height: 15),
            MyTextField(
                obscureText: true,
                controller: passwordController,
                hint: 'Confirm Password',
                color: Colors.white.withOpacity(0.3)),
            const SizedBox(height: 20),
            Btn(
                btntext: 'Sign Up',
                onpressed: () {
                  
                   signup.createUser(
                      emailController.text, passwordController.text).then((_) => 
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginPage())));
                 
                }),
          ]),
        ),
      );
    }));
  }
}

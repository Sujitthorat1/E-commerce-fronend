import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/presentation/screens/auth/provider/login_provider.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    //here listen is by default false
    //if you change false to true then it will refresh the complete screen

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("E-commerce app"),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text("LogIn", style: TextStyles.heading2),
          ),
          const GapWidget(
            size: -10,
          ),
          (provider.error != "")
              ? Text(
                  provider.error,
                  style: const TextStyle(color: Colors.red),
                )
              : const SizedBox(),
          const GapWidget(
            size: 5,
          ),
          PrimaryTextField(
              controller: provider.emailController, labelText: "Email Address"),
          const GapWidget(),
          PrimaryTextField(
              obscureText: true,
              controller: provider.passwordController,
              labelText: "Password"),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LinkButton(
                text: "Forgot Password?",
                onPressed: () {},
              ),
            ],
          ),
          const GapWidget(),
          PrimaryButton(
            text: (provider.isLoading) ? "..." : "Log In",
            onPressed: provider.login,
          ),
          const GapWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 16),
              ),
              const GapWidget(),
              LinkButton(
                text: "Sign up",
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                },
              )
            ],
          )
        ],
      )),
    );
  }
}

import 'package:ecommerce/presentation/screens/auth/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = "SignUp";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
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
            onPressed: provider.createAccount,
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
                  // Navigator.pushNamed(context)

                },
              )
            ],
          )
        ],
      )),
    );
  }
}

import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/presentation/screens/auth/provider/login_provider.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return BlocListener<UserCubit, UserState>(
      //logic to go home screen after login
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("E-commerce app"),
        ),
        body: SafeArea(
            child: Form(
          key: provider.formKey,
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
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address is required!";
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                  labelText: "Email Address"),
              const GapWidget(),
              PrimaryTextField(
                  obscureText: true,
                  controller: provider.passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter valid password!";
                    }
                    return null;
                  },
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
                color: AppColors.accent,
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
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

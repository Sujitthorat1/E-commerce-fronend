import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../../logic/cubits/user_cubit/user_state.dart';
 
class SignUpProvider with ChangeNotifier {
  //this build context is used for the build only the required screen not whole screen
  final BuildContext context;
  SignUpProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    // log("listening to user state ....");
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<UserCubit>(context)
        .signIn(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription
        ?.cancel(); //there is chance to _userSubscription could be a nullable
    super.dispose();
  }
}

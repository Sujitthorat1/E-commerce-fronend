import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce/presentation/screens/user/edit_profile_screen.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = "order-screen";
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order screen"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Details",
                          style: TextStyles.heading3
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const GapWidget(),
                        Text(
                          "${user.fullName}",
                          style: TextStyles.body2,
                        ),
                        Text(
                          "Email:${user.email}",
                          style: TextStyles.body2,
                        ),
                        Text(
                          "address: ${user.address},${user.city},${user.state}",
                          style: TextStyles.body2,
                        ),
                        LinkButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, EditProfileScreen.routeName);
                            },
                            text: "Edit Profile")
                      ],
                    ),
                  );
                }
                if (state is UserErrorState) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}

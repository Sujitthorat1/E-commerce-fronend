import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/logic/services/razorpay.dart';
import 'package:ecommerce/presentation/screens/order/order_placed_screen.dart';
import 'package:ecommerce/presentation/screens/order/providers/order_detail_provider.dart';
import 'package:ecommerce/presentation/screens/user/edit_profile_screen.dart';
import 'package:ecommerce/presentation/widgets/cart_list_view.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
          padding: const EdgeInsets.all(16),
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;

                  return Column(
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
                  );
                }
                if (state is UserErrorState) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            ),
            //items
            const GapWidget(
              size: 10,
            ),
            Text("Items",
                style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold)),
            const GapWidget(),

            //cart items
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState && state.items.isEmpty) {
                  return const CircularProgressIndicator();
                }
                if (state is CartErrorState && state.items.isEmpty) {
                  return Text(state.message);
                }
                return CartListView(
                  items: state.items,
                  shrinkWrap: true,
                  noScroll: true,
                );
              },
            ),

            //payment
            const GapWidget(),
            Text("Payment",
                style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold)),
            const GapWidget(),
            Consumer<OrderDetailProvider>(builder: (context, provider, child) {
              return Column(
                children: [
                  RadioListTile(
                    value: "pay-on-delevary",
                    groupValue: provider.paymentMethod,
                    contentPadding: EdgeInsets.zero,
                    onChanged: provider.changePaymentMethod,
                    title: const Text("Pay-On-Delevary"),
                  ),
                  RadioListTile(
                    value: "pay-now",
                    groupValue: provider.paymentMethod,
                    contentPadding: EdgeInsets.zero,
                    onChanged: provider.changePaymentMethod,
                    title: const Text("Pay Now"),
                  ),
                  const GapWidget(),

                  //go to the order places screen
                  PrimaryButton(
                      onPressed: () async {
                        OrderModel? newOrder =
                            await BlocProvider.of<OrderCubit>(context)
                                .createOrder(
                          items:
                              BlocProvider.of<CartCubit>(context).state.items,
                          paymentMethod: Provider.of<OrderDetailProvider>(
                                  context,
                                  listen: false)
                              .paymentMethod
                              .toString(),
                        );
                        if (newOrder == null) return;

                        if (newOrder.status == "payment-pending") {
                          RazorPayServices.checkoutOrder(
                            newOrder,
                            onSuccess: (response) {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.pushNamed(
                                  context, OrderPlacedScreen.routeName);
                            },
                            onFailure: (response) {
                              if (kDebugMode) {
                                print("Payment Failed");
                              }
                            },
                          );
                        }
                        if (newOrder.status == "order-placed") {
                          // ignore: use_build_context_synchronously
                          Navigator.popUntil(context, (route) => route.isFirst);
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(
                              context, OrderPlacedScreen.routeName);
                        }
                      },
                      text: "Place Order")
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

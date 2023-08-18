import 'package:ecommerce/core/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});
  static const routeName = "order_placed";

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title:  const Text("Order Placed!", style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
      body:  Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.cube_box_fill,size: 100, color: Colors.lightBlue,),
          Text("Order Placed!", style: TextStyles.body1,),
           Text("Track your your order in 'My Order'",style: TextStyles.body2,)
        ],),
      ),
    );
  }
}

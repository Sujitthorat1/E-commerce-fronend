import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import '../../../data/models/product/product_model.dart';
import '../../../logic/services/formatter.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  static const routeName = "product_details";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: widget.productModel.images?.length ?? 0,
              slideBuilder: (index) {
                String url = widget.productModel.images![index];

                return CachedNetworkImage(imageUrl: url);
              },
            ),
          ),
          const GapWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.productModel.title}",
                  style: TextStyles.heading3,
                ),
                Text(
                  Formatter.formatPrice(widget.productModel.price!),
                  style: TextStyles.heading2,
                ),
                const GapWidget(
                  size: 10,
                ),
                PrimaryButton(onPressed: () {}, text: "Add to cart"),
                 const GapWidget(
                  size: 10,
                ),
              
              Text("Description", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),),
              Text("${widget.productModel.description}", style: TextStyles.body2,)
              ],  
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../../core/ui.dart';
import '../../data/models/product/product_model.dart';
import '../../logic/services/formatter.dart';
import '../screens/product/product_detail_screen.dart';
import 'gap_widget.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName,
                arguments: product);
          },
          child: Row(
            children: [
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 6,
                imageUrl: "${product.images?[0]}",
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.title}",
                      style: TextStyles.body1
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${product.description}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyles.body2.copyWith(color: AppColors.textLight),
                    ),
                    const GapWidget(
                      size: -10,
                    ),
                    Text(
                      Formatter.formatPrice(product.price!),
                      style: TextStyles.body1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

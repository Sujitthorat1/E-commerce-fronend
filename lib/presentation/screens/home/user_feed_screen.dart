
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecommerce/logic/cubits/product_cubit/product_state.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui.dart';
import '../../../logic/services/formatter.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message),
          );
        }
        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final product = state.products[index];
            return Row(
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 6,
                  imageUrl:"${product.images?[0]}",
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.title}",
                        style: TextStyles.body1
                            .copyWith(fontWeight: FontWeight.bold),
                            maxLines: 3,overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${product.description}",
                        maxLines: 3, overflow: TextOverflow.ellipsis,
                        style:
                            TextStyles.body2.copyWith(color: AppColors.textLight),
                      ),
                      const GapWidget(size: -10,),
                      Text(
                        "₹${Formatter.formatPrice(product.price!)}",
                        style: TextStyles.body1,
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed:() {
                  
                }, icon: const Icon(CupertinoIcons.cart))
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/auth/provider/login_provider.dart';
import 'package:ecommerce/presentation/screens/auth/provider/signup_provider.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:ecommerce/presentation/screens/product/product_detail_screen.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce/presentation/screens/user/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/product/category_product_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => LoginProvider(context),
              child: const LoginScreen()),
        );

      case SignUpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignUpProvider(context),
            child: const SignUpScreen(),
          ),
        );

      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case ProductDetailScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProductDetailScreen(
            productModel: settings.arguments as ProductModel,
          ),
        );

      case CartScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const CartScreen(),
        );

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CategoryProductCubit(settings.arguments as CategoryModel),
            child: const CategoryProductScreen(),
          ),
        );

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      default:
        return null;
    }
  }
}

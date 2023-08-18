import 'dart:async';
import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/data/repositories/order_repository.dart';
import 'package:ecommerce/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce/logic/services/calculation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../cart_cubit/cart_cubit.dart';
import '../user_cubit/user_cubit.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  //this cart cubit is for the delete the item in the cart after ordering the product
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;

  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    // initial value
    _handleUserState(_userCubit.state);

    //Listening to user cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(OrderInitialState());
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _orderRepository.fetchCartForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (e) {
      emit(OrderErrorState(e.toString(), state.orders));
    }
  }

  Future<OrderModel?> createOrder(
      {required List<CartItemModel> items,
      required String paymentMethod}) async {
    emit(OrderLoadingState(state.orders));
    try {
      if (_userCubit.state is! UserLoggedInState) {
        return null;
      }
      OrderModel newOrder = OrderModel(
          items: items,
          totalAmount: Calculation.cartTotal(
              items), //do changes for the total amount calculation
          user: (_userCubit.state as UserLoggedInState).userModel,
          status: (paymentMethod == "pay-on-delevary")
              ? "order-placed"
              : "payment-pending");
      final order = await _orderRepository.createOrder(newOrder);
      List<OrderModel> orders = [
        ...state.orders,
        order
      ]; //triple dot(...) means we are inserting one more array in the current array
      emit(OrderLoadedState(orders));
      // function call for the clear the cart
      _cartCubit.clearCart(); 
      return order;
    } catch (e) {
      emit(OrderErrorState(e.toString(), state.orders));
      return null;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

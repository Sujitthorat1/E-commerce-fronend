import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
class OrderModel {
  String? sId;
  UserModel? user;              // here UserModel And the CartItemModel is already present so we are fetch these model for use in our Order model 
  List<CartItemModel>? items;
  String? status;
  String? updatedOn;
  String? createdOn;
  OrderModel(
      {this.sId,
      this.user,
      this.items,
      this.status,
      this.updatedOn,
      this.createdOn});
  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = UserModel.fromJson(json["user"]); //fetch data from the user model
    items = (json["items"] as List<dynamic>)
        .map((item) => CartItemModel.fromJson(item))
        .toList();
    status = json['status'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = sId;
    data['user'] = user!.toJson();
    data['items'] =
        items!.map((item) => item.toJson(objectMode: true)).toList();
    data['status'] = status;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    return data;
  }
}

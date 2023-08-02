import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/user/user_model.dart';

final _api = Api();

class UserRepository {
  Future<UserModel> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequest.post("/user/createAccount",
          data: jsonEncode({
            'email': email,
            'password': password,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //Convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }
}

Future<UserModel> signIn({
  required String email,
  required String password,
}) async {
  try {
    Response response = await _api.sendRequest.post("/user/signIn",
        data: jsonEncode({
          "email": email,
          "password": password,
        }));
    ApiResponse apiResponse = ApiResponse.fromResponse(response);

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }

    //Converting row data to the model
    return UserModel.fromJson(apiResponse.data);
  } catch (ex) {
    rethrow;
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_store/model/user_model.dart';
import 'package:mobile_store/provider/account_provider.dart';
import 'package:mobile_store/view/app_home.dart';

class UserController {
  void authentication(String firstName, String lastName, String phone,
      String email, String password, bool isLogin, BuildContext context, ref) {
    if (isLogin) {
      ref.read(accountProvider.notifier).userCredentials(UserModel(
            email: email,
            password: password,
            firstName: 'firstName',
            lastName: 'lastName',
            phone: 'phone Number',
          ));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const AppHome(),
        ),
      );
    } else {
      ref.read(accountProvider.notifier).userCredentials(UserModel(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
          ));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const AppHome(),
        ),
      );
    }
  }
}

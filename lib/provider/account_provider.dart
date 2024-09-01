import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/model/user_model.dart';

class AccountProviderNotifier extends StateNotifier<UserModel> {
  AccountProviderNotifier()
      : super(const UserModel(
          email: '',
          password: '',
          phone: '',
          lastName: '',
          firstName: '',
        ));

  void userCredentials(UserModel user) {
    state = user;
  }
}

final accountProvider =
    StateNotifierProvider<AccountProviderNotifier, UserModel>(
  (ref) => AccountProviderNotifier(),
);

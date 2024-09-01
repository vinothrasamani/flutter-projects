import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/controller/user_controller.dart';
import 'package:mobile_store/provider/products_provider.dart';

class Authentication extends ConsumerStatefulWidget {
  const Authentication({
    super.key,
  });

  @override
  ConsumerState<Authentication> createState() {
    return _AuthenticationState();
  }
}

class _AuthenticationState extends ConsumerState<Authentication> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  var _firstName = '';
  var _lastName = '';
  var _phone = '';
  var _email = '';
  var _password = '';

  @override
  void initState() {
    ref.read(productsProvider.notifier).loadProducts();
    super.initState();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserController().authentication(_firstName, _lastName, _phone, _email,
          _password, isLogin, context, ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    TextStyle fontColor = const TextStyle(
      color: Colors.white,
    );
    SizedBox gap = const SizedBox(height: 20);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/design3.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: width <= 480 ? null : BorderRadius.circular(20),
                color: Colors.black26,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 5,
              ),
              width: width <= 480
                  ? double.infinity
                  : width < 800
                      ? width / 1.3
                      : width < 1200
                          ? width / 1.7
                          : width / 2.1,
              constraints: BoxConstraints(
                minHeight: width <= 480 ? height : 0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: width <= 480 ? keyboard / 2.5 : 20,
                    ),
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                    SizedBox(
                      height: isLogin ? 80 : 60,
                    ),
                    if (!isLogin)
                      Column(
                        children: [
                          TextFormField(
                            style: fontColor,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'First name must be entered..';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _firstName = newValue!,
                          ),
                          gap,
                          TextFormField(
                            style: fontColor,
                            decoration:
                                const InputDecoration(labelText: 'Last Name'),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Last name must be entered..';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _lastName = newValue!,
                          ),
                          gap,
                          TextFormField(
                            style: fontColor,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: 'Phone Number'),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  num.tryParse(value) == null ||
                                  value.trim().length > 15) {
                                return 'provide valide phone number..';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _phone = newValue!,
                          ),
                        ],
                      ),
                    gap,
                    TextFormField(
                      style: fontColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(labelText: 'E-mail Address'),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !(value.contains('@')) ||
                            !(value.contains('.'))) {
                          return 'Must enter valide E-mail address!';
                        }
                        return null;
                      },
                      onSaved: (newValue) => _email = newValue!,
                    ),
                    gap,
                    TextFormField(
                      style: fontColor,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Must enter password!';
                        }
                        if (value.trim().length < 6) {
                          return 'Password must have atleast 6 characters!';
                        }
                        return null;
                      },
                      onSaved: (newValue) => _password = newValue!,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        _submit(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          isLogin ? 'Log in' : 'Create Account',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: isLogin ? 110 : 50),
                    Text(
                      isLogin
                          ? 'Don\'t have an account?'
                          : 'Already have an account!',
                      style: fontColor,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Text(
                          isLogin ? 'Create' : 'Log in',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

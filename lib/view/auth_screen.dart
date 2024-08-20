import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vsd_chat/widgets/profile_image.dart';

final auth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  var _isLogin = true;
  var _isLoading = false;
  var _email = '';
  var _userName = '';
  var _password = '';
  File? _selectedImage;
  final formkey = GlobalKey<FormState>();

  void message(msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        content: Text(msg),
      ),
    );
  }

  void _submit() async {
    if (formkey.currentState!.validate()) {
      if (!_isLogin && _selectedImage == null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Error!',
            ),
            titleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 216, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold),
            content: const Text(
              'Please upload a profile image by clicking circular animated avatar!',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              )
            ],
          ),
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });
      formkey.currentState!.save();

      try {
        if (_isLogin) {
          await auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          message('Logged in Successfully!');
        } else {
          final userDatails = await auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_image')
              .child('${userDatails.user!.uid}.jpg');
          await storageRef.putFile(_selectedImage!);
          final imageUrl = await storageRef.getDownloadURL();
          debugPrint(imageUrl);

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userDatails.user!.uid)
              .set({
            'username': _userName,
            'email': _email,
            'imgeurl': imageUrl,
          });
          message('Sign up Successfully');
        }
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (err) {
        message(err.message ?? 'Authentication Failed');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 320,
                child: Image.asset(
                  'assets/images/register.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _isLogin ? 'Sign In' : 'Sign Up',
                          style: TextStyle(
                            fontSize: 25,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (!_isLogin)
                          ProfileImage(
                            onselectImage: (image) {
                              _selectedImage = image;
                            },
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'E-Mail ID',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter valid E-Mail address';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _email = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'User Name',
                            ),
                            enableSuggestions: false,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length < 4) {
                                return "Please enter atleast 4 character user name!";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _userName = newValue!;
                            },
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must have atleast 6 characters!';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _submit,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  _isLogin ? 'Sign In' : 'Sign Up',
                                ),
                        ),
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                          child: Text(_isLogin
                              ? 'Create a new Account!'
                              : 'I already have an account!'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

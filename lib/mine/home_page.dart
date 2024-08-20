import 'package:flutter/material.dart';
import 'package:http_crud_app/mine/crud.dart';
import 'package:http_crud_app/mine/custom_button.dart';
import 'package:http_crud_app/mine/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My CRUD Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                btnName: 'Get',
                color: const Color.fromARGB(255, 19, 79, 0),
                icon: Icons.download_for_offline_rounded,
                func: () async {
                  var res = await Crud()
                      .get('/users')
                      .catchError((err) => debugPrint);
                  if (res == null) return;
                  debugPrint('Success!');
                  var users = modelFromJson(res);
                  debugPrint(users.length.toString());
                },
              ),
              CustomButton(
                btnName: 'Post',
                color: const Color.fromARGB(255, 0, 101, 99),
                icon: Icons.cloud_upload,
                func: () async {
                  var user = Model(
                    name: 'vinoth',
                    age: 21,
                    address: 'natham.',
                  );
                  var res = await Crud()
                      .post(
                        '/users',
                        user,
                      )
                      .catchError((err) => debugPrint(err));
                  if (res == null) {
                    debugPrint('failed');
                    return;
                  }

                  debugPrint('Success!');
                },
              ),
              CustomButton(
                btnName: 'Put',
                color: const Color.fromARGB(255, 61, 0, 101),
                icon: Icons.edit_note,
                func: () async {
                  var id = 6;
                  var user = Model(
                    name: 'sanjay',
                    age: 34,
                    address: 'madurai.',
                  );
                  var res = await Crud()
                      .put(
                        '/users/$id',
                        user,
                      )
                      .catchError((err) => debugPrint(err));
                  if (res == null) {
                    debugPrint('failed');
                    return;
                  }

                  debugPrint('Success!');
                },
              ),
              CustomButton(
                btnName: 'Dalete',
                icon: Icons.delete,
                color: const Color.fromARGB(255, 83, 0, 79),
                func: () async {
                  var id = 8;
                  var res = await Crud()
                      .delete(
                        '/users/$id',
                      )
                      .catchError((err) => debugPrint(err));
                  if (res == null) {
                    debugPrint('failed');
                    return;
                  }

                  debugPrint('Success!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

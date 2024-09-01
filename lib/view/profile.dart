import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/provider/account_provider.dart';
import 'package:mobile_store/view/authentication.dart';
import 'package:mobile_store/widgets/my_text.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final user = ref.watch(accountProvider);

    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin:
              height < 500 ? const EdgeInsets.symmetric(vertical: 15) : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(60, 75, 75, 75),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: width > 500
                  ? width > 800
                      ? width > 1000
                          ? 80
                          : 60
                      : 40
                  : 20,
              vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage('assets/images/user.png'),
                radius: width > 800
                    ? width > 1100
                        ? 110
                        : 80
                    : 60,
              ),
              const SizedBox(
                height: 30,
              ),
              MyText(
                iconData: Icons.person,
                fontsize: 16,
                label: 'Name',
                value: '${user.firstName} ${user.lastName}',
              ),
              const SizedBox(
                height: 10,
              ),
              MyText(
                iconData: Icons.phone,
                fontsize: 16,
                label: 'phone',
                value: user.phone,
              ),
              const SizedBox(
                height: 10,
              ),
              MyText(
                iconData: Icons.mail_outline,
                fontsize: 16,
                label: 'E-mail',
                value: user.email,
              ),
              const SizedBox(
                height: 25,
              ),
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const Authentication(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: width > 800
                      ? const EdgeInsets.symmetric(vertical: 15, horizontal: 30)
                      : const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.logout_outlined),
                label: Text(
                  'Logout',
                  style: TextStyle(fontSize: width > 800 ? 20 : 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/screen/auth/provider/user_auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: SizedBox(
      height: size.height,
      width: size.width,
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              ref.read(userAuthController.notifier).login("Aradhya", "123");
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Login With FingerPrint",
                  textAlign: TextAlign.center,
                ),
                Icon(Icons.fingerprint),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

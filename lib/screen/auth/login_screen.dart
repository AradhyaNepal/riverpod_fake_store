import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/screen/auth/provider/user_auth_controller.dart';

import '../../common/model/state_data.dart';
import 'model/auth.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(userAuthController.notifier).login("Aradhya", "123");
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 25,),
                    Text(
                      "Login With FingerPrint",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 25,),
                    Icon(
                      Icons.fingerprint,
                      size: 100,
                    ),
                    SizedBox(height: 25,),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                (ref.watch(userAuthController) as GenericState<Auth>)
                    .errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

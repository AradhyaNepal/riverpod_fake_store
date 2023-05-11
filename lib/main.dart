import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/screen/auth/login_screen.dart';
import 'package:riverpod_fake_store_api/screen/product/all_products_screen.dart';

import 'screen/auth/provider/user_auth_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ref.watch(isRegistered)
          ? const AllProductScreen()
          : const LoginScreen(),
    );
  }
}

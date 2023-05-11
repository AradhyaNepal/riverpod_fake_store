import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpecificProductScreen extends ConsumerStatefulWidget {
  final int id;

  const SpecificProductScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SpecificProductScreen> createState() => _SpecificProductScreenState();
}

class _SpecificProductScreenState extends ConsumerState<SpecificProductScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

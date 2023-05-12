import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  final String? importantValue="";
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String? value;
  @override
  void initState() {
   value=widget.importantValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Text(value??"");
  }
}

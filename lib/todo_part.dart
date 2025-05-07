import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  
  @override
  final _key = GlobalKey<FormState>();
  final _controller = TextEditingController();
  
  Widget build(BuildContext context) {
    return Scaffold(
      
    );


  }
}
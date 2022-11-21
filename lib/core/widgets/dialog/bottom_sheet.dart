import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  final Widget child;
  const CustomPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

extension CustomPageSheet on CustomPage {
  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context) => this);
  }
}
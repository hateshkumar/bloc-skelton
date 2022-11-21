import 'package:flutter/material.dart';

import '../navigator/navigator_helper.dart';
import 'buttons/reliable_buttons.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReliableButton.primaryFilled(
          child: const Text('NO FOUND GO BACK'),
          onPressed: () {
            NavigatorHelper().pop();
          },
        ),
      ),
    );
  }
}

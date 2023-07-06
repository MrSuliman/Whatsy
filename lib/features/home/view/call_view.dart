import 'package:flutter/material.dart';
import 'package:whatsy/features/home/widget/floating_btn.dart';

class CallView extends StatelessWidget {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Call View'),
      ),
      floatingActionButton: FloatingBtn(
        onPressed: () {},
        icon: Icons.call,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:whatsy/features/home/widget/floating_btn.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Status View'),
      ),
      floatingActionButton: FloatingBtn(
        icon: Icons.edit,
      ),
    );
  }
}

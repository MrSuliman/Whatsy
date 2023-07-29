import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/constant/colors.dart';

void askPermission(
  context, {
  required void Function()? allowBtn,
  required String text,
  required IconData icon,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              decoration: const BoxDecoration(
                color: Colory.greenLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Icon(
                icon,
                size: 60,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Not now'),
          ),
          TextButton(
            onPressed: allowBtn,
            child: const Text('Continue'),
          ),
        ],
      );
    },
  );
}

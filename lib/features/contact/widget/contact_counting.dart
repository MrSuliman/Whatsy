import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/features/contact/cubit/contact_cubit.dart';

class ContactCounting extends StatelessWidget {
  const ContactCounting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        if (state is ContactSuccess) {
          return Text(
            '${state.contacts[0].length} Contact${state.contacts[0].length == 1 ? '' : 's'}',
            style: Theme.of(context).textTheme.labelLarge,
          );
        } else if (state is ContactLoading) {
          return Text(
            'counting ...',
            style: Theme.of(context).textTheme.labelLarge,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:ev_charge/widgets/ev_form.dart';

class AddEv extends StatelessWidget {
  const AddEv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add EV'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: const EVForm(),
    );
  }
}

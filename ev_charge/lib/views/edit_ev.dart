import 'package:flutter/material.dart';

import 'package:ev_charge/widgets/ev_form.dart';

class EVEdit extends StatelessWidget {
  const EVEdit({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit EV'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: EVForm(id: id),
    );
  }
}

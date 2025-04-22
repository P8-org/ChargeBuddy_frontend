import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ev_charge/widgets/ev_form.dart';
import '../widgets/bottom_navbar.dart';

class EVEdit extends StatelessWidget {
  const EVEdit({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit EV'),
        backgroundColor: Colors.blue,
      ),
      body: EVForm(id: id),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:ev_charge/widgets/ev_form.dart';

class AddEv extends StatelessWidget {
  const AddEv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add EV'),
        backgroundColor: Colors.blue,
      ),
      body: const EVForm(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

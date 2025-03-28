import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';


class EVForm extends StatefulWidget {
  const EVForm({super.key});

  @override
  EVFormState createState() {
    return EVFormState();
  }
}
class EVFormState extends State<EVForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<EVFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController manufacturerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Manufacturer',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: manufacturerController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added: "${manufacturerController.text}"')),
                  );
                  context.pop();
                }
                
              },
              child: const Text('Submit'),
            ),
          ),

          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
class AddEv extends StatelessWidget {
  const AddEv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add EV'),
        backgroundColor: Colors.blue,
      ),
      body: Column (
        children: [
          Center(
            child: ElevatedButton(
              onPressed:  () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
          ),
          Center(
            child: const EVForm()
          ),
        ]
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

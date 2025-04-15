import 'package:ev_charge/viewmodels/home_page_vm.dart';
import 'package:ev_charge/widgets/ev_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:ev_charge/widgets/charging_constraints_widget.dart';
import 'package:ev_charge/widgets/electricity_prices_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageVM vm = HomePageVM();

  @override
  void initState() {
    super.initState();
    vm.getEvs();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    vm.getEvs(); // to refresh data when navigating back to homepage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: ListenableBuilder(
          listenable: vm,
          builder: (context, child) {
            if (vm.isError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(vm.errorMessage),
                  Padding(padding: EdgeInsets.all(16)),
                  ElevatedButton(
                    onPressed: vm.getEvs,
                    child: Text("Try again"),
                  ),
                ],
              );
            }
            if (vm.evs.isEmpty && !vm.loading && !vm.isError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No cars in db"),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: vm.getEvs,
                      child: Text("Refresh"),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => context.go("/add_car"), 
                      label: Text("Add car"),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => await vm.getEvs(),
              child: ListView.builder(
                itemCount: vm.evs.length,
                itemBuilder: (context, index) {
                  return EvCard(ev: vm.evs[index]);
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

import 'package:flutter/material.dart';


class Rider extends StatefulWidget {
  const Rider({super.key});

  @override
  State<Rider> createState() => _RiderState();
}

class _RiderState extends State<Rider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rider"),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Bagian rider'),
      ),
    );
  }
}

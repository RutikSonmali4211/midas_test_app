import 'package:flutter/material.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var height;
  var width;

  bool istoggle = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SmallAppbar(heading: "Notifications")
        ],
      ),
    );
  }
}

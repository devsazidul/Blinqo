import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(ProfileScreen());
          },
          child: Text("Profile Setup page"),
        ),
      ),
    );
  }
}

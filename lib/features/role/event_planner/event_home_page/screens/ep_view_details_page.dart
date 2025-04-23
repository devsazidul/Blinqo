import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpViewDetailsPage extends StatelessWidget {
  const EpViewDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text("Provider Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
                  provider['image'] != null
                      ? Image.asset(provider['image'], width: 100, height: 100)
                      : Icon(Icons.image, size: 100),
            ),
            const SizedBox(height: 20),
            Text(
              "Name: ${provider['name'] ?? 'Unknown'}",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text("Location: ${provider['location'] ?? 'Not available'}"),
            const SizedBox(height: 8),
            Text("Price: ${provider['price'] ?? 'N/A'}"),
            const SizedBox(height: 8),
            Text("Rating: ${provider['rating'] ?? 'No rating'}"),
            const SizedBox(height: 8),
            Text("Verified: ${provider['verified'] == true ? "Yes" : "No"}"),
          ],
        ),
      ),
    );
  }
}

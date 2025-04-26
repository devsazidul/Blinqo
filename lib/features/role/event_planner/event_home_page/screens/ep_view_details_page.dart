import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpViewDetailsPage extends StatelessWidget {
  const EpViewDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImagePath.epprofilebackground),

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 90,
                    left: MediaQuery.of(context).size.width / 2 - 60,

                    child: CircleAvatar(
                      radius: 56,

                      child:
                          provider['image'] != null
                              ? Image.asset(
                                provider['image'],
                                width: 100,
                                height: 100,
                              )
                              : Icon(Icons.image, size: 100),
                    ),
                  ),
                ],
              ),
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

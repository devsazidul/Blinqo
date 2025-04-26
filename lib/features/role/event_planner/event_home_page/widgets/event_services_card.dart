import 'package:flutter/material.dart';

class EventServiceCard extends StatelessWidget {
  final Service service;

  const EventServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Container(color: Colors.amber));
    // return GestureDetector(
    //   onTap: () {
    //     Get.to(() => EpEventServiceDetails(service: service));
    //   },
    //   child: Container(
    //     color: Colors.amber,
    //     child: Column(
    //       children: [
    //         Container(
    //           // color: Colors.amber,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(8),
    //             child: Image.asset(
    //               service.imagePath,
    //               // width: 116,
    //               // height: 85,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         Text(
    //           service.label,
    //           style: getTextStyle(
    //             color: AppColors.textColor,
    //             fontSize: 14,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

// Model for a service
class Service {
  final String imagePath;
  final String label;

  Service({required this.imagePath, required this.label});
}

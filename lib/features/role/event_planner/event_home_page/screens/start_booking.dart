import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timeline_tile_plus/timeline_tile_plus.dart';

// class StartBooking extends StatelessWidget {
//   const StartBooking({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get screen width and height for responsive design
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Color(0xffF4F4F4),
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         centerTitle: true,
//         title: Text(
//           'Start Booking',
//           style: TextStyle(
//             fontSize:
//                 screenWidth * 0.05, // Adjust font size based on screen width
//             fontWeight: FontWeight.w600,
//             color: AppColors.buttonColor2, // Ensure AppColors is defined
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.05,
//         ), // Horizontal padding based on screen width
//         child: Column(
//           children: [
//             StartBookingShearshBar(
//               screenHeight: screenHeight,
//               screenWidth: screenWidth,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class StartBooking extends StatelessWidget {
  const StartBooking({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(BookingController());

    // Example data for Timeline
    List<String> examples = ['Step 1', 'Step 2', 'Step 3'];

    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Start Booking',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Container(height: screenHeight * 0.03),
            StartBookingShearshBar(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenHeight * 0.03),

            // Timeline Tile
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: examples.length,
              itemBuilder: (context, index) {
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  enableAfterLineAnimation: true,
                  enableBeforeLineAnimation: true,
                  tweenBeginColor: Colors.blue,
                  tweenEndColor: Colors.red,
                  isFirst: index == 0,
                  isLast: index == examples.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    height: 40,
                    indicator: _IndicatorExample(number: '${index + 1}'),
                    drawGap: true,
                  ),
                  beforeLineStyle: LineStyle(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  endChild: GestureDetector(
                    child: _RowExample(example: examples[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<ShowcaseTimeline>(
                          builder:
                              (_) => ShowcaseTimeline(example: examples[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}

// Assuming you have these widgets implemented

class _IndicatorExample extends StatelessWidget {
  final String number;
  const _IndicatorExample({required this.number});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.blue,
      child: Text(number, style: TextStyle(color: Colors.white)),
    );
  }
}

class _RowExample extends StatelessWidget {
  final String example;
  const _RowExample({required this.example});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.access_alarm, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            example,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class StartBookingShearshBar extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  const StartBookingShearshBar({
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8),
          Expanded(
            child: TextField(decoration: InputDecoration(hintText: 'Search')),
          ),
        ],
      ),
    );
  }
}

class ShowcaseTimeline extends StatelessWidget {
  final String example;
  const ShowcaseTimeline({required this.example});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Showcase: $example')),
      body: Center(child: Text('Details for $example')),
    );
  }
}

class BookingController extends GetxController {
  // Your controller code here
}


// class StartBooking extends StatelessWidget {
//   const StartBooking({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get screen width and height for responsive design
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     final controller = Get.put(BookingController());

//     return Scaffold(
//       backgroundColor: Color(0xffF4F4F4),
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         centerTitle: true,
//         title: Text(
//           'Start Booking',
//           style: TextStyle(
//             fontSize: screenWidth * 0.05,
//             fontWeight: FontWeight.w600,
//             color: Colors.blue,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//         child: Column(
//           children: [
//             Container(height: screenHeight * 0.03),
//             StartBookingShearshBar(
//               screenHeight: screenHeight,
//               screenWidth: screenWidth,
//             ),
//             SizedBox(height: screenHeight * 0.03),

//            TimelineTile(
//     alignment: TimelineAlign.manual,
//     lineXY: 0.1,
//     enableAfterLineAnimation: true,
//     enableBeforeLineAnimation: true,
//     tweenBeginColor: Colors.blue,
//     tweenEndColor: Colors.red,
    
//     isFirst: index == 0,
//     isLast: index == examples.length - 1,
//     indicatorStyle: IndicatorStyle(
//         width: 40,
//         height: 40,
//         indicator: _IndicatorExample(number: '${index + 1}'),
//         drawGap: true,
//     ),
//     beforeLineStyle: LineStyle(
//         color: Colors.white.withOpacity(0.2),
//     ),
//     endChild: GestureDetector(
//         child: _RowExample(example: example),
//         onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute<ShowcaseTimeline>(
//             builder: (_) =>
//                 ShowcaseTimeline(example: example),
//             ),
//         );
//         },
//     ),
//     );
            
//             SizedBox(height: screenHeight * 0.03),
//           ],
//         ),
//       ),
//     );
//   }
// }


  // }

  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // import 'package:timelines_plus/timelines_plus.dart';

  // import 'package:flutter/material.dart';
  // import 'package:get/get.dart';
  // import 'package:timelines_plus/timelines_plus.dart';

  // class StartBooking extends StatelessWidget {
  //   const StartBooking({super.key});

  //   @override
  //   Widget build(BuildContext context) {
  //     // Get screen width and height for responsive design
  //     double screenWidth = MediaQuery.of(context).size.width;
  //     double screenHeight = MediaQuery.of(context).size.height;
  //     final controller = Get.put(BookingController());

  //     return Scaffold(
  //       backgroundColor: Color(0xffF4F4F4),
  //       appBar: AppBar(
  //         forceMaterialTransparency: true,
  //         centerTitle: true,
  //         title: Text(
  //           'Start Booking',
  //           style: TextStyle(
  //             fontSize: screenWidth * 0.05,
  //             fontWeight: FontWeight.w600,
  //             color: Colors.blue,
  //           ),
  //         ),
  //       ),
  //       body: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
  //         child: Column(
  //           children: [
  //             SizedBox(height: 40),
  //             Text(
  //               'Booking Timeline',
  //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //             ),
  //             SizedBox(height: 20),

  //             // Use the TimelinesPlus widget to create the timeline
  //          Timeline.tileBuilder(
  //                 theme: TimelineThemeData(
  //                   nodePosition: 0,
  //                   indicatorTheme: IndicatorThemeData(size: 30),
  //                 ),
  //           builder: TimelineTileBuilder(itemCount: 2, indicatorBuilder: (context, index) {
  //                   bool isCurrentStep = controller.currentStep.value >= index;
  //                   return TimelineNode(
  //                     indicator: CircleAvatar(
  //                       radius: 20,
  //                       backgroundColor:
  //                           isCurrentStep ? Colors.blue : Colors.grey[300],
  //                       backgroundImage: AssetImage(_getImageForStep(index)),
  //                       child: isCurrentStep
  //                           ? Icon(
  //                               _getIconForStep(index),
  //                               color: Colors.white,
  //                             )
  //                           : null,
  //                     ),
  //                   );
  //                 },),

  //             }),

  //             SizedBox(height: 40),

  //             // Example Buttons to simulate step change
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 ElevatedButton(
  //                   onPressed: controller.prevStep,
  //                   child: Text('Previous'),
  //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: controller.nextStep,
  //                   child: Text('Next'),
  //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }

  //   // Get the step name based on the index
  //   String _getStepName(int index) {
  //     switch (index) {
  //       case 0:
  //         return 'Request';
  //       case 1:
  //         return 'Pending';
  //       case 2:
  //         return 'Confirmed';
  //       case 3:
  //         return 'Completed';
  //       default:
  //         return '';
  //     }
  //   }

  //   // Get the image for each step (replace these paths with actual images)
  //   String _getImageForStep(int index) {
  //     switch (index) {
  //       case 0:
  //         return 'assets/images/request.png'; // Add an image for 'Request'
  //       case 1:
  //         return 'assets/images/pending.png'; // Add an image for 'Pending'
  //       case 2:
  //         return 'assets/images/confirmed.png'; // Add an image for 'Confirmed'
  //       case 3:
  //         return 'assets/images/completed.png'; // Add an image for 'Completed'
  //       default:
  //         return '';
  //     }
  //   }

  //   // Get the icon for each step
  //   IconData _getIconForStep(int index) {
  //     switch (index) {
  //       case 0:
  //         return Icons.check;
  //       case 1:
  //         return Icons.access_time;
  //       case 2:
  //         return Icons.check_circle;
  //       case 3:
  //         return Icons.done;
  //       default:
  //         return Icons.check;
  //     }
  //   }
  // }

  // class BookingController extends GetxController {
  //   var currentStep = 0.obs;

  //   // Function to change to the next step
  //   void nextStep() {
  //     if (currentStep.value < 3) {
  //       currentStep.value++;
  //     }
  //   }

  //   // Function to change to the previous step
  //   void prevStep() {
  //     if (currentStep.value > 0) {
  //       currentStep.value--;
  //     }
  //   }
  // }


import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../event_home_page/widgets/enent_type_dopdown_button.dart';
import '../event_home_page/widgets/stark_booking_set_start_time_and_endtime.dart';
import '../event_home_page/widgets/start-booking_decoration_image.dart';
import '../event_home_page/widgets/start_booking_date.dart';
import '../event_home_page/widgets/start_booking_number_of_guests.dart';
import '../event_home_page/widgets/start_booking_text_or_button.dart';
import '../event_home_page/widgets/start_booking_textfrom.dart';
import 'controller/booking_controller.dart';
import 'wigate/start_booking_shearh_bar.dart';

class StartBooking extends StatelessWidget {
  const StartBooking({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final bookingController = Get.put(BookingController());

    return Scaffold(
      backgroundColor: AppColors.buttonBuckdownColor2,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Start Booking',
          style: getTextStyle(
            fontSize:
                screenWidth * 0.05, // Adjust font size based on screen width
            fontWeight: FontWeight.w600,
            color: AppColors.buttonColor2, // Ensure AppColors is defined
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ), // Horizontal padding based on screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StartBookingShearshBar(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),

              StartBookingTextFrom(
                screenHeight: screenHeight,
                bookingController: bookingController,
              ),

              SizedBox(height: screenHeight * 0.02),
              StartBookingDate(bookingController: bookingController),

              SizedBox(height: screenHeight * 0.02),
              StarkBookingSetStartTimeOrEndTime(
                bookingController: bookingController,
              ),
              SizedBox(height: screenHeight * 0.02),
              StartBookingNumberOfGuests(
                screenHeight: screenHeight,
                bookingController: bookingController,
              ),
              SizedBox(height: screenHeight * 0.02),

              EventTypeDopdownButton(
                bookingController: bookingController,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              StartBookingDecorationImage(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              StartBookingTextOrButton(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Additional Services',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.buttonColor2,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  ServiceSelectionWidget(),

                  SizedBox(height: screenHeight * 0.02),

                  SizedBox(height: screenHeight * 0.07),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ServiceSelectionWidget extends StatefulWidget {
//   @override
//   _ServiceSelectionWidgetState createState() => _ServiceSelectionWidgetState();
// }

// class _ServiceSelectionWidgetState extends State<ServiceSelectionWidget> {
//   // List of available services to select from
//   List<String> availableServices = [
//     'Photography',
//     'Videography',
//     'Decoration',
//     'Music',
//     'Catering',
//   ];

//   // List of selected services
//   List<String> selectedServices = ['Photography', 'Videography'];

//   // Function to handle removal of a service
//   void _removeService(String service) {
//     setState(() {
//       selectedServices.remove(service);
//     });
//   }

//   // Function to handle adding a new service
//   void _addService(String service) {
//     setState(() {
//       if (!selectedServices.contains(service)) {
//         selectedServices.add(service);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Display selected services as custom tags with remove button
//         Wrap(
//           spacing: 8.0,
//           children:
//               selectedServices
//                   .map(
//                     (service) => Container(
//                       margin: EdgeInsets.only(bottom: 8.0),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 8.0,
//                         vertical: 4.0,
//                       ),
//                       width: 121.0,
//                       height: 40.0,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300], // Background color of the tag
//                         border: Border.all(
//                           color:
//                               Colors
//                                   .blue, // Border color (you can customize this)
//                         ),
//                         borderRadius: BorderRadius.circular(40.0),
//                       ),
//                       child: Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Text(
//                               service,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.blue, // Text color
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap:
//                                   () => _removeService(
//                                     service,
//                                   ), // Remove service on tap
//                               child: Image.asset(
//                                 'assets/icons/cancel.png', // Path to your remove icon
//                                 width: 20,
//                                 height: 20,
//                                 color: Colors.blue, // Icon color
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//         ),
//         SizedBox(height: 10),

//         // Custom container for "Add Service" button
//         Align(
//           alignment: Alignment.center,
//           child: GestureDetector(
//             onTap: () {
//               print("Add Service button tapped");
//               // Add a sample service (this could be modified to open a dialog, for example)
//               // _addService('Music');
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: Text('Add Service'),

//                     // content: DropdownButton<String>(
//                     //   items:
//                     //       availableServices
//                     //           .map(
//                     //             (service) => DropdownMenuItem<String>(
//                     //               value: service,
//                     //               child: Text(service),
//                     //             ),
//                     //           )
//                     //           .toList(),
//                     //   onChanged: (value) {
//                     //     if (value != null) {
//                     //       _addService(value);
//                     //     }
//                     //     Navigator.of(context).pop();
//                     //   },
//                     //   hint: Text('Select a service'),
//                     // ),

//                     content: Container(
//                       width: 300,
//                       height: 200,
//                       child: ListView.builder(
//                         itemCount: availableServices.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(availableServices[index]),
//                             onTap: () {
//                               _addService(availableServices[index]);
//                               Navigator.of(context).pop();
//                             },
//                           );
//                         },
//                       ),
//                     ),

//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Cancel'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Container(
//               width: 160.0,
//               height: 45.0,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.white, // Background color of the button
//                 border: Border.all(color: Colors.blue), // Border color
//                 borderRadius: BorderRadius.circular(40.0), // Rounded corners
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     blurRadius: 5,
//                     spreadRadius: 1,
//                   ),
//                 ], // Optional shadow
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Add Service",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.blue, // Text color
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Icon(
//                     Icons.add, // Add icon
//                     size: 20,
//                     color: Colors.blue, // Icon color
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ServiceSelectionWidget extends StatefulWidget {
//   @override
//   _ServiceSelectionWidgetState createState() => _ServiceSelectionWidgetState();
// }

// class _ServiceSelectionWidgetState extends State<ServiceSelectionWidget> {
//   // List of available services to select from
//   List<String> availableServices = [
//     'Photography',
//     'Videography',
//     'DJ Brand',
//     'Catering',
//   ];

//   // List of images corresponding to the services
//   List<String> serviceImages = [
//     'assets/images/Group.png', // Image for Photography
//     'assets/images/videography.png', // Image for Videography
//     'assets/images/decoration.png', // Image for Decoration
//     'assets/images/catering.png', // Image for Music
//   ];

//   // List of selected services
//   List<String> selectedServices = [];

//   // The service to be selected from the dropdown
//   String? _selectedService;

//   // Function to handle removal of a service
//   void _removeService(String service) {
//     setState(() {
//       selectedServices.remove(service);
//     });
//   }

//   // Function to handle adding a new service
//   void _addService(String service) {
//     setState(() {
//       if (!selectedServices.contains(service)) {
//         selectedServices.add(service);
//       }
//     });
//   }

//   // Show the dialog with the selected service
//   void _showSelectedServiceDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           icon: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Image.asset("assets/icons/cancel2.png", width: 24, height: 24),
//             ],
//           ),
//           backgroundColor: Colors.white,
//           title: Text("Select a Service"),
//           content: SizedBox(
//             width: 350,
//             height: 250,
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Number of items per row
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemCount: availableServices.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     _addService(availableServices[index]);
//                     Navigator.of(context).pop();
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.alrtdailogeBackdownColor,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           serviceImages[index], // Display the image for the service
//                           width: 25,
//                           height: 25,
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           availableServices[index],
//                           style: getTextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.buttonColor2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Display selected services as custom tags with remove button
//         Wrap(
//           spacing: 8.0,
//           children:
//               selectedServices
//                   .map(
//                     (service) => Container(
//                       margin: EdgeInsets.only(bottom: 8.0),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 8.0,
//                         vertical: 4.0,
//                       ),
//                       width: 121.0,
//                       height: 40.0,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300], // Background color of the tag
//                         border: Border.all(color: AppColors.buttonColor2),
//                         borderRadius: BorderRadius.circular(40.0),
//                       ),
//                       child: Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Text(
//                               service,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.buttonColor2,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => _removeService(service),
//                               child:
//
// Image.asset(
//                                 IconPath
//                                     .cancelIcon2, // Path to your remove icon
//                                 width: 20,
//                                 height: 20,
//                                 color: AppColors.buttonColor2,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//         ),
//         SizedBox(height: 10),

//         // Custom container for "Add Service" button
//         Align(
//           alignment: Alignment.center,
//           child: GestureDetector(
//             onTap:
//                 _showSelectedServiceDialog, // Show dialog when button is tapped
//             child: Container(
//               width: 160.0,
//               height: 45.0,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.white, // Background color of the button
//                 border: Border.all(
//                   color: AppColors.buttonColor2,
//                 ), // Border color
//                 borderRadius: BorderRadius.circular(40.0), // Rounded corners
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Add Service",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.buttonColor2,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Image.asset(
//                     "assets/icons/add_icon.png",
//                     width: 20,
//                     height: 20,
//                     color: AppColors.buttonColor2,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ServiceSelectionWidget extends StatelessWidget {
  // Initialize the ServiceController
  final ServiceController controller = Get.put(ServiceController());

  ServiceSelectionWidget({super.key});

  // Show the dialog with the selected service
  void _showSelectedServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/icons/cancel2.png", width: 24, height: 24),
            ],
          ),
          backgroundColor: Colors.white,
          title: Text("Select a Service"),
          content: SizedBox(
            width: 350,
            height: 250,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: controller.availableServices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.addService(controller.availableServices[index]);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Modify with your custom color
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          controller
                              .serviceImages[index], // Display the image for the service
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(height: 8),
                        Text(
                          controller.availableServices[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue, // Use your color
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display selected services as custom tags with remove button
        Obx(() {
          return Wrap(
            spacing: 8.0,
            children:
                controller.selectedServices
                    .map(
                      (service) => Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        width: 121.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color:
                              Colors.grey[300], // Background color of the tag
                          border: Border.all(
                            color: Colors.blue,
                          ), // Border color
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                service,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller.removeService(service),
                                child: Image.asset(
                                  IconPath
                                      .cancelIcon2, // Path to your remove icon
                                  width: 20,
                                  height: 20,
                                  color: AppColors.buttonColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          );
        }),
        SizedBox(height: 10),

        // Custom container for "Add Service" button
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap:
                () => _showSelectedServiceDialog(
                  context,
                ), // Show dialog when button is tapped
            child: Container(
              width: 160.0,
              height: 45.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the button
                border: Border.all(color: Colors.blue), // Border color
                borderRadius: BorderRadius.circular(40.0), // Rounded corners
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Service",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  Image.asset(
                    "assets/icons/add_icon.png", // Modify path as needed
                    width: 20,
                    height: 20,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ServiceController extends GetxController {
  // List of available services to select from
  List<String> availableServices = [
    'Photography',
    'Videography',
    'DJ Brand',
    'Catering',
  ];

  // List of images corresponding to the services
  List<String> serviceImages = [
    'assets/images/Group.png', // Image for Photography
    'assets/images/videography.png', // Image for Videography
    'assets/images/decoration.png', // Image for Decoration
    'assets/images/catering.png', // Image for Music
  ];

  // Observable list for selected services
  var selectedServices = <String>[].obs;

  // Function to add a service to the selected services list
  void addService(String service) {
    if (!selectedServices.contains(service)) {
      selectedServices.add(service);
    }
  }

  // Function to remove a service from the selected services list
  void removeService(String service) {
    selectedServices.remove(service);
  }
}

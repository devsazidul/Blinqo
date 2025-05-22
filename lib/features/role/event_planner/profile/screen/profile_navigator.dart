// import 'package:blinqo/features/role/event_planner/main_layout/screen/ep_main_layout_screen.dart';
// import 'package:blinqo/features/role/event_planner/profile/screen/edit_profile_screen.dart';
// import 'package:blinqo/features/role/event_planner/profile/screen/pick_color_screen.dart';
// import 'package:blinqo/features/role/event_planner/profile/screen/profile_screen.dart';
// import 'package:blinqo/routes/app_routes.dart';
// import 'package:flutter/material.dart';

// class ProfileNavigator extends StatelessWidget {
//   const ProfileNavigator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => EventPlannerMainLayoutScreen(),
//           ),
//           (result) => false,
//         );
//       },
//       child: Navigator(
//         onGenerateRoute: (settings) {
//           Widget screen;
//           if (settings.name == AppRoute.getEditProfileScreen()) {
//             screen = EditProfilePage();
//           } else if (settings.name == AppRoute.getPickColorScreen()) {
//             screen = PickColorScreen();
//           } else {
//             screen = MainProfileScreen();
//           }

//           return MaterialPageRoute(builder: (context) => screen);
//         },
//       ),
//     );
//   }
// }

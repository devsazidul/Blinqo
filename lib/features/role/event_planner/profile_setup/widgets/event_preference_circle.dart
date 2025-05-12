// import 'package:blinqo/features/role/event_planner/profile_setup/model/event_preference_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class EventPreferenceCircleAvatar extends StatelessWidget {
//   final EEventPreferenceModel eventPreference;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const EventPreferenceCircleAvatar({
//     super.key,
//     required this.eventPreference,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: SizedBox(
//         width: 110,
//         height: 132,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Main Circle Avatar
//                 Container(
//                   width: 96,
//                   height: 96,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: isSelected
//                         ? Border.all(color: Colors.green, width: 2)
//                         : null,
//                   ),
//                   child: ClipOval(
//                     child: CachedNetworkImage(
//                       imageUrl: eventPreference.avatar?.path ?? '',
//                       width: 96,
//                       height: 96,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => 
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => 
//                           Icon(Icons.error),
//                     ),
//                   ),
//                 ),
//                 // Selection Indicator - Only shows when isSelected is true
//                 if (isSelected)
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               eventPreference.name ?? 'Unknown',
//               style: Theme.of(context).textTheme.bodyMedium,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:blinqo/features/role/event_planner/profile_setup/controller/profile_setup_controller.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/model/event_preference_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventPreferenceCircleAvatar extends StatelessWidget {
  final EEventPreferenceModel eventPreference;
  final bool isSelected;
  final VoidCallback onTap;

  const EventPreferenceCircleAvatar({
    super.key,
    required this.eventPreference,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 110,
        height: 132,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Obx(() {
                  // This ensures the selection state updates immediately
                  final controller = Get.find<ProfileSetupController>();
                  final isSelected = controller.selectedEvents.contains(eventPreference.id);
                  
                  return Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.green, width: 2)
                          : null,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: eventPreference.avatar?.path ?? '',
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Icon(Icons.error),
                      ),
                    ),
                  );
                }),
                Obx(() {
                  final controller = Get.find<ProfileSetupController>();
                  final isSelected = controller.selectedEvents.contains(eventPreference.id);
                  
                  return isSelected
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                }),
              ],
            ),
            SizedBox(height: 8),
            Text(
              eventPreference.name ?? 'Unknown',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
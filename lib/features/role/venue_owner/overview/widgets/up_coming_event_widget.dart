import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpComingBooking extends StatelessWidget {
  UpComingBooking({super.key});

  final OverviewController controller = Get.find<OverviewController>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final bool isDarkMode =
        Get.find<VenueOwnerProfileController>().isDarkMode.value;

    return Obx(() {
      final upcomingEvents =
          controller.venueOverView.value?.data?.upcomingEvents ?? [];
      return SizedBox(
        height:
            screenHeight < 620 ? screenHeight * 0.550 : screenHeight * 0.420,
        child:
            upcomingEvents.isEmpty
                ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 250,
                        width: 232,
                        child: Image.asset(ImagePath.overviewbox),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'It looks like no events have been\n       scheduled yet.',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode
                                  ? const Color(0xffEBEBEB)
                                  : const Color(0xff333333),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      upcomingEvents.length > 3 ? 3 : upcomingEvents.length,
                  // Limit to 3
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final event = upcomingEvents[index];
                    final dateFormat = DateFormat('MMM dd, yyyy');
                    final timeFormat = DateFormat('h:mm a');
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? const Color(0xff32383D)
                                  : const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color:
                                isDarkMode
                                    ? const Color(0xff32383D)
                                    : const Color(0xffEBEBEB),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xff000000,
                              ).withValues(alpha: 0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03,
                            vertical: MediaQuery.of(context).size.width * 0.025,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        event.venue?.venueImage?.path != null
                                            ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    event.venue?.venueImage?.path ?? '',

                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Image.asset(
                                                      ImagePath.overviewbox,
                                                    ),
                                              ),
                                            )
                                            : Image.asset(
                                              ImagePath.overviewbox,
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.eventName ?? 'Unnamed Event',
                                        style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              isDarkMode
                                                  ? const Color(0xffEBEBEB)
                                                  : const Color(0xff333333),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        event.venue?.name ?? 'Unknown Venue',
                                        style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff999999),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Color(0x19003366),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(23),
                                      ),
                                    ),
                                    child: Image.asset(
                                      IconPath.arrowUpper,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size:
                                        MediaQuery.of(context).size.width *
                                        0.035,
                                    color: const Color(0xff8A8A8A),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    event.selectedDate != null
                                        ? dateFormat.format(event.selectedDate!)
                                        : 'N/A',
                                    style: getTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color:
                                          isDarkMode
                                              ? const Color(0xff8A8A8A)
                                              : const Color(0xff767676),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    event.startTime != null
                                        ? timeFormat.format(event.startTime!)
                                        : 'N/A',
                                    style: getTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color:
                                          isDarkMode
                                              ? const Color(0xff8A8A8A)
                                              : const Color(0xff767676),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 22,
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.17,
                                    decoration: BoxDecoration(
                                      color:
                                          event.bookingStatus == "Confirmed"
                                              ? const Color(
                                                0xff37D459,
                                              ).withValues(alpha: 0.2)
                                              : const Color(
                                                0xffD4AF37,
                                              ).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        event.bookingStatus ?? 'Pending',
                                        style: getTextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              event.bookingStatus == "Confirmed"
                                                  ? const Color(0xff37D441)
                                                  : const Color(0xffD4AF37),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      );
    });
  }
}

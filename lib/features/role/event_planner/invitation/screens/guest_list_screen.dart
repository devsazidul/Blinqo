import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/invitation/widgets/custom_appbar_widget.dart';
import 'package:blinqo/features/role/event_planner/invitation/widgets/guest_list_count.dart';
import 'package:flutter/material.dart';

class GuestListScreen extends StatelessWidget {
  const GuestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: CustomAppBarWidget(
        title: 'Guest List',
        actions: [
          IconButton(
            icon: Image.asset(IconPath.filterIcon, width: 16, height: 16),
            onPressed: () {},
          ),
          SizedBox(width: 8),
        ],
      ),
      body: ColoredBox(
        color: Color(0xfff4f4f4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffFBF7EB),
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GuestListCount(
                        title: "Invited ",
                        count: "200",
                        color: Color(0xff333333),
                      ),
                      GuestListCount(
                        title: "Accepted ",
                        count: "100",
                        color: Color(0xff23AE01),
                      ),
                      GuestListCount(
                        title: "Declined ",
                        count: "70",
                        color: Color(0xffF00000),
                      ),
                      GuestListCount(
                        title: "Pending ",
                        count: "30",
                        color: Color(0xffD4AF37),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 15,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Color(0xffD9D9D9),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'John Doe',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff000003),
                                ),
                              ),
                              Text(
                                'Amtoli, Dhaka',
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8D8D8D),
                                ),
                              ),
                            ],
                          ),

                          Spacer(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(""),
                              Text(
                                index % 3 == 0
                                    ? 'Pending'
                                    : index % 3 == 1
                                    ? 'Declined'
                                    : 'Accepted',
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      index % 3 == 0
                                          ? Color(0xff23AE01)
                                          : index % 3 == 1
                                          ? Color(0xffD4AF37)
                                          : Color(0xffF00000),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    );
                    // return ListTile(
                    //   tileColor: const Color.fromARGB(255, 168, 21, 21),
                    //   leading: CircleAvatar(
                    //     backgroundColor: Color(0xffD9D9D9),
                    //     child: Icon(Icons.person, color: Colors.white),
                    //   ),
                    //   title: Text(
                    //     'John Doe',
                    //     style: getTextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //       color: Color(0xff333333),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/image_path.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.reviews,
  });

  final List<Map<String, String>> reviews;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child:
      reviews.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 232,
              width: 232,
              child: Image.asset(ImagePath.overviewbox),
            ),
            SizedBox(height: 10),
            Text(
              'It looks like no events have been\n       scheduled yet.',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff333333),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85, // সরাসরি শতাংশে নির্ধারণ
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: Color(0xffEBEBEB),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withValues(alpha:  .1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
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
                          height: MediaQuery.of(context).size.height * 0.05, // Height slightly reduced
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            reviews[index]["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.03), // Reduced spacing
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviews[index]["title"]!,
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff333333),
                              ),
                            ),
                            SizedBox(height: 4), // Reduced from 5 to 4
                            Text(
                              reviews[index]["subtitle"]!,
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff999999),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025, // Slightly reduced
                          child: Image.asset(
                            ImagePath.pending,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6), // Reduced from 10
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: MediaQuery.of(context).size.width * 0.035, // Reduced size
                          color: Color(0xff8A8A8A),
                        ),
                        SizedBox(width: 6), // Reduced width spacing
                        Text(
                          reviews[index]["date"]!,
                          style: getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 12), // Reduced from 16
                        Text(
                          reviews[index]["time"]!,
                          style: getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 22, // Reduced from 25
                          width: MediaQuery.of(context).size.width * 0.17, // Slightly reduced
                          decoration: BoxDecoration(
                            color: reviews[index]["status"] == "Confirmed"
                                ? Color(0xff37D459).withValues(alpha: .20)
                                : Color(0xffD4AF37).withValues(alpha: .20),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              reviews[index]["status"]!,
                              style: getTextStyle(
                                fontSize: 11, // Reduced from 12
                                fontWeight: FontWeight.w400,
                                color: reviews[index]["status"] == "Confirmed"
                                    ? Color(0xff37D441)
                                    : Color(0xffD4AF37),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )

            ),
          );

        },
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class ReviewCard extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String desc;
  final int rating; // assuming out of 5

  const ReviewCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.desc,
    this.rating = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row: Avatar + Title + Stars + Time
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff333333),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        rating,
                            (index) => const Icon(
                          Icons.star,
                          color: Color(0xffF0C020),
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffC0C0C0),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// Description
          Text(
            desc,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff5C5C5C),
            ),
          ),
        ],
      ),
    );
  }
}

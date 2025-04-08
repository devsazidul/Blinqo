import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class EHomeScreen extends StatelessWidget {
  const EHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 32),
                _buildSearchBar(searchTEController),
                SizedBox(height: 20),
                _buildEventCard(),
                SizedBox(height: 40),
                _buildFeaturedVenuesTitle(),
                SizedBox(height: 8),
                _buildVenueList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedVenuesTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Venues',
          style: getTextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Explore All',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
              ),
            ),
            Icon(Icons.trending_flat, size: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(ImagePath.profile),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dianne Russell',
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Color(0xFFA1A1A1),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          '45th Street, Los Angeles, USA',
                          // overflow: TextOverflow.,
                          style: getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xFFA1A1A1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.all(10),
          ),
          onPressed: () {},
          child: Text(
            'Go Pro',
            style: getTextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 8),
        Icon(Icons.notifications, size: 24, color: AppColors.iconColor),
      ],
    );
  }

  Widget _buildSearchBar(TextEditingController searchTEController) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchTEController,
            decoration: InputDecoration(
              hintText: 'Search venues & services...',
              hintStyle: getTextStyle(color: Colors.grey, fontSize: 14),
              filled: true,
              suffixIcon: Icon(Icons.mic_none),
              fillColor: AppColors.primary,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.iconBackground,
            ),
            child: Icon(Icons.tune, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.buttonColor2,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRect(
                child: Image.asset(
                  ImagePath.eventCard,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 80,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Spring Fair',
                    style: getTextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lavender Fields Venue',
                    style: getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.smallText,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 16,
                        color: AppColors.smallText,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '15 March,2025',
                        style: getTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.smallText,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.smallText,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'New York',
                        style: getTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.smallText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 18),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: Color(0xFFB0C0D0),
                  ),
                  child: Transform.rotate(
                    angle: -0.60,
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              _buildTimeBox('2', 'Days'),
              _buildTimeBox('10', 'Hours'),
              _buildTimeBox('32', 'Min'),
              _buildTimeBox('45', 'Sec'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xffFBF7EB),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                value,
                style: getTextStyle(
                  fontSize: 20,
                  color: AppColors.buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                label,
                style: getTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.buttonColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVenueList(context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.39,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _buildVenueCard(context);
        },
      ),
    );
  }

  Widget _buildVenueCard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.7;
    return Container(
      width: cardWidth,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  ImagePath.venuesHall,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '4.5',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.star, size: 12),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.favorite_border, size: 18),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Icon(Icons.threesixty, size: 24, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The Grand Hall',
            style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Color(0xff8A8A8A),
                size: 16,
              ),
              SizedBox(height: 4),
              Text(
                'New York',
                style: getTextStyle(color: Color(0xff8A8A8A), fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Add to Compare',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.iconColor,
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '300 Guests',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 22),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: Text(
                  'View Details',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

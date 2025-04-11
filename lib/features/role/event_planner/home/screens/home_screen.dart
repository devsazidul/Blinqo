import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/feature_venue.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/upcomming_events.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 32),
                _buildSearchBar(searchTEController),
                SizedBox(height: 20),
                _buildTitle('Featured Venues'),
                SizedBox(height: 8),
                _buildVenueList(context),
                SizedBox(height: 40),

                _buildTitle('Upcoming Events'),
                SizedBox(height: 20),
                UpcommingEvents(),
                SizedBox(height: 8),
                UpcommingEvents(),
                SizedBox(height: 8),
                UpcommingEvents(),

                SizedBox(height: 40),
                _buildTitle('Venues Near You'),
                _buildVenueList(context),

                _buildTitle('Event Services'),
                _eventServicesList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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

  Widget _buildVenueList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: FeatureVenues(),
          );
        }),
      ),
    );
    // return SizedBox(
    //   height: MediaQuery.of(context).size.height * 0.45,
    //   child: ListView.builder(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: 5,
    //       itemBuilder: (context, index){
    //         return Padding(
    //           padding: EdgeInsets.only(right: 16),
    //           child: VenueCard(),
    //         );
    //       }
    //   ),
    // );
  }

  // ignore: unused_element
  Widget _buildUpCommingEventsList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: UpcommingEvents(),
          );
        }),
      ),
    );
  }

  /*Widget _buildVenueList(context) {
    double screenHeight=MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: screenHeight*0.45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _buildVenueCard(context);
        },
      ),
    );
  }*/

  Widget _eventServicesList(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height for the horizontal list
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          
          return SizedBox(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    ImagePath.venuesHall,
                    height: 85,
                    width: 116,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Photography',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

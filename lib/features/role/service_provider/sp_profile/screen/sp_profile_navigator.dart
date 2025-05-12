import 'package:blinqo/features/role/service_provider/sp_profile/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/profile_settings_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/share_work_page.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_profile_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/work_post_screen.dart';
import 'package:flutter/material.dart';

class SpProfile extends StatelessWidget {
  const SpProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget screen;
        switch (settings.name) {
          case SpProfileSettingsScreen.name:
            screen = SpProfileSettingsScreen(); // sp profile settings
            break;
          case SpEditProfilePage.name:
            screen = SpEditProfilePage(); // sp edit profile
            break;
          case SpShareWorkPage.name:
            screen = SpShareWorkPage(); // sp share work
            break;
          case WorkPostScreen.name:
            screen = WorkPostScreen(); // sp works portfolio
            break;
          default:
            screen = SpProfileScreen(); // profile home page
            break;
        }
        return MaterialPageRoute(builder: (_) => screen);
      },
    );
  }
}

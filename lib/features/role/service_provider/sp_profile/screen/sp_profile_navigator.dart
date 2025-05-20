import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_profile_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_profile_settings_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_share_work_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_work_details_screen.dart';
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

          case SpShareWorkScreen.name:
            screen = SpShareWorkScreen(); // sp share work
            break;
          case SpWorkDetailsScreen.name:
            screen = SpWorkDetailsScreen();
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

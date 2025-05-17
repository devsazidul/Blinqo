// import 'dart:convert';
// import 'dart:io';

// import 'package:blinqo/core/common/styles/global_text_style.dart';
// import 'package:blinqo/core/urls/endpoint.dart';
// import 'package:blinqo/core/utils/constants/colors.dart';
// import 'package:blinqo/features/role/event_planner/profile/model/usermodel.dart';
// import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
// import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ProfileController extends GetxController {
//   //
//   var isDarkMode = false.obs;
//   var showNotifications = true.obs;

//   var profileImage = Rx<File?>(null);

//   Future<void> pickImage() async {
//     await requestPermissions();

//     final ImagePicker picker = ImagePicker();

//     final ImageSource? source = await showPickrOption();

//     if (source != null) {
//       final XFile? pickedFile = await picker.pickImage(source: source);

//       if (pickedFile != null) {
//         profileImage.value = File(pickedFile.path);
//       } else {
//         debugPrint("No image selected");
//       }
//     }
//   }

//   Future<void> requestPermissions() async {
//     PermissionStatus cameraStatus = await Permission.camera.request();
//     PermissionStatus storageStatus = await Permission.storage.request();

//     if (cameraStatus.isDenied || storageStatus.isDenied) {
//       debugPrint("Permission denied");
//     } else {
//       debugPrint("Permission granted");
//     }
//   }

//   Future<ImageSource?> showPickrOption() async {
//     return await Get.bottomSheet(
//       Container(
//         padding: EdgeInsets.all(20),
//         color: AppColors.primary,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Choose Image Source",
//               style: getTextStyle(color: AppColors.textColor, fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             ListTile(
//               leading: Icon(Icons.camera_alt, color: AppColors.textColor),
//               title: Text(
//                 "Camera",
//                 style: getTextStyle(color: AppColors.textColor),
//               ),
//               onTap: () {
//                 Get.back(result: ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.image, color: AppColors.textColor),
//               title: Text(
//                 "Gallery",
//                 style: getTextStyle(color: AppColors.textColor),
//               ),
//               onTap: () {
//                 Get.back(result: ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 10 image for upload
//   var tenImageUpload = RxList<File>([]);

//   Future<void> tenpickImage() async {
//     if (tenImageUpload.length >= 10) {
//       Get.snackbar('Limit Reached', 'You can only upload up to 10 images');
//       return;
//     }

//     await requestPermissions();

//     final ImagePicker picker = ImagePicker();

//     final ImageSource? source = await tenImageshowPickrOption();

//     if (source != null) {
//       final XFile? pickedFile = await picker.pickImage(source: source);

//       if (pickedFile != null) {
//         tenImageUpload.add(File(pickedFile.path));
//       } else {
//         debugPrint("No image selected");
//       }
//     }
//   }

//   Future<void> tenImagerequestPermissions() async {
//     PermissionStatus cameraStatus = await Permission.camera.request();
//     PermissionStatus storageStatus = await Permission.storage.request();

//     if (cameraStatus.isDenied || storageStatus.isDenied) {
//       debugPrint("Permission denied");
//     } else {
//       debugPrint("Permission granted");
//     }
//   }

//   Future<ImageSource?> tenImageshowPickrOption() async {
//     return await Get.bottomSheet(
//       Container(
//         padding: EdgeInsets.all(20),
//         color: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Choose Image Source", style: TextStyle(fontSize: 20)),
//             SizedBox(height: 20),

//             ListTile(
//               leading: Icon(Icons.image),
//               title: Text("Gallery"),
//               onTap: () {
//                 Get.back(result: ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void toggleDarkMode() async {
//     isDarkMode.value = !isDarkMode.value;
//     update();
//   }

//   void toggleNotifications() {
//     showNotifications.value = !showNotifications.value;
//     update();
//   }

//   //============================================================================
//   final userInfo = Rx<UserInfo?>(null);
//   final isLoadingUser = false.obs;

//   Future<void> getUser() async {
//     debugPrint(
//       'Starting getUser function at ${DateTime.now().toIso8601String()}',
//     );
//     try {
//       debugPrint('Setting isLoadingUser to true');
//       isLoadingUser.value = true;

//       debugPrint('Showing EasyLoading with status: Loading user data...');
//       EasyLoading.show(status: "Loading user data...");

//       debugPrint('Fetching access token from AuthService');
//       final accessToken = await AuthService.getToken();
//       debugPrint(
//         'Access token received: ${accessToken != null ? 'Token present' : 'Token null or empty'}',
//       );
//       if (accessToken == null || accessToken.isEmpty) {
//         debugPrint('Throwing exception: Authentication token not found');
//         throw Exception('Authentication token not found');
//       }
//       debugPrint('Preparing HTTP GET request to: ${Urls.getUserInfo}');
//       debugPrint(
//         'Request headers: Authorization: Bearer $accessToken, Content-Type: application/json',
//       );
//       final response = await http.get(
//         Uri.parse(Urls.getUserInfo),
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//       );
//       debugPrint(
//         'HTTP response received with status code: ${response.statusCode}',
//       );
//       debugPrint('Response body: ${response.body}');
//       if (response.statusCode == 200) {
//         debugPrint('Parsing response body as JSON');
//         final responseData = jsonDecode(response.body);
//         debugPrint('Parsed response data: $responseData');

//         debugPrint('Checking if success is true: ${responseData['success']}');
//         if (responseData['success'] == true) {
//           debugPrint('Parsing response into UserInfo model');
//           userInfo.value = UserInfo.fromJson(responseData);
//           debugPrint(
//             'UserInfo parsed and assigned: ${userInfo.value?.data?.name ?? 'No name'}',
//           );
//         } else {
//           debugPrint(
//             'Throwing exception: Failed to fetch user data: ${responseData['message']}',
//           );
//           throw Exception(
//             'Failed to fetch user data: ${responseData['message']}',
//           );
//         }
//       } else {
//         debugPrint(
//           'Throwing exception: Failed to load user data: ${response.statusCode}',
//         );
//         throw Exception('Failed to load user data: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Caught exception: $e');
//       EasyLoading.showError("Failed to load user data: ${e.toString()}");
//       debugPrint(
//         'Showing EasyLoading with error: Failed to load user data: ${e.toString()}',
//       );
//     } finally {
//       debugPrint('Setting isLoadingUser to false');
//       isLoadingUser.value = false;

//       debugPrint('Dismissing EasyLoading');
//       EasyLoading.dismiss();

//       debugPrint(
//         'getUser function completed at ${DateTime.now().toIso8601String()}',
//       );
//     }
//   }

//   //==========================================================================
//   void logOut() async {
//     await AuthService.clearAuthData();
//     Get.offAll(() => LogInScreen());
//   }

//   //===========================================================================
//   @override
//   void onInit() {
//     getUser();
//     super.onInit();
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';
import 'package:blinqo/features/role/event_planner/profile/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  var isDarkMode = false.obs;
  var showNotifications = true.obs;

  var profileImage = Rx<File?>(null);

  final userInfo = Rx<UserInfo?>(null);
  final isLoadingUser = false.obs;

  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController locationController;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    userNameController = TextEditingController();
    locationController = TextEditingController();

    getUser();
  }

  @override
  void onClose() {
    nameController.dispose();
    userNameController.dispose();
    locationController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    await requestPermissions();

    final ImagePicker picker = ImagePicker();

    final ImageSource? source = await showPickrOption();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      } else {
        debugPrint("No image selected");
      }
    }
  }

  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied");
    } else {
      debugPrint("Permission granted");
    }
  }

  Future<ImageSource?> showPickrOption() async {
    return await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        color: AppColors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose Image Source",
              style: getTextStyle(color: AppColors.textColor, fontSize: 20),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.textColor),
              title: Text(
                "Camera",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () {
                Get.back(result: ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: AppColors.textColor),
              title: Text(
                "Gallery",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () {
                Get.back(result: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUser() async {
    try {
      isLoadingUser.value = true;
      EasyLoading.show(status: "Loading user data...");

      final accessToken = await AuthService.getToken();
      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse(Urls.getUserInfo),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          userInfo.value = UserInfo.fromJson(responseData);

          // Populate text controllers after userInfo is updated
          nameController.text = userInfo.value?.data?.name ?? '';
          userNameController.text = userInfo.value?.data?.profile?.name ?? '';
          locationController.text =
              userInfo.value?.data?.profile?.location ?? '';
        } else {
          throw Exception(
            'Failed to fetch user data: ${responseData['message']}',
          );
        }
      } else {
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.showError("Failed to load user data: ${e.toString()}");
    } finally {
      isLoadingUser.value = false;
      EasyLoading.dismiss();
    }
  }

  // Future<void> updateProfile({
  //   required String name,
  //   required String userName,
  //   required String location,
  // }) async {
  //   debugPrint(
  //     'Starting updateProfile with name: $name, userName: $userName, location: $location',
  //   );
  //   EasyLoading.show(status: "Updating profile...");

  //   try {
  //     debugPrint('Retrieving access token...');
  //     final accessToken = await AuthService.getToken();
  //     debugPrint('Access token: $accessToken');

  //     debugPrint('Retrieving profile ID...');
  //     final profileId = await AuthService.getProfileId();
  //     debugPrint('Profile ID: $profileId');

  //     debugPrint('Checking authentication data...');
  //     if (accessToken == null ||
  //         accessToken.isEmpty ||
  //         profileId == null ||
  //         profileId.isEmpty) {
  //       debugPrint(
  //         'Authentication data missing: token=$accessToken, profileId=$profileId',
  //       );
  //       throw Exception('Authentication data not found');
  //     }

  //     debugPrint('Constructing API URL...');
  //     final url = Uri.parse(
  //       'https://freepik.softvenceomega.com/profile/planner-profile-update/$profileId',
  //     );
  //     debugPrint('API URL: $url');

  //     debugPrint('Preparing request body...');
  //     final Map<String, dynamic> body = {
  //       "name": name,
  //       "userName": userName,
  //       "location": location,
  //     };
  //     debugPrint('Request body: ${jsonEncode(body)}');

  //     debugPrint('Sending HTTP POST request...');
  //     final response = await http.patch(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(body),
  //     );
  //     debugPrint('Response status code: ${response.statusCode}');
  //     debugPrint('Response body: ${response.body}');

  //     debugPrint('Processing response...');
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       debugPrint('Parsing response JSON...');
  //       final data = jsonDecode(response.body);
  //       debugPrint('Parsed response data: $data');

  //       if (data['success'] == true) {
  //         debugPrint('Profile update successful, refreshing user info...');
  //         await getUser(); // Refresh user info after update
  //         debugPrint('User info refreshed');
  //         EasyLoading.showSuccess("Profile updated successfully");
  //         debugPrint('Success message shown');
  //       } else {
  //         debugPrint(
  //           'Update failed: ${data['message'] ?? "No message provided"}',
  //         );
  //         throw Exception(data['message'] ?? "Failed to update profile");
  //       }
  //     } else {
  //       debugPrint('Request failed with status: ${response.statusCode}');
  //       throw Exception('Failed to update profile: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     debugPrint('Error occurred: $e');
  //     EasyLoading.showError(e.toString());
  //     debugPrint('Error message shown: $e');
  //   } finally {
  //     debugPrint('Dismissing EasyLoading...');
  //     EasyLoading.dismiss();
  //     debugPrint('EasyLoading dismissed');
  //   }
  // }

  Future<void> updateProfile({
    required String name,
    required String userName,
    required String location,
  }) async {
    debugPrint('Starting updateProfile...');
    debugPrint('Name: $name, UserName: $userName, Location: $location');
    EasyLoading.show(status: "Updating profile...");

    try {
      debugPrint('Getting access token...');
      final accessToken = await AuthService.getToken();
      debugPrint('Access token: $accessToken');

      debugPrint('Getting profile ID...');
      final profileId = await AuthService.getProfileId();
      debugPrint('Profile ID: $profileId');

      if (accessToken == null ||
          accessToken.isEmpty ||
          profileId == null ||
          profileId.isEmpty) {
        throw Exception('Authentication data not found');
      }

      final url = Uri.parse('${Urls.updatePlannerProfile}/$profileId');
      debugPrint('API URL: $url');

      final request = http.MultipartRequest('PATCH', url);

      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Content-Type'] = 'multipart/form-data';

      debugPrint('Adding text fields...');
      request.fields['name'] = name;
      request.fields['userName'] = userName;
      request.fields['location'] = location;

      if (profileImage.value != null) {
        final file = profileImage.value!;
        final fileName = path.basename(file.path);
        debugPrint('Extracted filename: $fileName');

        // Optional: send filename explicitly if backend expects it
        // request.fields['imageFileName'] = fileName;

        final multipartFile = await http.MultipartFile.fromPath(
          'image',
          file.path,
          filename: fileName,
        );
        request.files.add(multipartFile);
        debugPrint('Multipart file added with filename: $fileName');
      } else {
        debugPrint('No image selected to upload');
      }

      debugPrint('Sending multipart PATCH request...');
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          debugPrint('Profile update success');

          if (data['data'] != null &&
              data['data']['profile'] != null &&
              data['data']['profile']['image'] != null) {
            final imageUrl = data['data']['profile']['image']['path'];
            debugPrint('Updated profile image URL: $imageUrl');
          } else {
            debugPrint('No image URL found in response');
          }

          await getUser(); // Refresh user info
          EasyLoading.showSuccess("Profile updated successfully");
        } else {
          final msg = data['message'] ?? "Failed to update profile";
          debugPrint('Update failed with message: $msg');
          throw Exception(msg);
        }
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during updateProfile: $e');
      EasyLoading.showError(e.toString());
    } finally {
      debugPrint('Dismissing loading indicator...');
      EasyLoading.dismiss();
    }
  }

  //================================================================================

  void logOut() async {
    await AuthService.clearAuthData();
    Get.offAll(() => LogInScreen());
  }

  void toggleDarkMode() async {
    isDarkMode.value = !isDarkMode.value;
    update();
  }

  void toggleNotifications() {
    showNotifications.value = !showNotifications.value;
    update();
  }
}

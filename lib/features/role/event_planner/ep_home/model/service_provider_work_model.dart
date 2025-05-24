// // To parse this JSON data, do
// //
// //     final serviceProviderUserWorkModel = serviceProviderUserWorkModelFromJson(jsonString);

// import 'dart:convert';

// ServiceProviderUserWorkModel serviceProviderUserWorkModelFromJson(String str) => ServiceProviderUserWorkModel.fromJson(json.decode(str));

// String serviceProviderUserWorkModelToJson(ServiceProviderUserWorkModel data) => json.encode(data.toJson());

// class ServiceProviderUserWorkModel {
//   List<ServiceProviderWork> data;
//   String message;
//   int statusCode;
//   bool success;

//   ServiceProviderUserWorkModel({
//     required this.data,
//     required this.message,
//     required this.statusCode,
//     required this.success,
//   });

//   factory ServiceProviderUserWorkModel.fromJson(Map<String, dynamic> json) => ServiceProviderUserWorkModel(
//     data: List<ServiceProviderWork>.from(json["data"].map((x) => ServiceProviderWork.fromJson(x))),
//     message: json["message"],
//     statusCode: json["statusCode"],
//     success: json["success"],
//   );

//   Map<String, dynamic> toJson() => {
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "message": message,
//     "statusCode": statusCode,
//     "success": success,
//   };
// }

// class ServiceProviderWork {
//   String id;
//   String eventTypeId;
//   String projectTitle;
//   String description;
//   String profileId;
//   List<FileElement> files;

//   ServiceProviderWork({
//     required this.id,
//     required this.eventTypeId,
//     required this.projectTitle,
//     required this.description,
//     required this.profileId,
//     required this.files,
//   });

//   factory ServiceProviderWork.fromJson(Map<String, dynamic> json) => ServiceProviderWork(
//     id: json["id"],
//     eventTypeId: json["eventTypeId"],
//     projectTitle: json["projectTitle"],
//     description: json["description"],
//     profileId: json["profileId"],
//     files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "eventTypeId": eventTypeId,
//     "projectTitle": projectTitle,
//     "description": description,
//     "profileId": profileId,
//     "files": List<dynamic>.from(files.map((x) => x.toJson())),
//   };
// }

// class FileElement {
//   String path;

//   FileElement({
//     required this.path,
//   });

//   factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
//     path: json["path"],
//   );

//   Map<String, dynamic> toJson() => {
//     "path": path,
//   };
// }

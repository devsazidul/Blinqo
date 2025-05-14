import 'package:image_picker/image_picker.dart';

class WorkPost {
  final String eventType;
  final String projectTitle;
  final String description;
  final List<XFile> photos;
  int likes;
  bool isLiked;

  WorkPost({
    required this.eventType,
    required this.projectTitle,
    required this.description,
    required this.photos,
    this.likes = 0,
    this.isLiked = false,
  });
}

class WorkShowcaseModel {
  String? id;
  String? eventTypeId;
  String? projectTitle;
  String? description;
  String? profileId;
  List<ImageModel>? files;

  WorkShowcaseModel({
    this.id,
    this.eventTypeId,
    this.projectTitle,
    this.description,
    this.profileId,
    this.files,
  });

  factory WorkShowcaseModel.fromJson(Map<String, dynamic> json) {
    return WorkShowcaseModel(
      id: json['id'],
      eventTypeId: json['eventTypeId'],
      projectTitle: json['projectTitle'],
      description: json['description'],
      profileId: json['profileId'],
      files:
          json['files'] != null
              ? List<ImageModel>.from(
                json['files'].map((x) => ImageModel.fromJson(x)),
              )
              : null,
    );
  }
}

class ImageModel {
  String? id;
  String? path;

  ImageModel({this.id, this.path});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['id'], path: json['path']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'path': path};
  }
}

/* -------------------------- Work Post Model --------------------------
{
  "data": {
    "id": "adaa3e21-6628-4b00-8141-c4fccf2d2ead",
    "eventTypeId": "0865c05b-9cf0-4fc6-b8d1-7877a6418a99",
    "projectTitle": "Charity Events on Dhaka",
    "description": "This is test 5 description",
    "profileId": "d60545e3-6e1a-423c-943d-4db94c1ab2ce",
    "files": [
      {
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/charity_events.png-317f2123-bbfe-4859-b520-c18e547a81d6?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T102507Z&X-Amz-Expires=604800&X-Amz-Signature=1539045d976c3c9533173bd44569a39a9d5d3de48234583d7ad7ba6e23824a8b&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
      },
      {
        "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/private_party.png-b4233dd1-786e-44e3-85fe-7c2d701747e1?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T102507Z&X-Amz-Expires=604800&X-Amz-Signature=b6471480eef8cc7f4d147a72accd12844d40485ee0aac16b9682b4e2bc5e2b94&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
      }
    ]
  },
  "message": "Work created successfully",
  "statusCode": 200,
  "success": true
}
*/

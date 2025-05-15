class SpWorksModel {
  String? id;
  String? eventTypeId;
  String? projectTitle;
  String? description;
  String? profileId;
  List<ImageModel>? files;

  SpWorksModel({
    this.id,
    this.eventTypeId,
    this.projectTitle,
    this.description,
    this.profileId,
    this.files,
  });

  factory SpWorksModel.fromJson(Map<String, dynamic> json) {
    return SpWorksModel(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventTypeId': eventTypeId,
      'projectTitle': projectTitle,
      'description': description,
      'profileId': profileId,
      'files': files?.map((e) => e.toJson()).toList(),
    };
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


/*
{
  "data": [
    {
      "id": "61779279-badd-4680-896e-0a66fead9b13",
      "eventTypeId": "c59ea157-c680-4e3b-9cf1-0481ea0840e1",
      "projectTitle": "jaskl kladsjkl jlksa",
      "description": "af kaskjf jkafj kajaju jlda kl",
      "profileId": "fedb3af2-8e70-40ff-8814-195ba3ab1cad",
      "files": [
        {
          "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/20.jpg-4b84c467-1f63-405a-b12c-3cbeb52c02cf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T123000Z&X-Amz-Expires=604800&X-Amz-Signature=58b4149f85efe492e875cc667bd0192e3a80866f7c02dc8d98b451339dce7daf&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
        }
      ]
    },
    {
      "id": "f49dc0d1-ddc4-40f0-ad4a-ea936c44b6c3",
      "eventTypeId": "689d7a24-8c28-4aaf-94d0-4470b9f252db",
      "projectTitle": "kjdaj kjak kjak",
      "description": "klajl jaklsjf kljdsalk jkalsjklajf a",
      "profileId": "fedb3af2-8e70-40ff-8814-195ba3ab1cad",
      "files": [
        {
          "path": "https://ozvxzsjtzdrrwejjiomf.supabase.co/storage/v1/s3/test/25.jpg-d2c3dc05-add2-4da0-844c-efdda7f88173?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=2b700c1e6de008e04d66a3807269523b%2F20250514%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250514T123403Z&X-Amz-Expires=604800&X-Amz-Signature=93a8620536d7440fe355054f308dd6c6a32f4f775c69a14f5656e6e5ea8bd621&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
        }
      ]
    }
  ],
  "message": "Works fetched successfully",
  "statusCode": 200,
  "success": true
}
*/
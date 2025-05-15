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

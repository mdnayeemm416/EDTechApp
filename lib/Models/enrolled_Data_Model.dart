class Course {
  String name;
  String courses;
  String image;
  List<CourseDetails> details;

  Course({
    required this.name,
    required this.courses,
    required this.image,
    required this.details,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    List<dynamic> detailsList = json['Details'] ?? [];
    List<CourseDetails> details = detailsList.map((detail) => CourseDetails.fromJson(detail)).toList();

    return Course(
      name: json['name'],
      courses: json['courses'],
      image: json['image'],
      details: details,
    );
  }
}

class CourseDetails {
  String id;
  String duration;
  String title;
  String videoUrl;

  CourseDetails({
    required this.id,
    required this.duration,
    required this.title,
    required this.videoUrl,
  });

  factory CourseDetails.fromJson(Map<String, dynamic> json) {
    return CourseDetails(
      id: json['id'],
      duration: json['duration'],
      title: json['title'],
      videoUrl: json['videoUrl'],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Category {
  final String name;
  final String numOfCourses; // Explicitly specify the type as int
  final String image;

  Category(
    this.name,
    this.numOfCourses,
    this.image,
  );
}

List<Category> categories = categoriesData
    .map((item) => Category(
          item['name'].toString(),
          item['courses'].toString(),
          item['image'].toString(),
        ))
    .toList();

var categoriesData = [
  {"name": "Flutter", 'courses': "17", 'image': "assets/images/Flutter.jpg"},
  {"name": "UX Design", 'courses': "25", 'image': "assets/images/UX.jpg"},
  {"name": "Dart", 'courses': "13", 'image': "assets/images/Dart.png"},
  {"name": "Python", 'courses': "17", 'image': "assets/images/Python.jpg"},
];

import 'dart:convert';

import 'package:asignment/Models/enrolled_Data_Model.dart';
import 'package:asignment/controller/selected_course_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Course> courses = <Course>[].obs;
  final SelectedCourseController selectedCourseController =
      Get.put(SelectedCourseController());

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      String data = await rootBundle.loadString('File/data.json');
      List<dynamic> jsonList = json.decode(data);

      courses.assignAll(jsonList.map((json) => Course.fromJson(json)).toList());
      isLoading.value = false;
    } catch (error) {
      print('Error loading JSON file: $error');
    }
  }

  void setSelectedCourse(Course course) {
    selectedCourseController.selectedCourse.value = course;
  }
}

import 'package:asignment/App_Constant/constant.dart';
import 'package:asignment/controller/selected_course_controller.dart';
import 'package:asignment/utilitis/videoData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMark extends StatelessWidget {
  const BookMark({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectedCourseController selectedCourseController =
        Get.put(SelectedCourseController());
    final capturedVideoDataList =
        selectedCourseController.capturedVideoDataList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("BookMark List")),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 20),
          color: const Color.fromARGB(255, 234, 243, 247),
          height: Get.height,
          width: Get.width,
          child: Obx(
            () => ListView.builder(
              itemCount: capturedVideoDataList.length,
              itemBuilder: (context, index) {
                final VideoData videoData = capturedVideoDataList[index];
                return Card(
                  child: ListTile(
                      leading: const Icon(
                        Icons.star_border_outlined,
                        color: BlueColor,
                      ),
                      title: Text(videoData.courseName),
                      subtitle: Text(
                          "${videoData.videoTitle} - ${videoData.getFormattedTime()} s "),
                      trailing: IconButton(
                          onPressed: () {
                            selectedCourseController.removeBookmark(index);
                          },
                          icon: const Icon(Icons.delete))),
                );
              },
            ),
          )),
    );
  }
}

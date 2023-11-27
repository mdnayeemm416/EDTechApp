// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asignment/controller/selected_course_controller.dart';
import 'package:asignment/widgets/VideoView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:asignment/App_Constant/constant.dart';
import 'package:asignment/widgets/Module_Content.dart';
import 'package:video_player/video_player.dart';

import '../Models/enrolled_Data_Model.dart';

class CoursePlayerPage extends StatefulWidget {
  const CoursePlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CoursePlayerPage> createState() => _CoursePlayerPageState();
}

class _CoursePlayerPageState extends State<CoursePlayerPage> {
  final SelectedCourseController selectedCourseController =
      Get.put(SelectedCourseController());

//Video Play Fuction
  late VideoPlayerController _controller;

  void Intilized_Video(int index, String videoUrl) {
    if (videoUrl.isNotEmpty) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      _controller = controller;
      setState(() {});
      controller.initialize().then((_) {
        selectedCourseController.playingIndex.value = index;
        controller.addListener(() {
          _oncontrollerUpdate();
        });
        controller.play();
        setState(() {});
      });
    }
  }

  Future<void> _oncontrollerUpdate() async {
    final controller = _controller;
    final videoPlaying = controller.value.isPlaying;
    selectedCourseController.videoPlaying.value = videoPlaying;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Course? course = selectedCourseController.selectedCourse.value;
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didpop) async {
        selectedCourseController.IsPlaying.value = true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(course!.image),
              alignment: Alignment.topRight,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: [
              Obx(() => selectedCourseController.IsPlaying.value
                  ? Container(
                      height: 200,
                      width: Get.width,
                      child: Text("Learn Flutter"),
                    )
                  : VideoView(context)),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Course Content",
                        style: titleTextStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: course.details.length,
                          itemBuilder: (_, index) {
                            CourseDetails Details = course.details[index];
                            return GestureDetector(
                              onTap: () {
                                selectedCourseController.IsPlaying.value =
                                    false;

                                Intilized_Video(index, Details.videoUrl);
                              },
                              child: CourseContent(
                                number: "0${Details.id}",
                                duration: 19.04,
                                title: "Design Thinking - Intro",
                                isDone: true,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Video View Widget

  Widget VideoView(BuildContext context) {
    final controller = _controller;
    if (controller.value.isInitialized) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(controller),
          ),
          Container(
            height: 50,
            width: Get.width,
            color: Colors.black,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    final index = selectedCourseController.playingIndex + 1;
                    final length = selectedCourseController
                        .selectedCourse.value!.details.length;
                    final videoUrl = selectedCourseController
                        .selectedCourse.value!.details[index.toInt()].videoUrl;
                    if (index >= 0 && length >= 0) {
                      Intilized_Video(index.toInt(), videoUrl);
                    }
                  },
                  child: Text("Next"),
                ),
                TextButton(
                    onPressed: () {
                      final index = selectedCourseController.playingIndex - 1;
                      final length = selectedCourseController
                          .selectedCourse.value!.details.length;
                      final videoUrl = selectedCourseController.selectedCourse
                          .value!.details[index.toInt()].videoUrl;
                      if (index >= 0 && length >= 0) {
                        Intilized_Video(index.toInt(), videoUrl);
                      }
                    },
                    child: Text("Previous")),
                Obx(() => IconButton(
                      onPressed: () {
                        if (selectedCourseController.videoPlaying.value) {
                          controller.pause();
                          selectedCourseController.videoPlaying.value = false;
                        } else {
                          controller.play();
                          selectedCourseController.videoPlaying.value = true;
                        }
                      },
                      icon: selectedCourseController.videoPlaying.value
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow_sharp),
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}

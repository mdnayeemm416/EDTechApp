import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:asignment/App_Constant/constant.dart';
import 'package:asignment/View/BookMark.dart';
import 'package:asignment/View/Dashboard.dart';
import 'package:asignment/controller/selected_course_controller.dart';
import 'package:asignment/utilitis/videoData.dart';
import 'package:asignment/widgets/Module_Content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

//Video Play Function

  CustomVideoPlayerController? _customVideoPlayerController;

  void disposeOldController() {
    if (_customVideoPlayerController != null) {
      _customVideoPlayerController!.dispose();
      _customVideoPlayerController = null;
    }
  }

  void initializeVideo(int index, videoUrl) {
    disposeOldController();
    VideoPlayerController videoPlayerController;
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((value) {
            selectedCourseController.playingIndex.value = index;
            setState(() {});
          });
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoPlayerController);
  }

  //capturedVideoDataList//

  void captureCurrentVideoData() {
    final capturedVideoDataList =
        selectedCourseController.capturedVideoDataList;
    final Course? course = selectedCourseController.selectedCourse.value;
    final currentTime = _customVideoPlayerController
        ?.videoPlayerController.value.position.inSeconds
        .toDouble();

    if (currentTime != null) {
      final courseName = course?.name ?? "";
      final videoTitle =
          course?.details[selectedCourseController.playingIndex.value].title ??
              "";
      final currentVideoData = VideoData(
        courseName: courseName,
        videoTitle: videoTitle,
        currentTime: currentTime,
      );

      capturedVideoDataList.add(currentVideoData);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("BookMarks Added"),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  void dispose() {
    _customVideoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Course? course = selectedCourseController.selectedCourse.value;
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didpop) async {
        selectedCourseController.isPlaying.value = true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(course!.name)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(const BookMark());
                },
                icon: const Icon(Icons.star))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(course.image),
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Column(
              children: [
                Obx(() => selectedCourseController.isPlaying.value
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * .1),
                        child: Container(
                          margin: const EdgeInsets.only(left: 30),
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: BlueColor,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    : videoView(context)),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: Get.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${course.name} Complete Course",
                          style: titleTextStyle,
                        ),
                        const Text(
                          "Enhance your knowledge through learning",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 81, 80, 80)),
                        ),
                        Text(
                          "${course.details.length} videos",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: BlueColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text("PlayList",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: course.details.length,
                            itemBuilder: (_, index) {
                              CourseDetails details = course.details[index];
                              return GestureDetector(
                                onTap: () {
                                  selectedCourseController.isPlaying.value =
                                      false;
                                  initializeVideo(index, details.videoUrl);
                                },
                                child: CourseContent(
                                  number: "0${details.id}",
                                  duration: details.duration,
                                  title: details.title,
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
      ),
    );
  }

  //Video View Widget

  Widget videoView(BuildContext context) {
    final controller = _customVideoPlayerController;

    final length =
        selectedCourseController.selectedCourse.value!.details.length;

    if (controller!.videoPlayerController.value.isInitialized) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CustomVideoPlayer(customVideoPlayerController: controller),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 40,
            width: Get.width,
            color: Colors.black,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    RxInt index = selectedCourseController.playingIndex - 1;
                    debugPrint("index $index");
                    if (index >= 0) {
                      final videoUrl = selectedCourseController.selectedCourse
                          .value!.details[index.toInt()].videoUrl;
                      initializeVideo(index.toInt(), videoUrl);
                    } else {
                      Get.snackbar(
                          "Alert", "This is the first video of the course",
                          backgroundColor: Colors.white,
                          duration: const Duration(seconds: 1));
                      index++;
                    }
                  },
                  child: const Text(
                    "Previous",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    RxInt index = selectedCourseController.playingIndex + 1;
                    debugPrint("index $index");
                    if (index < length) {
                      final videoUrl = selectedCourseController.selectedCourse
                          .value!.details[index.toInt()].videoUrl;
                      initializeVideo(index.toInt(), videoUrl);
                    } else {
                      Get.defaultDialog(
                          title: "CONGRATULATION",
                          content: const Text(
                            "You Have Completed the course,Claim Your Certificate",
                            textAlign: TextAlign.center,
                          ),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: BlueColor),
                              onPressed: () {
                                Get.offAll(() => const Dashboard());
                              },
                              child: const Text(
                                "Claim",
                                style: TextStyle(color: Colors.white),
                              )));
                      index--;
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                    onPressed: () {
                      captureCurrentVideoData();
                    },
                    icon: const Icon(
                      Icons.star,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ],
      );
    } else {
      return Container(
        color: Colors.black,
        child: const AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }
}

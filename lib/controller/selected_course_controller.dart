import 'package:asignment/Models/enrolled_Data_Model.dart';
import 'package:get/get.dart';

class SelectedCourseController extends GetxController {
  Rx<Course?> selectedCourse = Rx<Course?>(null);
  RxBool isPlaying = true.obs;
  RxBool videoPlaying = false.obs;
  RxInt playingIndex = 2.obs;
  RxList capturedVideoDataList = [].obs;

   void removeBookmark(int index) {
    capturedVideoDataList.removeAt(index);
    update();
  }
}

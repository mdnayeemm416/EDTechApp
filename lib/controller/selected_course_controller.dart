import 'package:asignment/Models/enrolled_Data_Model.dart';
import 'package:get/get.dart';

class SelectedCourseController extends GetxController {
  Rx<Course?> selectedCourse = Rx<Course?>(null);
  RxBool IsPlaying = true.obs;
  RxBool videoPlaying = false.obs;
  RxInt playingIndex = 0.obs;
  var progress = 0.0.obs;

  convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }
}

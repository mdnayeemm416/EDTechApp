import 'package:asignment/Models/enrolled_Data_Model.dart';
import 'package:asignment/View/Course_Player%20_Page.dart';
import 'package:asignment/controller/DashboardController.dart';
import 'package:asignment/App_Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardController dashboardController = DashboardController();
  @override
  void initState() {
    super.initState();
    dashboardController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  const Text("Learn from your enrolled courses",
                      style: titleTextStyle),
                  SizedBox(height: Get.height * .03),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: "Search Enrolled Courses",
                        prefixIcon: const Icon(CupertinoIcons.search)),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * .03),
            const Text(
              "Enrolled courses",
              style: titleTextStyle,
            ),
            const SizedBox(height: 30),
            Expanded(child: Obx(() {
              if (dashboardController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return MasonryGridView.count(
                  padding: const EdgeInsets.all(0),
                  crossAxisCount: 2,
                  itemCount: dashboardController.courses.length,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  itemBuilder: (context, index) {
                    Course course = dashboardController.courses[index];
                    return Card(
                      child: Container(
                        height:
                            index.isEven ? Get.height * .4 : Get.height * .45,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 234, 243, 247),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white10,
                                offset: Offset(28, 28),
                                blurRadius: 30,
                              ),
                              BoxShadow(
                                color: Colors.white10,
                                offset: Offset(-28, -28),
                                blurRadius: 30,
                              ),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: Get.height * .2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(course.image),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.name,
                                    style: titleTextStyle,
                                  ),
                                  Text(
                                    '${"Module"} ${course.courses}',
                                    style: subtitleTextSyule,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        dashboardController
                                            .setSelectedCourse(course);
                                        Get.to(() => CoursePlayerPage());
                                      },
                                      child: Text(
                                        "Continue Course",
                                        style: TextStyle(
                                            fontSize: Get.height * .016),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            })),
          ],
        ),
      ),
    );
  }
}

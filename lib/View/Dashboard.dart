import 'package:asignment/Models/enrolled_Data_Model.dart';
import 'package:asignment/View/Course_player_page.dart';
import 'package:asignment/controller/DashboardController.dart';
import 'package:asignment/App_Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  @override
  void initState() {
    super.initState();
    dashboardController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            height: Get.height * .3,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                color: Color.fromARGB(255, 223, 242, 250)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enrolled courses",
                  style: titleTextStyle,
                ),
                const SizedBox(height: 30),
                SizedBox(
                    height: Get.height * .5,
                    width: Get.width,
                    child: Obx(() {
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
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 234, 243, 247),
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                              image: AssetImage(course.image),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            course.name,
                                            style: titleTextStyle,
                                          ),
                                          Text(
                                            '${"Module"} ${course.courses}',
                                            style: subtitleTextSyule,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                dashboardController
                                                    .setSelectedCourse(course);
                                                Get.to(() =>
                                                    const CoursePlayerPage());
                                              },
                                              child: Text(
                                                "Continue Course",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        Get.height * .016),
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
        ],
      ),
    );
  }
}

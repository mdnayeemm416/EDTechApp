import 'package:asignment/Models/Category.dart';
import 'package:asignment/utilitis/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Learn from your enrolled courses",
                style: titleTextStyle),
            SizedBox(height: Get.height * .03),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Search Enrolled Courses",
                  prefixIcon: const Icon(CupertinoIcons.search)),
            ),
            SizedBox(height: Get.height * .03),
            const Text(
              "Enrolled courses",
              style: subtitleTextSyule,
            ),
            SizedBox(height: 30),
            Expanded(
              child: MasonryGridView.count(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: categories.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: index.isEven ? Get.height * .35 : Get.height * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(28, 28),
                              blurRadius: 20,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-28, -28),
                              blurRadius: 20,
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                              child: Image.asset(
                                categories[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            categories[index].name,
                            style: titleTextStyle,
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Continue Course"))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

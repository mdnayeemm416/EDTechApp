import 'package:asignment/App_Constant/constant.dart';
import 'package:flutter/material.dart';

class CourseContent extends StatelessWidget {
  final String number;
  final String duration;
  final String title;
  final bool isDone;

  const CourseContent(
      {super.key,
      required this.number,
      required this.duration,
      required this.title,
      required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(
            number,
            style: headingextStyle.copyWith(
              color: TextColor.withOpacity(.15),
              fontSize: 32,
            ),
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "$duration mins",
                  style: subtitleTextSyule.copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BlueColor.withOpacity(isDone ? 1 : .5),
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white),
          )
        ],
      ),
    );
  }
}

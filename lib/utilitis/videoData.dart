class VideoData {
  final String courseName;
  final String videoTitle;
  final double currentTime;

  VideoData({
    required this.courseName,
    required this.videoTitle,
    required this.currentTime,
  });

  String getFormattedTime() {
    final minutes = (currentTime / 60).floor();
    final seconds = (currentTime % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

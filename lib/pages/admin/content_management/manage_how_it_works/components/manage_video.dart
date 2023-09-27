import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl; // Firebase Storage URL of the video

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    try {
      _videoPlayerController = VideoPlayerController.network(
          widget.videoUrl); // Replace with your video URL
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
        autoInitialize: true,
        autoPlay: true,
        looping: true, // Set to true if you want the video to loop
      );
      _videoPlayerController.initialize();
    } catch (error) {
      print('Error initializing video: $error');
    }
  }

  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

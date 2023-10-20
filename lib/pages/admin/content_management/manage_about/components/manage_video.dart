import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl; // Firebase Storage URL of the video

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _controller.initialize();
    _controller.setVolume(0.0);
    _controller.setLooping(true);
    _controller.play();
  }

  void togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 600,
      child: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    GestureDetector(
                      onTap:
                          togglePlayPause, // Toggle play and pause when tapped
                      child: Container(
                        color: Colors.transparent,
                        child: isPlaying
                            ? Container()
                            : Icon(
                                Icons.play_arrow,
                                size: 100.0,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      padding: EdgeInsets.all(8.0), // Add padding for tap area
                    ),
                  ],
                )

                // Stack(
                //   alignment: Alignment.bottomCenter,
                //   children: <Widget>[
                //     GestureDetector(
                //       onTap:
                //           togglePlayPause, // Toggle play and pause when tapped
                //       child: Container(
                //         color: Colors.transparent,
                //         child: Icon(
                //           isPlaying ? Icons.pause : Icons.play_arrow,
                //           size: 100.0,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     VideoProgressIndicator(
                //       _controller,
                //       allowScrubbing: true,
                //       padding: EdgeInsets.all(8.0), // Add padding for tap area
                //     ),
                //   ],
                // ),
                )
            : CircularProgressIndicator(), // Show a loading indicator until the video is initialized
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

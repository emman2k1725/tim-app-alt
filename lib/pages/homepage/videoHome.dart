import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoHomePlayer extends StatefulWidget {
  final String videoUrl; // Firebase Storage URL of the video

  const VideoHomePlayer({super.key, required this.videoUrl});

  @override
  _VideoHomePlayerState createState() => _VideoHomePlayerState();
}

class _VideoHomePlayerState extends State<VideoHomePlayer> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

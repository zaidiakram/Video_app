import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum DataSourceType{
    asset,
    network,
    file,
    contentUri,
  }
class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key, required this.url, required this.dataSourceType});
  final String url;
  final DataSourceType dataSourceType;
  
  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  
  void initState() {
    super.initState();

    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController = VideoPlayerController.network(widget.url);
        break;
      case DataSourceType.file:
        _videoPlayerController = VideoPlayerController.file(File(widget.url));
        break;

      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.url));
        break;
    }
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.dataSourceType.name.toUpperCase(),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        ),
        Divider(),
        AspectRatio(aspectRatio: 16 / 9,
        child: Chewie(controller: _chewieController),
        ),

      ],
    );
  }
}



class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          VideoPlayerView(url: 'assets/videos/nature.mp4',
          dataSourceType: DataSourceType.asset,
  
          ),
    SizedBox(
      height: 24,
    ),
    VideoPlayerView(url: 'https://drive.google.com/drive/folders/1KXYFruSATnTOJJ0HutStn1djSNcMoQnl',dataSourceType: DataSourceType.network,)
        ],
      ),
    );
  }
}

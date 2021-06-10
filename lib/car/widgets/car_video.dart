import 'package:car_project/car/entity/car.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CarVideo extends StatefulWidget {
  Car car;

  @override
  _CarVideoState createState() => _CarVideoState();

  CarVideo(this.car);
}

class _CarVideoState extends State<CarVideo> {
  VideoPlayerController _videoController;

  Car get car => widget.car;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(car.urlVideo)
      ..initialize().then((_) {
        setState(() {
          _videoController.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.nome)),
      body: Center(
          child: _videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                )
              : CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
          });
        },
        child: Icon(_videoController.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}

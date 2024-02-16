import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';



class AudioListScreen extends StatefulWidget {
  @override
  _AudioListScreenState createState() => _AudioListScreenState();
}

class _AudioListScreenState extends State<AudioListScreen> {
  final audioplayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late AudioPlayer _audioPlayer;
  String? _filePath;


  @override
  void initState() {
    super.initState();

    setAudio();

    audioplayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioplayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  Future setAudio() async {
    
    audioplayer.setReleaseMode(ReleaseMode.loop);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      print("Printing the source file: $file");
      audioplayer.setSourceUrl(file.path!);
    }
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Audio Player"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              iconSize: 50,
              onPressed: () async {
                await setAudio();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      'https://scontent.cdninstagram.com/v/t51.2885-15/273657942_445162613988048_3942992137409138749_n.webp?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMDgweDEwODAuc2RyIn0&_nc_ht=scontent.cdninstagram.com&_nc_cat=100&_nc_ohc=CtT51ng5FvYAX-Q_s96&edm=APs17CUBAAAA&ccb=7-5&ig_cache_key=Mjc3MDY5MzY5MTA1MTAzNzc0OQ%3D%3D.2-ccb7-5&oh=00_AfBw0pW7eQ0m18tnLnsKAVY8sp2xCnEMOzgkezq1FDYUbw&oe=65D276EE&_nc_sid=10d13b',
                      width: double.infinity,
                      height: 450,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 32,),
                  const Text(
                    'FLutter Nasheed',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 4,),
                  const Text(
                    'Absharul',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (double value) {
                      final newPosition = Duration(seconds: value.toInt());
                      audioplayer.seek(newPosition);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(position)),
                        Text(formatTime(duration - position)),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 35,
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      iconSize: 50,
                      onPressed: () async {
                        if (isPlaying) {
                          await audioplayer.pause();
                        } else {
                          await audioplayer.resume();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }


}


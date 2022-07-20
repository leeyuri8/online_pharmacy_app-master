// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';


typedef Fn = void Function();

class Playsound extends StatefulWidget {
  final String soundurl;
  Playsound(this.soundurl, {Key? key}) : super(key: key);

  @override
  State<Playsound> createState() => _PlaysoundState();
}

class _PlaysoundState extends State<Playsound> {
  late AudioPlayer audioPlayer;
  late AudioCache audioCache;

  bool? isPlaying;
  int volume = 0;
  @override
  void initState() {
    super.initState();
    isPlaying = false;
    audioPlayer = AudioPlayer();
  }

  Future stpsound() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  Duration _duration = new Duration();
  Duration _position = new Duration();

  Future palysoundsaudio() async {
    setState(() {
      isPlaying = true;
    });
    audioPlayer.play(widget.soundurl, isLocal: false);
    audioCache = new AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => _duration = d);
    });

    audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    audioPlayer.onPlayerCompletion.listen((duration) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer = AudioPlayer();
    super.dispose();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    print('ddd' + widget.soundurl);
                    isPlaying! ? stpsound() : palysoundsaudio();
                    setState(() {});
                  },
                  icon: Icon(isPlaying! ? Icons.pause : Icons.play_arrow),
                ),
                Slider(
                    value: _position.inSeconds.toDouble(),
                    min: 0.0,
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        seekToSecond(value.toInt());
                        value = value;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

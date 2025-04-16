import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'package:quran/quran.dart' as quran;

class DetailAudio extends StatefulWidget {
  var surahNum;
  DetailAudio(this.surahNum, {super.key});

  @override
  State<DetailAudio> createState() => _DetailAudioState();
}

class _DetailAudioState extends State<DetailAudio> {
  AudioPlayer audioPlayer = AudioPlayer();
  IconData playpausebutton = Icons.play_circle_fill_rounded;
  bool isplaying = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> togglebtn() async {
    try {
      final audioUrl = await quran.getAudioURLBySurah(widget.surahNum);
      audioPlayer.setUrl(audioUrl);
      if (isplaying) {
        audioPlayer.play();

        setState(() {
          isplaying = false;
          playpausebutton = Icons.pause_circle_filled;
        });
      } else {
        audioPlayer.pause();

        setState(() {
          isplaying = true;
          playpausebutton = Icons.play_circle_fill_rounded;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            quran.getSurahNameArabic(widget.surahNum),
            style: GoogleFonts.amiri(fontSize: 25),
          ),
          CircleAvatar(
            backgroundColor: Colors.indigo[900],
            radius: 100,
            backgroundImage: AssetImage("assets/images/alaffasy.png"),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            // color: Color(0xff012E40),
            color: Colors.indigo[900],
            child: Center(
              child: IconButton(
                  onPressed: togglebtn,
                  icon: Icon(color: Colors.white, playpausebutton)),
            ),
          )
        ],
      ),
    );
  }
}

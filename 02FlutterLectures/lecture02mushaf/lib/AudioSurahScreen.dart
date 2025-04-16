import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lecture02mushaf/DetailAudio.dart';
import 'package:lecture02mushaf/DetailSurah.dart';
import 'package:quran/quran.dart' as quran;

class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({super.key});

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "مصحف",
          style: GoogleFonts.amiri(),
        ),
      ),
      body: ListView.builder(
        itemCount: 114,
        itemBuilder: (context, index) {
          return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailAudio(index + 1),
                    ));
              },
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text(
                  quran.getSurahNameArabic(index + 1) +
                      " | " +
                      quran.getSurahName(index + 1),
                  style: GoogleFonts.amiriQuran()),
              subtitle: Text("الشيخ مشاري راشد العفاسي",
                  style: TextStyle(fontFamily: "jameelfont", fontSize: 20)),
              trailing: quran.getPlaceOfRevelation(index + 1) == "Makkah"
                  ? Image.asset(
                      "assets/images/kaaba.png",
                      width: 30,
                      height: 30,
                    )
                  : Image.asset(
                      "assets/images/madina.png",
                      width: 30,
                      height: 30,
                    ));
        },
      ),
    );
  }
}

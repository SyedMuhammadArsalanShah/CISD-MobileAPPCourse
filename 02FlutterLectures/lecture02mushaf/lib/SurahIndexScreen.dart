import 'package:flutter/material.dart';
import 'package:lecture02mushaf/DetailSurah.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({super.key});

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
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
                      builder: (context) => DetailSurah(index + 1),
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
              subtitle: Text(quran.getSurahNameEnglish(index + 1)),
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

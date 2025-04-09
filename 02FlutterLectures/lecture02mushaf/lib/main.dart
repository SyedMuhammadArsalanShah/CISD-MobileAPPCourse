import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SurahIndexScreen(),
    );
  }
}

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
          title: Text("مصحف",style: GoogleFonts.amiri(),),
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
          );
        },
      ),
    );
  }
}

class DetailSurah extends StatefulWidget {
  var surahNum;
  DetailSurah(this.surahNum, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text(quran.getSurahName(widget.surahNum)),
        ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(widget.surahNum),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  quran.getVerse(widget.surahNum, index + 1,
                      verseEndSymbol: true),
                  textAlign: TextAlign.right,
                  style: GoogleFonts.amiri(),
                ),
                subtitle: Text(quran.getVerseTranslation(
                    widget.surahNum, index + 1,
                    translation: quran.Translation.urdu),
                    // textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}

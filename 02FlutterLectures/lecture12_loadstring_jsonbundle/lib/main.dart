import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DuaChapters(),
    );
  }
}

class DuaChapters extends StatefulWidget {
  const DuaChapters({super.key});

  @override
  State<DuaChapters> createState() => _DuaChaptersState();
}

class _DuaChaptersState extends State<DuaChapters> {
  List listresp = [];
  loadKarenData() async {
    String response = await rootBundle.loadString("assets/duas/chapters.json");

    setState(() {
      listresp = jsonDecode(response);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadKarenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "حصن المسلم ",
            style: GoogleFonts.arefRuqaa(),
          )),
      body: ListView.builder(
        itemCount: listresp.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailDua(listresp[index]["chapter_number"]),
                  ));
            },
            leading: CircleAvatar(
              child: Text(listresp[index]["chapter_number"]),
            ),
            title: Text(
              listresp[index]["arabic_name"],
              style: GoogleFonts.amiriQuran(),
            ),
            subtitle: Text(listresp[index]["english_name"],
                style: GoogleFonts.roboto()),
          );
        },
      ),
    );
  }
}

class DetailDua extends StatefulWidget {
  String duaNum;
  DetailDua(this.duaNum, {super.key});

  @override
  State<DetailDua> createState() => _DetailDuaState();
}

class _DetailDuaState extends State<DetailDua> {
  Map mapresp = {};
  List listresp = [];
  String chapter_name = "";
  loadKarenData() async {
    String response =
        await rootBundle.loadString("assets/duas/hisn_ul_muslim.json");

// 1=>(1)

    setState(() {
      String number = "(" + widget.duaNum + ")";
      mapresp = jsonDecode(response);
      chapter_name = mapresp[number]["arabic_chapter"];
      listresp = mapresp[number]["hadiths"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadKarenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            chapter_name,
            style: GoogleFonts.arefRuqaa(),
          )),
      body: ListView.builder(
        itemCount: listresp.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              width: double.infinity,
              child: Card(
              color: Color(0xffEEEEEB),
              
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      Text(
                        listresp[index]["arabic_hadith"],
                        style: GoogleFonts.amiriQuran( color: Colors.teal[900]),
                      ),
                      Text(listresp[index]["english_hadith"],
                          style: GoogleFonts.roboto( color: Colors.teal[900])),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

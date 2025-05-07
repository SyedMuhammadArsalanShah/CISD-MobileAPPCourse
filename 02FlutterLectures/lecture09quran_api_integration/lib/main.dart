import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SurahIndexSCR(),
    );
  }
}

class SurahIndexSCR extends StatefulWidget {
  const SurahIndexSCR({super.key});

  @override
  State<SurahIndexSCR> createState() => _SurahIndexSCRState();
}

class _SurahIndexSCRState extends State<SurahIndexSCR> {
  Map mapresp = {};
  List listresp = [];
  Future apicallkardo() async {
    http.Response response =
        await http.get(Uri.parse("https://api.alquran.cloud/v1/surah"));

    if (response.statusCode == 200) {
      setState(() {
        mapresp = jsonDecode(response.body);
        listresp = mapresp["data"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicallkardo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listresp.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailSurah(listresp[index]["number"]),
                  ));
            },
            leading: CircleAvatar(
              child: Text(listresp[index]["number"].toString()),
            ),
            title: Text(listresp[index]["name"] +
                " | " +
                listresp[index]["englishName"]),
            subtitle: Text(listresp[index]["englishNameTranslation"]),
            trailing: Text(listresp[index]["numberOfAyahs"].toString()),
          );
        },
      ),
    );
  }
}

class DetailSurah extends StatefulWidget {
  var surahnum;
  DetailSurah(this.surahnum, {super.key});

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  Map mapresp = {};
  List listresp = [];
  Map map = {};
  List list = [];
  Future apicallkardo() async {
    var surahNumber = widget.surahnum;
    http.Response response = await http
        .get(Uri.parse("https://api.alquran.cloud/v1/surah/${surahNumber}"));

    if (response.statusCode == 200) {
      setState(() {
        mapresp = jsonDecode(response.body);
        listresp = mapresp["data"]["ayahs"];
      });
    }
  }

  Future apiurduTranslation() async {
    var surahNumber = widget.surahnum;
    http.Response response = await http.get(Uri.parse(
        "https://api.alquran.cloud/v1/surah/${surahNumber}/ur.maududi"));

    if (response.statusCode == 200) {
      setState(() {
        map = jsonDecode(response.body);
        list = map["data"]["ayahs"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicallkardo();
    apiurduTranslation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listresp.isNotEmpty
          ? ListView.builder(
              itemCount: listresp.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(listresp[index]["text"], textAlign: TextAlign.right,style:GoogleFonts.amiriQuran() ,),
                        Text(list[index]["text"], textAlign: TextAlign.right,style:GoogleFonts.notoNastaliqUrdu() ,)
                      ],
                    ),
               
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

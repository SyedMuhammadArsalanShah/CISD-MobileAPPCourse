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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BooksSCR(),
    );
  }
}

class BooksSCR extends StatefulWidget {
  const BooksSCR({super.key});

  @override
  State<BooksSCR> createState() => _BooksSCRState();
}

class _BooksSCRState extends State<BooksSCR> {
  Map mapbooks = {};
  List listbooks = [];
  Future apibooks() async {
    http.Response response = await http.get(Uri.parse(
        "https://hadithapi.com/api/books?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));

    if (response.statusCode == 200) {
      setState(() {
        mapbooks = jsonDecode(response.body);
        listbooks = mapbooks["books"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apibooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: listbooks.length,
            itemBuilder: (context, index) {
              var hbook = listbooks[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChaptersSCR(hbook["bookSlug"]),
                      ));
                },
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text(hbook["bookName"]),
                subtitle: Text(hbook["writerName"]),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Chapters " + hbook["chapters_count"]),
                    Text("Hadith " + hbook["hadiths_count"]),
                  ],
                ),
              );
            }));
  }
}

class ChaptersSCR extends StatefulWidget {
  var bookSlugChaiye;
  ChaptersSCR(this.bookSlugChaiye, {super.key});

  @override
  State<ChaptersSCR> createState() => _ChaptersSCRState();
}

class _ChaptersSCRState extends State<ChaptersSCR> {
  Map mapChapters = {};
  List listChapters = [];
  Future apiChapters() async {
    http.Response response = await http.get(Uri.parse(
        "https://hadithapi.com/api/${widget.bookSlugChaiye}/chapters?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));

    if (response.statusCode == 200) {
      setState(() {
        mapChapters = jsonDecode(response.body);
        listChapters = mapChapters["chapters"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: listChapters.length,
          itemBuilder: (context, index) {
            var hbook = listChapters[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HadithSCR(hbook["bookSlug"], hbook["chapterNumber"]),
                    ));
              },
              leading: CircleAvatar(
                child: Text(hbook["chapterNumber"]),
              ),
              title: Text(
                hbook["chapterArabic"],
                textAlign: TextAlign.right,
                style: GoogleFonts.amiriQuran(),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hbook["chapterUrdu"],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNastaliqUrdu(),
                  ),
                  Text(hbook["chapterEnglish"]),
                ],
              ),
            );
          }),
    );
  }
}

class HadithSCR extends StatefulWidget {
  var book;
  var chapterNumber;
  HadithSCR(this.book, this.chapterNumber, {super.key});

  @override
  State<HadithSCR> createState() => _HadithSCRState();
}

class _HadithSCRState extends State<HadithSCR> {
  Map mapHadiths = {};
  List listHadiths = [];
  Future apiHadiths() async {
    http.Response response = await http.get(Uri.parse(
        "https://hadithapi.com/public/api/hadiths?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e&book=${widget.book}&chapter=${widget.chapterNumber}&paginate=100000"));

    if (response.statusCode == 200) {
      setState(() {
        mapHadiths = jsonDecode(response.body);
        listHadiths = mapHadiths["hadiths"]["data"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiHadiths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: listHadiths.length,
          itemBuilder: (context, index) {
            var hbook = listHadiths[index];
            return Center(
              child: Card(
                child: ListTile(
                  // leading: CircleAvatar(
                  //   child: Text(hbook["hadithNumber"]),
                  // ),
                  title: Column(
                    children: [
                 CircleAvatar(
                    child: Text(hbook["hadithNumber"]),
                  ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.teal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              hbook["hadithArabic"],
                              textAlign: TextAlign.right,
                              style: GoogleFonts.amiriQuran(color: Colors.white,fontSize: 22 ),
                            ),
                          ),
                          
                        ),
                      ),
                      Text(
                    hbook["hadithUrdu"],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNastaliqUrdu(fontSize: 12),)
                    ],
                  ),
             
                  ),
                ),
              
            );
          }),
    );
  }
}

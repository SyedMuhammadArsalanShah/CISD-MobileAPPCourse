import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() => runApp(IlmiLibraryApp());

class IlmiLibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ilmi Library – اسلامی و ادبی کتابیں',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.notoNastaliqUrduTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String url;
  final String cover;
  final String category;

  Book({required this.title, required this.author, required this.url, required this.cover, required this.category});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      url: json['url'],
      cover: json['cover'],
      category: json['category'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> allBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final String jsonString = await rootBundle.loadString('assets/books.json');
    final List<dynamic> jsonData = json.decode(jsonString)['books'];
    setState(() {
      allBooks = jsonData.map((e) => Book.fromJson(e)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ilmi Library'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'اسلامی کتب'),
              Tab(text: 'اردو ناولز'),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  BookList(books: allBooks, category: 'Islamic'),
                  BookList(books: allBooks, category: 'Novel'),
                ],
              ),
      ),
    );
  }
}

class BookList extends StatelessWidget {
  final List<Book> books;
  final String category;

  BookList({required this.books, required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books.where((b) => b.category == category).toList();

    return ListView.builder(
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return ListTile(
          leading: Image.network(book.cover, width: 50, fit: BoxFit.cover),
          title: Text(book.title),
          subtitle: Text(book.author),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PDFViewerScreen(title: book.title, url: book.url),
            ),
          ),
        );
      },
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String title;
  final String url;

  PDFViewerScreen({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SfPdfViewer.network(url),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var time=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                // tileColor: Colors.teal,
                title: Text("data is here ${time.hour} : ${time.minute}"),
              ),
            ),
            Center(
              child: Card(
                shadowColor: Colors.green,
                elevation: 23,
                child: Text("current time  By Date Class"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "DateFormat by Package ${DateFormat("jms").format(time)}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.green,
            ),
            Card(
              child: ListTile(
                title: Text("Codesinsider.com"),
              ),
              elevation: 8,
              shadowColor: Colors.green,
              shape:
                  BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            Card(
              child: ListTile(
                //leading: Icon(Icons.music_note),
                title: Text("Codesinsider.com"),
              ),
              elevation: 8,
              shadowColor: Colors.green,
              margin: EdgeInsets.all(20),
            ),
        
        
                      Card(
              child: ListTile(
                title: Text("Codesinsider.com"),
              ),
              elevation: 8,
              shadowColor: Colors.green,
              margin: EdgeInsets.all(20),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.amber, width: 3)),
            ),
        
        
        
               Container(
              height: 200,
              width: 200,
              child: Card(
                child: ListTile(
                  title: Text("Codesinsider.com"),
                ),
                elevation: 28,
                shadowColor: Colors.green,
                margin: EdgeInsets.all(20),
              ),
            ),



                      Card(
            child: Container(
              height: 180,
              width: 180,
              child: Center(
                child: ListTile(
                  title: Text("Codesinsider.com"),
                ),
              ),
            ),
            elevation: 8,
            shadowColor: Colors.green,
            margin: EdgeInsets.all(20),
            shape: CircleBorder(
              side: BorderSide(width: 1, color: Colors.white),
            ),
          )
          ],
        ),
      ),
    );
  }
}

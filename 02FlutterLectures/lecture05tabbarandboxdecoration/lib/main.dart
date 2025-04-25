import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("CISD | Chat APP"),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("Status"),
                ),
                Tab(
                  child: Text("Chats"),
                ),
                Tab(
                  child: Text("Reports"),
                ),
              ],
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.teal,
              indicatorColor: Colors.teal,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: TabBarView(children: [
            Status(),
            Chats(),
            Reports(),
          ]),
        ));
  }
}

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("THis is a status screen"),
      ),
    );
  }
}

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is a Chat Screen"),
      ),
    );
  }
}

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,

          //  color: Colors.teal,
          decoration: BoxDecoration(
              // color: Colors.red
              gradient: LinearGradient(
                colors: [Color(0xff9400d3), Color(0xff4b0082)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(21),
              //     bottomRight: Radius.circular(21)),
              // borderRadius: BorderRadius.circular(21),
              boxShadow: [BoxShadow(
                blurRadius: 21,
                color: Colors.purpleAccent,
                spreadRadius: 10
                
              )],
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.deepPurpleAccent)),

            
        ),
      ),
    );
  }
}

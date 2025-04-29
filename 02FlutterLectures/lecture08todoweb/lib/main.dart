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
  var todos = ["task one", "task two"];
  var output = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo APP"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text(todos[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      meracustomWidget(index);
                    },
                    child: Icon(Icons.edit)),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                    child: Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          meracustomWidget(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void meracustomWidget(var myvalue) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Your Task"),
            content: TextField(
              onChanged: (value) {
                output = value;
              },
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (myvalue == null) {
                      setState(() {
                        todos.add(output);
                      });
                    } else {
                      setState(() {
                        todos.replaceRange(myvalue, myvalue + 1, {output});
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: myvalue==null?  Text("Add"): Text("Update"))
            ],
          );
        });
  }
}

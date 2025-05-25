import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lecture13firebase_db/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: SplashSCR(),
      // home: Home(),
    );
  }
}

class SplashSCR extends StatefulWidget {
  const SplashSCR({super.key});

  @override
  State<SplashSCR> createState() => _SplashSCRState();
}

class _SplashSCRState extends State<SplashSCR> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        final user = auth.currentUser;

        if (user != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignIn(),
              ));
        }
      },
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController emailsignup = TextEditingController();
  TextEditingController passsignup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: userName,
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextField(
              controller: emailsignup,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: passsignup,
              decoration: InputDecoration(hintText: "Pass"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  String emailS = emailsignup.text.toString();
                  String passS = passsignup.text.toString();
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailS,
                      password: passS,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Signup"))
          ],
        ),
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailsignup = TextEditingController();
  TextEditingController passsignup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailsignup,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: passsignup,
              decoration: InputDecoration(hintText: "Pass"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  String emailL = emailsignup.text.toString();
                  String passL = passsignup.text.toString();
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailL, password: passL)
                        .then(
                      (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                      },
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child: Text("SigIn"))
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref("students");

  final key = FirebaseAuth.instance.currentUser!.uid;
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home SCR"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  label: Text("Search BY Title"),
                  hintText: "Search Here ......"),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          meraModal(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void meraModal(var postid) async {
    titleController.clear();
    descController.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              32, 32, 32, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Enter Your Title"),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(hintText: "Enter Your description"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String title = titleController.text.toString();
                    String desc = descController.text.toString();
                    
                    if (postid == null) {
                      // createData(data);

                      id++;

                      databaseReference.child(key).child("$id").set({
                        "ID": id,
                        "Title": title,
                        "Description": desc,
                        "DateOfPost": DateTime.now().toString()
                      }).then(
                        (value) {
                          print("Successfully created ");
                        },
                      ).onError(
                        (error, stackTrace) {
                          print("failed task ");
                        },
                      );
                     } 
                     
                     else {
                    //   // update

                    //   databaseReference.child(key).child("$postid").update({
                    //     "ID": postid,
                    //     "Title": titleController.text,
                    //     "Description": descController.text,
                    //     "DateOfPost": DateTime.now().toString()
                    //   }).then(
                    //     (value) {
                    //       print("Successfully created ");
                    //     },
                    //   ).onError(
                    //     (error, stackTrace) {
                    //       print("failed task ");
                    //     },
                    //   );
                    }
                    Navigator.pop(context);
                  },
                  child: postid == null ? Text("Add") : Text("update"))
            ],
          ),
        );
      },
    );
  }
}

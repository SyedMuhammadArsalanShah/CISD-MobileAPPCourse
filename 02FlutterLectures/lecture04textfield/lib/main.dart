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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(width: double.infinity,
          
          color: Colors.indigo,
          height: 300,
         child: Center(child: Text("Login Screen", style: TextStyle(fontSize: 25, color: Colors.white),),),
          )
          ,Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text("Enter Your Email "),
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Colors.teal,
                ),
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info,
                      color: Colors.greenAccent,
                    )),
                enabled: false,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(14)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(14)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.circular(14)),
              ),
              controller: email,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: pass,
              keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: "#",
              decoration: InputDecoration(
                label: Text("Enter Your Password "),
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.teal,
                ),
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.greenAccent,
                    )),
                // enabled: false,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(14)),
                // disabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.grey, width: 2),
                //     borderRadius: BorderRadius.circular(14)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                String emailaddress, password;
                emailaddress = email.text.toString();
                password = pass.text.toString();

                print("Email " + emailaddress);
                print("password " + password);
              },
              child: Text("Login"))
        ],
      ),
    );
  }
}

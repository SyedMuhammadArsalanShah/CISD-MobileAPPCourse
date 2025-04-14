import 'package:flutter/material.dart';
import 'package:lecture02mushaf/AudioSurahScreen.dart';
import 'package:lecture02mushaf/SurahIndexScreen.dart';


class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioSurahScreen(),
                      ));
                },
                child: Text("Recitaion | Alafasy")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahIndexScreen(),
                      ));
                },
                child: Text("Read Quran | Mushaf")),
          ],
        ),
      ),
    );
  }
}

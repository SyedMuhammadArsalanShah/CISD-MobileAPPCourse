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
      home: HomeDateSCR(),
    );
  }
}

class HomeDateSCR extends StatefulWidget {
  const HomeDateSCR({super.key});

  @override
  State<HomeDateSCR> createState() => _HomeDateSCRState();
}

class _HomeDateSCRState extends State<HomeDateSCR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  DateTime? datepicker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2027));
                  if (datepicker != null) {
                    print("Selected ${datepicker.day}");
                  }
                },
                child: Text("Date Picker")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  TimeOfDay? timepicker = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.dial);
                  if (timepicker != null) {
                    print("Selected ${timepicker.hour}}");
                  }
                },
                child: Text("TimePicker")),
          ],
        ),
      ),
    );
  }
}

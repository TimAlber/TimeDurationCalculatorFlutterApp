import 'package:duration_picker/duration_picker.dart';
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
      title: 'Time Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Time Duration Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Duration> _durations = [];

  String formatDurationHMin(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    String result = '';
    if (hours > 0) result += '${hours.toString().padLeft(2, '0')} Stunden';
    if (minutes > 0) {
      if (result.isNotEmpty) result += ' ';
      result += '${ (hours > 0) ? 'und ' : ''}${minutes.toString().padLeft(2, '0')} Minuten';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children:
            _durations.map((duration) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatDurationHMin(duration)),
              );
            }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var resultingDuration = await showDurationPicker(
            context: context,
            initialTime: Duration(minutes: 30),
          );

          if (resultingDuration != null) {
            setState(() {
              _durations.add(resultingDuration);
            });
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Chose duration: $resultingDuration')),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

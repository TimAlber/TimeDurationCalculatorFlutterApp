import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    if (hours > 0) result += '$hours hours';
    if (minutes > 0) {
      if (result.isNotEmpty) result += ' ';
      result += '${(hours > 0) ? 'and ' : ''}$minutes minutes';
    }
    return result;
  }

  String sumUpEverything(List<Duration> durations) {
    Duration total = durations.fold(Duration.zero, (sum, item) => sum + item);
    String out = formatDurationHMin(total);
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _durations.length,
              itemBuilder: (context, index) {
                if(index == _durations.length - 1){
                  return Column(
                    children: [
                      Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            _durations.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Text(formatDurationHMin(_durations[index])),
                        ),
                      ),
                      ListTile(
                        title: Text("In Total: ${sumUpEverything(_durations)}"),
                      )
                    ],
                  );
                }

                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      _durations.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(formatDurationHMin(_durations[index])),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var resultingDuration = await showDurationPicker(
            context: context,
            initialTime: Duration(minutes: 30),
          );

          if (resultingDuration != null && resultingDuration > Duration.zero) {
            setState(() {
              _durations.add(resultingDuration);
            });
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

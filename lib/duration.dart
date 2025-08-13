import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class MyDurationPage extends StatefulWidget {
  const MyDurationPage({super.key});

  @override
  State<MyDurationPage> createState() => _MyDurationPageState();
}

class _MyDurationPageState extends State<MyDurationPage> {
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class MyDifferencePage extends StatefulWidget {
  const MyDifferencePage({super.key});

  @override
  State<MyDifferencePage> createState() => _DifferenceCalculatorState();
}

class _DifferenceCalculatorState extends State<MyDifferencePage> {
  DateTime? selectedFirstDateTime;
  DateTime? selectedSecondDateTime;

  String formatDurationAsHMS(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours Hours, $minutes Minutes and $seconds Seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  is24HourMode: true,
                );
                if (dateTime != null) {
                  setState(() {
                    selectedFirstDateTime = dateTime;
                  });
                }
              },
              child: const Text('Pick First Date & Time'),
            ),
            Text(
              selectedFirstDateTime != null
                  ? DateFormat('dd.MM.yyyy kk:mm').format(selectedFirstDateTime!)
                  : 'No date selected',
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  is24HourMode: true,
                );
                if (dateTime != null) {
                  setState(() {
                    selectedSecondDateTime = dateTime;
                  });
                }
              },
              child: const Text('Pick Second Date & Time'),
            ),
            Text(
              selectedSecondDateTime != null
                  ? DateFormat('dd.MM.yyyy kk:mm').format(selectedSecondDateTime!)
                  : 'No date selected',
            ),
            const SizedBox(height: 50),
            Text("Time difference: "),
            if (selectedSecondDateTime != null && selectedFirstDateTime != null)
            Visibility(
              visible: !selectedSecondDateTime!.difference(selectedFirstDateTime!).isNegative,
              replacement: Text("Second Date is before the first."),
              child: Text(
                selectedSecondDateTime != null && selectedFirstDateTime != null
                    ? formatDurationAsHMS(selectedSecondDateTime!.difference(selectedFirstDateTime!))
                    : 'No date selected',
              ),
            )
          ],
        ),
      ),
    );
  }
}

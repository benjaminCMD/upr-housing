import 'dart:io';

class TestTimer {
  final String label;
  final List<int> _runs = [];
  int _failures = 0;

  TestTimer(this.label);

  Future<T?> run<T>(Future<T> Function() action, {bool printToConsole = true}) async {
     final stopwatch = Stopwatch()..start();
    try {
      T result = await action();
      stopwatch.stop();

      int time = stopwatch.elapsedMilliseconds;
      _runs.add(time);

      if (printToConsole) {
        print('$label ✅ Run #${_runs.length}: ${time}ms');
      }

      return result;
    } catch (e) {
      stopwatch.stop();
      _failures++;

      if (printToConsole) {
        print('$label ❌ Run #${_runs.length + _failures} failed: $e');
      }

      return null; // You can also rethrow if you want the test to fail
    }
  }

  double get averageTime {
    if (_runs.isEmpty) return 0;
    return _runs.reduce((a, b) => a + b) / _runs.length;
  }

  void printSummary() {
     final successCount = _runs.length;
  final total = successCount + _failures;
  print('⏱️ $label - $total runs: $successCount succeeded, $_failures failed.');
  if (successCount > 0) {
    print('Average: ${averageTime.toStringAsFixed(2)}ms');
  }
  }

  // void writeToFile(String path) {
  // final file = File(path);
  // final buffer = StringBuffer()
  //   ..writeln('Performance Summary for $label')
  //   ..writeln('Total Runs: ${_runs.length + _failures}')
  //   ..writeln('Successful: ${_runs.length}')
  //   ..writeln('Failed: $_failures')
  //   ..writeln('Times: ${_runs.join(', ')}');
  // if (_runs.isNotEmpty) {
  //   buffer.writeln('Average: ${averageTime.toStringAsFixed(2)} ms');
  // }
  // file.writeAsStringSync(buffer.toString());
  // }

  void printSummaryAndCopy() {
  final buffer = StringBuffer()
    ..writeln('Performance Summary for $label')
    ..writeln('Total Runs: ${_runs.length + _failures}')
    ..writeln('Successful: ${_runs.length}')
    ..writeln('Failed: $_failures')
    ..writeln('Times: ${_runs.join(', ')}');

  if (_runs.isNotEmpty) {
    buffer.writeln('Average: ${averageTime.toStringAsFixed(2)} ms');
  }

  print(buffer.toString()); // 📋 You can copy from terminal
}
}

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class Loggers {
  // ignore: prefer_function_declarations_over_variables
  static final logger = (Type type) => Logger(
        printer: LogsFormat(type.toString()),
        level: Level.verbose,
      );

  static Future<void> printLog(
      Type className, String logType, dynamic message) async {
    var now = DateTime.now();
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var formattedDate = dateFormat.format(now);
    var logMessage = '[$logType]  $className : $message\n';

    // Save logs to file
    var logsDirectory = await getApplicationDocumentsDirectory();
    var logsPath = logsDirectory.path;

    var logFile = File('$logsPath/logs_$logType.txt');
    await logFile.writeAsString('$formattedDate $logMessage',
        mode: FileMode.append);

    // Delete logs that are older than 10 days
    var logs = await logFile.readAsLines();
    var tenDaysAgo = now.subtract(const Duration(days: 10));
    var filteredLogs = logs.where((log) {
      var logDate = dateFormat.parse(log.substring(0, 19));
      return logDate.isAfter(tenDaysAgo);
    }).toList();
    var lastLogMessage = filteredLogs.last;
    filteredLogs[filteredLogs.length - 1] = '$lastLogMessage\n';

    await logFile.writeAsString(filteredLogs.join('\n'), mode: FileMode.write);

    // Print logs to console
    switch (logType) {
      case 'DEBUG':
        logger(className).d(logMessage);
        break;
      case 'INFO':
        logger(className).i(logMessage);
        break;
      case 'WARNING':
        logger(className).w(logMessage);
        break;
      case 'ERROR':
        logger(className).e(logMessage);
        break;
      default:
        logger(className).v(logMessage);
        break;
    }
  }
}

class LogsFormat extends LogPrinter {
  final String className;

  LogsFormat(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final message = event.message;
    return [color!('$emoji $message')];
  }
}

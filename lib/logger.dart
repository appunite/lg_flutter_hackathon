import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final Map<int, String> _typeNameMap = {};

abstract class Reporter {
  void initialize();
}

String _formatLogMessage(LogRecord record) => '${record.time} - ${record.loggerName}'
    ' - ${record.level.name}: ${record.message}';

String _formatErrorMessage(LogRecord record) => '${record.time} - ${record.loggerName}'
    ' - ${record.level.name}: ${record.message}\n'
    'Exception: ${record.error}\n'
    '${record.stackTrace != null ? "Stack Trace:\n${record.stackTrace}" : ""}';

class DebugReporter implements Reporter {
  @override
  void initialize() {
    _addLoggerListener();
  }

  void _addLoggerListener() {
    Logger.root.onRecord.where((r) => r.level <= Level.INFO).listen(_printLog);
    Logger.root.onRecord.where((r) => r.level >= Level.WARNING).listen(_printError);
  }

  void _printLog(LogRecord record) {
    debugPrint(_formatLogMessage(record));
  }

  void _printError(LogRecord record) {
    debugPrint(_formatErrorMessage(record));
  }
}

mixin ReporterMixin {
  Logger? _logger;

  Logger get logger => _ensureLogger();

  Logger _ensureLogger([String? customName]) {
    final name = customName ??
        _typeNameMap[runtimeType.hashCode] ??
        (_typeNameMap[runtimeType.hashCode] = runtimeType.toString());
    return _logger ??= Logger(name);
  }

  void verbose(String message, [String? customName]) {
    _ensureLogger(customName).finer(message);
  }

  void debug(String message, [String? customName]) {
    if (kDebugMode) {
      _ensureLogger(customName).fine(message);
    }
  }

  void info(String message, [String? customName]) {
    _ensureLogger(customName).info(message);
  }

  void logWarning(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    String? customName,
  ]) {
    _ensureLogger(customName).warning(message, error, stackTrace);
  }

  void logError(
    dynamic ex,
    StackTrace? st, {
    String? message,
    String? customName,
  }) {
    _ensureLogger(customName).severe(message, ex, st);
  }

  void reportError(
    dynamic ex,
    StackTrace? st, {
    String? message,
    String? customName,
  }) {
    _ensureLogger(customName).shout(message, ex, st);
  }

  T? logException<T>(
    T Function() block, {
    bool rethrowIt = true,
    String? message,
  }) {
    try {
      return block();
    } catch (e, st) {
      logError(e, st, message: message);
      if (rethrowIt) rethrow;
    }
    return null;
  }

  Future<T?> logAsyncException<T>(
    Future<T> block, {
    bool rethrowIt = true,
    String? message,
  }) async {
    try {
      final ret = await block;
      return ret;
    } catch (e, st) {
      logError(e, st, message: message);
      if (rethrowIt) rethrow;
    }
    return null;
  }

  Future<T?> reportAsyncException<T>(
    Future<T> block, {
    bool rethrowIt = true,
    String? message,
  }) async {
    try {
      final ret = await block;
      return ret;
    } catch (e, st) {
      reportError(e, st, message: message);
      if (rethrowIt) rethrow;
    }
    return null;
  }
}

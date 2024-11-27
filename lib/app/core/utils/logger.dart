import 'dart:developer' as developer;
import 'dart:convert';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DPLogCollector {
  static final List<String> _logs = [];
  static bool _isInitialized = false;
  static String? _axiomApiToken;
  static String? _axiomDatasetName;
  static String? _deviceName;

  static void initialize({
    required String axiomApiToken,
    required String axiomDatasetName,
  }) {
    if (_isInitialized) return;

    _axiomApiToken = axiomApiToken;
    _axiomDatasetName = axiomDatasetName;

    try {
      _deviceName = Get.find<AuthService>().name;
    } catch (e) {
      developer.log('Failed to get device name: $e', name: 'INIT_ERROR');
      _deviceName = 'unknown_device';
    }

    debugPrint = (String? message, {int? wrapWidth}) {
      final logEntry = _createLogEntry('DEBUG', message ?? '');
      _logs.add(logEntry);
      _sendToAxiom(logEntry);
      developer.log(message ?? '', name: 'DEBUG');
    };

    FlutterError.onError = (FlutterErrorDetails details) {
      final logEntry =
      _createLogEntry('ERROR', '${details.exception}\n${details.stack}');
      _logs.add(logEntry);
      _sendToAxiom(logEntry);
      FlutterError.presentError(details);
    };

    Get.log = (String message, {bool isError = false}) {
      final logEntry = _createLogEntry('GETX', message);
      _logs.add(logEntry);
      _sendToAxiom(logEntry);
      developer.log(message, name: 'GETX');
    };

    _isInitialized = true;
  }

  static String _createLogEntry(String type, String message) {
    return '[$type]: $message';
  }

  static Future<void> _sendToAxiom(String logEntry) async {
    if (_axiomApiToken == null || _axiomDatasetName == null) return;

    try {
      final uri = Uri.parse(
          'https://api.axiom.co/v1/datasets/$_axiomDatasetName/ingest');

      final Map<String, dynamic> logData = {
        'source': 'kiosk',
        'deviceName': _deviceName ?? 'unknown_device',
        'msg': logEntry,
        '_time': DateTime.now().millisecondsSinceEpoch,
      };

      await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $_axiomApiToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode([logData]),
      );
    } catch (e) {
      developer.log('Failed to send log to Axiom: $e', name: 'AXIOM_ERROR');
    }
  }

  static List<String> getLogs() => List.from(_logs);

  static String exportLogs() => _logs.join('\n');

  static List<String> filterLogs(String keyword) =>
      _logs.where((log) => log.contains(keyword)).toList();

  static List<String> getGetXLogs() => filterLogs('GETX');

  static void clearLogs() => _logs.clear();

  static void addCustomLog(String message, {String type = 'INFO'}) {
    final logEntry = _createLogEntry(type, message);
    _logs.add(logEntry);
    _sendToAxiom(logEntry);
  }
}
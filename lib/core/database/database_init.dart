import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

Future<void> initDatabase() async {
  // Initialize FFI for Windows, Linux, and macOS
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows ||
                  defaultTargetPlatform == TargetPlatform.linux ||
                  defaultTargetPlatform == TargetPlatform.macOS)) {
    databaseFactory = databaseFactoryFfi;
  }
}
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createLEClient();

  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    if (!kIsWeb) {
      _clientInstance = await _instance;
    }
  }

  static Future<http.Client> createLEClient() async {
    final context = SecurityContext(withTrustedRoots: false);
    
    try {
      // Untuk testing, kita skip loading certificate jika dalam test environment
      if (!kIsWeb && !kTestMode) {
        final bytes = (await rootBundle.load('assets/certificates/themoviedb.pem'))
            .buffer
            .asUint8List();
        context.setTrustedCertificatesBytes(bytes);
      }
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        print('Certificate already trusted');
      } else {
        print('Error setting up certificate: ${e.message}');
        rethrow;
      }
    } catch (e) {
      print('Unexpected error setting up certificate: $e');
      rethrow;
    }

    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    
    return IOClient(httpClient);
  }
}

// Flag untuk menunjukkan apakah kode berjalan dalam test environment
bool kTestMode = false;
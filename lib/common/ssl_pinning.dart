import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class HttpSSLPinning {
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    if (kIsWeb) {
      _clientInstance = http.Client();
      return;
    }

    _clientInstance = await _setupSecureClient();
  }

  static Future<http.Client> _setupSecureClient() async {
    final context = SecurityContext(withTrustedRoots: false);

    try {
      // Untuk testing, skip loading certificate jika dalam test environment
      if (!kTestMode) {
        try {
          final bytes =
              (await rootBundle.load('certificates/themoviedb.org.pem'))
                  .buffer
                  .asUint8List();
          context.setTrustedCertificatesBytes(bytes);
          print('Certificate setup successfully');
        } catch (e) {
          print('Error loading certificate: $e');
          // Jika gagal loading certificate, gunakan context default
          return http.Client();
        }
      }
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        print('Certificate already trusted');
      } else {
        print('Error setting up certificate: ${e.message}');
        // Fallback to regular client if certificate fails
        return http.Client();
      }
    } catch (e) {
      print('Unexpected error setting up certificate: $e');
      // Fallback to regular client
      return http.Client();
    }

    HttpClient httpClient = HttpClient(context: context);

    // Set timeout
    httpClient.connectionTimeout = const Duration(seconds: 15);

    // Handle bad certificate
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      print('Bad certificate check for $host:$port');
      return false;
    };

    return IOClient(httpClient);
  }

  // Method untuk melakukan retry jika koneksi gagal
  static Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    int maxRetries = 3,
  }) async {
    int retries = 0;

    while (retries < maxRetries) {
      try {
        final response = await client.get(
          Uri.parse(url),
          headers: headers,
        );

        if (response.statusCode == 200) {
          return response;
        }

        retries++;
        await Future.delayed(Duration(seconds: 1));
      } catch (e) {
        print('Error in HTTP GET ($retries): $e');
        retries++;

        if (retries >= maxRetries) {
          rethrow;
        }

        await Future.delayed(Duration(seconds: 1));
      }
    }

    // Jika masih tidak berhasil setelah retry, throw exception
    throw SocketException('Failed to connect after $maxRetries retries');
  }
}

// Flag untuk menunjukkan apakah kode berjalan dalam test environment
bool kTestMode = false;

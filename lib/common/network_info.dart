import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final String lookupAddress;
  
  NetworkInfoImpl({this.lookupAddress = 'google.com'});
  
  @override
  Future<bool> get isConnected async {
    try {
      // Lookup DNS to check internet connection
      final result = await InternetAddress.lookup(lookupAddress);
      
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}

// Add this to injection.dart
// locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class IOHttpClient {
  static http.Client? _clientInstance;

  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createIOClient();

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<HttpClient> getHttpClient() async {
    final sslCert = await rootBundle.load('certificates/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return client;
  }

  static Future<http.Client> createIOClient() async {
    IOClient client = IOClient(await getHttpClient());
    return client;
  }
}

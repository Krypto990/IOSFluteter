import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'scan_result_screen.dart';

class URLInputScreen extends StatefulWidget {
  @override
  _URLInputScreenState createState() => _URLInputScreenState();
}

class _URLInputScreenState extends State<URLInputScreen> {
  final TextEditingController _urlController = TextEditingController();
  QRViewController? qrViewController;

  void _scanUrl() async {
    final url = _urlController.text;
    if (url.isNotEmpty) {
      final cleanedUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
      final requestUrl = 'https://api.metadefender.com/v4/url/${Uri.encodeComponent(cleanedUrl)}';

      print('URL de solicitud: $requestUrl');

      try {
        final response = await http.get(
          Uri.parse(requestUrl),
          headers: {
            'apikey': 'd433dedd460635b440feb3dd0645a839',
          },
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);

          print('Respuesta completa: $result');

          // Verifica el valor de detected_by
          int detectedBy = result['lookup_results']['detected_by'] ?? 0;
          String scanStatus = detectedBy == 0 ? 'safe' : 'threat';

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanResultScreen(result: {
                'status': scanStatus,
                'scan_all_result_a': result['lookup_results']['sources']?.map((source) => source['provider'] ?? 'N/A')?.join(', ') ?? 'N/A',
              }),
            ),
          );
        } else {
          print('Error al escanear la URL: ${response.statusCode}');
        }
      } catch (e) {
        print('Error en la solicitud: $e');
      }
    }
  }

  void _scanQRCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Escanear QR')),
          body: QRView(
            key: GlobalKey(debugLabel: 'qr'),
            onQRViewCreated: (QRViewController controller) {
              qrViewController = controller;
              controller.scannedDataStream.listen((scanData) {
                controller.dispose();
                Navigator.pop(context);
                if (scanData.code != null && scanData.code!.isNotEmpty) {
                  _scanUrlFromQRCode(scanData.code!);
                }
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> _scanUrlFromQRCode(String qrCode) async {
    final url = qrCode;
    if (url.isNotEmpty) {
      final cleanedUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
      final requestUrl = 'https://api.metadefender.com/v4/url/${Uri.encodeComponent(cleanedUrl)}';

      print('URL de solicitud desde QR: $requestUrl');

      try {
        final response = await http.get(
          Uri.parse(requestUrl),
          headers: {
            'apikey': 'd433dedd460635b440feb3dd0645a839',
          },
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);

          print('Respuesta completa desde QR: $result');

          // Verifica el valor de detected_by
          int detectedBy = result['lookup_results']['detected_by'] ?? 0;
          String scanStatus = detectedBy == 0 ? 'safe' : 'threat';

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanResultScreen(result: {
                'status': scanStatus,
                'scan_all_result_a': result['lookup_results']['sources']?.map((source) => source['provider'] ?? 'N/A')?.join(', ') ?? 'N/A',
              }),
            ),
          );
        } else {
          print('Error al escanear la URL desde QR: ${response.statusCode}');
        }
      } catch (e) {
        print('Error en la solicitud desde QR: $e');
      }
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/newAssets/VerificApp_Back2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/newAssets/VerificApp_elementos_SSPMC_barra.png',
                        width: double.infinity,
                        height: 85,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/newAssets/VerificApp_elementos_corregidora.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/newAssets/VerificApp_elementos_estrella.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Para asegurar la seguridad de tu navegación, por favor ingresa una URL en el campo correspondiente y presiona "Escanear". Si prefieres escanear un código QR, toca el ícono de la cámara. Esta aplicación verifica la URL o el código QR para identificar posibles riesgos.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: _urlController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ingrese URL',
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _scanUrl,
                        child: Text('Escanear'),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: _scanQRCode,
                        child: Image.asset(
                          'assets/newAssets/QrReal.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 100), // Espacio para que la imagen se coloque en la parte inferior
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/newAssets/VerificApp_pantallas-15.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

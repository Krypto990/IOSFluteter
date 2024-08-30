import 'dart:convert';
import 'package:http/http.dart' as http;
import 'database_helper.dart';

// URL del servidor
const String baseUrl = 'http://201.144.47.184:3000/save-url-data';

Future<void> saveUrlData({
  required String date,
  required String url,
  required String result,
}) async {
  final dbHelper = DatabaseHelper();

  // Construye el cuerpo de la solicitud
  final Map<String, dynamic> body = {
    'date': date,
    'url': url,
    'y': result,
  };

  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Datos enviados correctamente');
    } else {
      print('Error al enviar datos: ${response.statusCode}');
      // Guarda los datos localmente si el servidor está fuera de línea
      await dbHelper.insertUrlData(date: date, url: url, result: result);
    }
  } catch (e) {
    print('Error al enviar datos: $e');
    // Guarda los datos localmente si ocurre una excepción
    await dbHelper.insertUrlData(date: date, url: url, result: result);
  }
}

Future<void> syncLocalData() async {
  final dbHelper = DatabaseHelper();
  final localData = await dbHelper.getUrlData();

  for (var data in localData) {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'date': data['date'],
        'url': data['url'],
        'y': data['result'],
      }),
    );

    if (response.statusCode == 200) {
      // Si la sincronización es exitosa, elimina los datos locales
      await dbHelper.deleteUrlData(data['id']);
    }
  }
}


import 'dart:convert'; // Importa el paquete para trabajar con JSON
import 'package:http/http.dart' as http; // Importa el paquete http para realizar solicitudes HTTP

// Define una función asíncrona que escanea una URL
Future<String> scanUrl(String url) async {
  // Realiza una solicitud POST a la API de Metadefender
  final response = await http.post(
    Uri.parse('https://api.metadefender.com/v4/url/'), // URL de la API
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8', // Especifica el tipo de contenido como JSON
      'apikey': 'd433dedd460635b440feb3dd0645a839', // Clave de API para autenticar la solicitud
    },
    body: jsonEncode(<String, String>{ // Codifica el cuerpo de la solicitud como JSON
      'url': url, // La URL a escanear
    }),
  );

  // Verifica si la solicitud fue exitosa
  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body); // Decodifica la respuesta de la API
    // Retorna el estado del escaneo de la URL
    return responseBody['data']['scan_results']['scan_all']['status'];
  } else {
    // Lanza una excepción si la solicitud falló
    throw Exception('Error al escanear la URL');
  }
}

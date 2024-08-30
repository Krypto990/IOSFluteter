import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Imagen de fondo
          Image.asset(
            'assets/newAssets/VerificApp_Back2.png',
            fit: BoxFit.cover,
          ),
          // Contenido de la política de privacidad centrado y justificado
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  'Política de Privacidad\n\n'
                  'Tu privacidad es importante para nosotros. Esta aplicación no recopila ninguna información personal sobre ti. '
                  'El único propósito del acceso a la cámara es para escanear códigos QR. Los datos de los códigos QR se utilizan exclusivamente para '
                  'analizar la información y proporcionar resultados de seguridad. No almacenamos, compartimos ni utilizamos tus datos para ningún otro fin.\n\n'
                  'Si tienes alguna pregunta sobre nuestra política de privacidad, no dudes en contactarnos.',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 0, 0, 0), // Color del texto blanco para contrastar con el fondo
                  ),
                  textAlign: TextAlign.justify, // Justifica el texto
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

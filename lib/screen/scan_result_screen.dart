import 'package:flutter/material.dart';

class ScanResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  ScanResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    // Determina qué imagen mostrar basado en el estado
    bool isSafe = result['status'] == 'safe';
    String imageAsset = isSafe ? 'assets/newAssets/VerificApp_pantallas_VERDADERO.jpg' : 'assets/newAssets/VerificApp_pantallas_FALSO.jpg';

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Regresa a la pantalla anterior al tocar la pantalla
        },
        child: Image.asset(
          imageAsset,
          fit: BoxFit.fill, // Ajusta la imagen para cubrir todo el área disponible
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'privacy_policy_screen.dart'; // Asegúrate de que esta importación sea correcta
import 'url_input_screen.dart'; // Importa la pantalla URLInputScreen para navegar a ella desde la pantalla principal
import 'info_screen.dart'; // Importa la pantalla InfoScreen para navegar a ella desde la pantalla principal

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/newAssets/VerificApp_Back2.png', // Ruta correcta a la imagen de fondo
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Image.asset(
                  'assets/newAssets/VerificApp_elementos_SSPMC_barra.png', // Ruta correcta a la imagen rectangular
                  width: double.infinity,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(
                      'assets/newAssets/VerificApp_elementos_corregidora.png', // Ruta correcta a la imagen de la izquierda
                      width: 100,
                    ),
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/newAssets/VerificApp_elementos_estrella.png', // Ruta correcta a la imagen de la derecha
                      width: 100,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '¡Hola! Descubre cómo protegerte con la app de Seguridad Pública de Corregidora. Prevención de delitos cibernéticos al alcance de tu mano.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 6, 14, 89),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => URLInputScreen()),
                        );
                      },
                      child: Text('Escanear URL'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 6, 14, 89),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InfoScreen()),
                        );
                      },
                      child: Text('Información'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(Icons.privacy_tip),
                color: const Color.fromARGB(255, 214, 136, 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

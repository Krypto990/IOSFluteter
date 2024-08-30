import 'package:flutter/material.dart'; // Importa el paquete de Flutter para crear interfaces de usuario

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // Lista de imágenes para el slider
  final List<String> imgList = [
    'assets/newAssets/VerificApp_pantallas_Pharming.jpg', // Imagen 1
    'assets/newAssets/VerificApp_pantallas_Phishing.jpg', // Imagen 2
    'assets/newAssets/VerificApp_pantallas_Smishing.jpg', // Imagen 3
    'assets/newAssets/VerificApp_pantallas_SPAM.jpg', // Imagen 4
  ];

  int _currentPage = 0; // Para rastrear la página actual del PageView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Imagen de fondo
          Image.asset(
            'assets/newAssets/VerificApp_Back2.png', // Ruta a la imagen de fondo
            fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el fondo
          ),
          // Contenido de la pantalla
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Imagen rectangular superior con un margen superior
                Padding(
                  padding: const EdgeInsets.only(top: 20.0), // Margen superior
                  child: Image.asset(
                    'assets/newAssets/VerificApp_elementos_SSPMC_barra.png', // Ruta a la imagen rectangular
                    width: double.infinity, // Ancho total de la pantalla
                    height: 80, // Altura de la imagen
                    fit: BoxFit.cover, // Ajusta la imagen para cubrir el ancho
                  ),
                ),
                // Logos debajo de la imagen rectangular
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0), // Margen vertical
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribuye los logos uniformemente
                    children: <Widget>[
                      Image.asset(
                        'assets/newAssets/VerificApp_elementos_corregidora.png', // Ruta del primer logo
                        width: 100, // Ancho del logo
                      ),
                      SizedBox(width: 20), // Espacio entre los logos
                      Image.asset(
                        'assets/newAssets/VerificApp_elementos_estrella.png', // Ruta del segundo logo
                        width: 100, // Ancho del logo
                      ),
                    ],
                  ),
                ),
                // PageView de imágenes con indicadores
                Container(
                  height: 500.0, // Altura del PageView
                  child: PageView.builder(
                    itemCount: imgList.length, // Número de páginas (imágenes)
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index; // Actualiza el índice de la página actual
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        child: Center(
                          child: Image.asset(
                            imgList[index], // Ruta de la imagen en el PageView
                            fit: BoxFit.contain, // Ajusta la imagen para que se muestre completa
                            width: MediaQuery.of(context).size.width, // Ancho ajustado al tamaño de la pantalla
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Indicadores de página
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((url) {
                    int index = imgList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.blueAccent
                            : Colors.grey, // Color del indicador según la página actual
                      ),
                    );
                  }).toList(),
                ),
                // Imagen debajo del PageView
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0), // Margen vertical
                  child: Image.asset(
                    'assets/newAssets/VerificApp_pantallas-14.png', // Ruta de la imagen
                    width: 300, // Ancho de la imagen
                    height: 300, // Altura de la imagen
                  ),
                ),
                // Texto centrado y justificado
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Margen horizontal
                  child: Text(
                    'Tu tranquilidad y la de tu familia es primero', // Texto
                    textAlign: TextAlign.center, // Centra el texto
                    style: TextStyle(
                      fontSize: 18, // Tamaño de la fuente
                      color: Colors.black, // Color del texto
                      fontWeight: FontWeight.bold, // Negrita
                    ),
                  ),
                ),
                SizedBox(height: 10), // Espacio entre el texto y la siguiente imagen
                // Imagen rectangular al final
                Image.asset(
                  'assets/newAssets/VerificApp_pantallas-15.png', // Ruta de la imagen
                  width: double.infinity, // Ancho total de la pantalla
                  height: 85, // Altura de la imagen
                  fit: BoxFit.cover, // Ajusta la imagen para cubrir el ancho
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

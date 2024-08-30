import 'package:flutter/material.dart';
import 'package:linkseguro/screen/home_screen.dart';
import 'server.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VerificApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity, // Ajusta la densidad visual para diferentes plataformas
      ),
      home: FutureBuilder<void>(
        future: _initializeApp(), // Llama a la función de inicialización asíncrona
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error al sincronizar los datos: ${snapshot.error}'),
                ),
              );
            } else {
              return HomeScreen();
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(), // Muestra un indicador de carga mientras se inicializa
              ),
            );
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> _initializeApp() async {
    try {
      await syncLocalData(); // Sincroniza los datos locales con el servidor
    } catch (e) {
      // Maneja errores de sincronización
      print('Error durante la sincronización: $e');
      rethrow; // Lanza el error para que FutureBuilder pueda manejarlo
    }
  }
}

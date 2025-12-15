import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/slow_image.dart';
// intentional: StripedErrorWidget is used by SlowImage internally
import 'plugin_examples_screen.dart';

class BadHomeScreen extends StatelessWidget {
  const BadHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App Fea y Lenta",
          style: TextStyle(
            fontFamily: "Comic Sans MS", // Si existe, si no usa default fea
            fontSize: 30,
            color: Colors.red,
            fontWeight: FontWeight.w100, // Finito y feo
          ),
        ),
        backgroundColor: Colors.yellowAccent, // Dolor de ojos
        actions: [
          IconButton(
            tooltip: 'Ejemplos (plugins)',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PluginExamplesScreen()),
              );
            },
            icon: const Icon(Icons.extension),
          ),
        ],
      ),
      backgroundColor: Colors.pink[100],
      body: ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) {
          // BLOQUEO: Operación síncrona pesada para trabar el UI thread
          // Esto hará que el scroll se sienta "trabisca" o con "jank"
          _expensiveOperation();

          // URLs de imágenes pesadas y algunas rotas
          final String imageUrl = index % 3 == 0
              ? "https://images.unsplash.com/photo-1472214103451-9374bd1c798e?fix=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTcxNzc4NzAyNA&ixlib=rb-4.0.3&q=80&w=1080&v=${index}"
              : index % 3 == 1
              ? "https://via.placeholder.com/3000"
              : "https://este-dominio-no-existe.com/imagen.jpg";

          return Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Parseo ineficiente de texto cada frame
                  _inefficientTextParsing("Elemento de lista feo #$index"),
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                // OVERFLOW: Row sin Flexible/Expanded con texto largo
                Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.yellow),
                    const Text(
                      "Este texto es demasiado largo para caber en la pantalla y causará un error de renderizado (rayas amarillas) porque no estamos usando Flexible o Expanded.",
                      style: TextStyle(backgroundColor: Colors.amber),
                    ),
                  ],
                ),

                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: SlowImage(imageUrl, fit: BoxFit.fill),
                ),
                const Text(
                  "Descripción larga y sin fuente bonita para que se vea aburrido. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a otra pantalla fea
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BadDetailScreen()),
          );
        },
        backgroundColor: Colors.green, // Color que no combina
        child: const Icon(Icons.broken_image),
      ),
    );
  }
}

class BadDetailScreen extends StatelessWidget {
  const BadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle Pixelado")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "IMAGEN PIXELADA (Hacer zoom mental)",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Imagen pequeña estirada para pixelarse (sin cache, lenta)
            SlowImage(
              "https://via.placeholder.com/50",
              width: 400,
              height: 400,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            const Text("ICONOS FEOS (No SVG)"),
            // Usamos un icono de baja calidad rasterizado si tuviéramos un asset,
            // pero como no tenemos assets locales, usaremos un icono de red pequeño estirado.
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/25/25231.png", // PNG de GitHub (ejemplo)
              width: 200,
              height: 200,
              filterQuality: FilterQuality.low, // Se ve borroso o pixelado
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Aquí deberían usar Google Fonts para arreglar este desastre. Y Flutter SVG para que los iconos no se vean borrosos al escalar.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontFamily: "Courier"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simulamos carga de CPU
void _expensiveOperation() {
  // Un loop tonto que gasta milisegundos
  double result = 0.0;
  for (int i = 0; i < 200000; i++) {
    result += sqrt(i.toDouble()) * sin(i.toDouble());
  }
  // No hacemos nada con result, pero el CPU ya sufrió
}

// Parseo ineficiente con Regex compilado al vuelo
String _inefficientTextParsing(String input) {
  // Intencionalmente ineficiente: compilar regex cada vez
  final regex = RegExp(r'[aeiou]');
  return input.replaceAllMapped(regex, (match) {
    return match.group(0)!.toUpperCase();
  });
}

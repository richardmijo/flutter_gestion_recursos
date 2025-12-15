import 'package:flutter/material.dart';
import '../widgets/slow_image.dart';

/// Pantalla con ejemplos donde los alumnos deben mejorar usando:
/// - cached_network_image
/// - flutter_svg
/// - google_fonts
/// - shimmer
/// NO se agregan dependencias: los alumnos deberán instalarlas y reemplazar los widgets.
class PluginExamplesScreen extends StatelessWidget {
  const PluginExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplos (mejoras pendientes)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '1) Caching de imágenes (cached_network_image)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Hoy usamos Image.network sin cache. Reemplaza por CachedNetworkImage y muestra placeholder + cache.',
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: SlowImage('https://via.placeholder.com/800'),
          ),

          const Divider(),

          const Text(
            '2) SVG (flutter_svg)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aquí intentamos cargar un SVG con Image.network (fallará). Usa flutter_svg y SvgPicture.network.',
          ),
          const SizedBox(height: 8),
          // Cargar SVG con Image.network provoca error o se renderiza mal
          SizedBox(
            height: 120,
            child: Image.network(
              'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/acid.svg',
              errorBuilder: (c, e, s) => Container(
                color: Colors.yellow,
                child: const Center(child: Text('ERROR: SVG no manejado')),
              ),
            ),
          ),

          const Divider(),

          const Text(
            '3) Fuentes (google_fonts)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Usamos fuentes del sistema y un estilo horrible. Reemplaza con GoogleFonts para tipografía legible.',
          ),
          const SizedBox(height: 8),
          const Text(
            'Este texto debería usar Google Fonts para mejor legibilidad',
            style: TextStyle(fontSize: 20, fontFamily: 'Times New Roman'),
          ),

          const Divider(),

          const Text(
            '4) Shimmer (placeholders)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aquí hay un placeholder estático. Reemplaza por Shimmer para dar feedback visual.',
          ),
          const SizedBox(height: 8),
          Container(
            height: 100,
            color: Colors.grey.shade300,
            child: const Center(child: Text('PLACEHOLDER ESTÁTICO')),
          ),

          const Divider(),

          const Text(
            '5) Layout Rotos (RenderFlex Overflow)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Rayas amarillas y negras aparecen cuando el contenido no cabe. Arregla usando Flexible, Expanded o Scroll.',
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.grey[200],
            height: 100,
            child: Row(
              children: [
                const Icon(Icons.error),
                const Text(
                  " TEXTO LARGO DE EJEMPLO QUE NO VA A ENTRAR EN LA PANTALLA Y VA A ROMPER TODO EL LAYOUT CON RAYAS AMARILLAS Y NEGRAS SI NO SE ARREGLA",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 50,
            color: Colors.blue[100],
            child: Column(
              children: [
                const Text("Columna 1"),
                const Text("Columna 2"),
                const Text("Columna 3 - Ups no entro"),
                const Text("Columna 4 - Overflow vertical"),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            '''TODO para alumnos:
 - Agregar dependencias en pubspec.yaml
 - Reemplazar SlowImage por CachedNetworkImage y comparar tiempos
 - Reemplazar Image.network con SvgPicture.network para SVG
 - Usar GoogleFonts para textos
 - Usar Shimmer para placeholders
 - Arreglar overflows con Flexible/Expanded''',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'striped_error.dart';

/// Widget deliberadamente lento y sin cache para practicar mejoras.
class SlowImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SlowImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
  });

  @override
  State<SlowImage> createState() => _SlowImageState();
}

class _SlowImageState extends State<SlowImage> {
  bool _show = false;
  Timer? _timer;

  // MEMORY LEAK: Esta lista crece infinitamente y es estática
  static final List<String> _leakedCache = [];

  @override
  void initState() {
    super.initState();
    // Delay aleatorio para simular red lenta (1-3 segundos)
    final delayMs = 1000 + Random().nextInt(2000);
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (mounted) setState(() => _show = true);
    });

    // CAOS: Rebuild innecesario cada 500ms para gastar CPU
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        // Simulamos "actividad"
        setState(() {
          // Agregamos basura a la lista estática CADA VEZ que se reconstruye
          // Esto eventualmente crasheará la app por falta de memoria si se usa mucho
          if (_leakedCache.length < 100000) {
            // Limitamos un poco para no matar el IDE del usuario inmediatamente
            _leakedCache.add("LEAK_${DateTime.now()} " * 100);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_show) {
      // Placeholder estático (sin shimmer)
      return Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey.shade300,
        child: const Center(child: Text('CARGANDO...')),
      );
    }

    // Añadimos un parámetro de query único para evitar caching trivial
    // Y forzamos que cambie cada vez que el timer corre para que parpadee
    final uniqueUrl =
        widget.url +
        (widget.url.contains('?') ? '&' : '?') +
        'v=${DateTime.now().millisecondsSinceEpoch}';

    return Image.network(
      uniqueUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      filterQuality: FilterQuality.none, // buscar pixelado/fealdad
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: Text('CARGANDO... ESPERA...'));
      },
      errorBuilder: (context, error, stackTrace) {
        return const StripedErrorWidget();
      },
    );
  }
}

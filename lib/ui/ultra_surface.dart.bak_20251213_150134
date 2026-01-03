import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'ultra_theme.dart';

class UltraSurface extends StatefulWidget {
  const UltraSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.safeArea = true,
    this.showNoise = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool safeArea;
  final bool showNoise;

  @override
  State<UltraSurface> createState() => _UltraSurfaceState();
}

class _UltraSurfaceState extends State<UltraSurface>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bg = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 18),
  )..repeat();

  @override
  void dispose() {
    _bg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: widget.padding, child: widget.child);

    return AnimatedBuilder(
      animation: _bg,
      builder: (_, __) {
        final t = _bg.value;
        final a = 0.30 + 0.22 * math.sin(t * math.pi * 2);
        final b = 0.25 + 0.18 * math.cos(t * math.pi * 2);

        Widget layer = Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1, -1),
                  end: Alignment(1, 1),
                  colors: [
                    UltraTheme.bgTop,
                    Color.lerp(
                      UltraTheme.bgMid,
                      UltraTheme.neonViolet.withOpacity(0.25),
                      a,
                    )!,
                    UltraTheme.bgBot,
                  ],
                ),
              ),
            ),

            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.35,
                  child: CustomPaint(
                    painter: _GlowBlobsPainter(a: a, b: b),
                  ),
                ),
              ),
            ),

            if (widget.showNoise)
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.14,
                    child: CustomPaint(painter: _NoisePainter(seed: 88)),
                  ),
                ),
              ),

            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: Colors.transparent),
              ),
            ),

            widget.safeArea ? SafeArea(child: content) : content,
          ],
        );

        return layer;
      },
    );
  }
}

class UltraGlassCard extends StatelessWidget {
  const UltraGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
  });
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.06),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: UltraTheme.neonCyan.withOpacity(0.10),
            blurRadius: 22,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _GlowBlobsPainter extends CustomPainter {
  _GlowBlobsPainter({required this.a, required this.b});
  final double a;
  final double b;

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()
      ..color = UltraTheme.neonCyan.withOpacity(0.16 + a * 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 70);
    final p2 = Paint()
      ..color = UltraTheme.neonViolet.withOpacity(0.14 + b * 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
    final p3 = Paint()
      ..color = UltraTheme.neonPink.withOpacity(0.10 + a * 0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90);

    canvas.drawCircle(
      Offset(size.width * 0.20, size.height * 0.22),
      size.shortestSide * 0.22,
      p1,
    );
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.28),
      size.shortestSide * 0.26,
      p2,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.80),
      size.shortestSide * 0.28,
      p3,
    );
  }

  @override
  bool shouldRepaint(covariant _GlowBlobsPainter oldDelegate) =>
      oldDelegate.a != a || oldDelegate.b != b;
}

class _NoisePainter extends CustomPainter {
  _NoisePainter({required this.seed});
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed);
    final paint = Paint()..color = Colors.white.withOpacity(0.9);
    for (int i = 0; i < 220; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final r = rnd.nextDouble() * 1.2;
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

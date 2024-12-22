import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../features/onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    // Start splash animation
    _controller.forward().then((_) {
      // Wait for 1.5 seconds after animation completes
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: animation,
                child: const OnboardingScreen(),
              ),
              transitionDuration: const Duration(milliseconds: 800),
              reverseTransitionDuration: const Duration(milliseconds: 800),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = 0.0;
                const end = 1.0;
                var fade = Tween(begin: begin, end: end).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                );

                return FadeTransition(
                  opacity: fade,
                  child: child,
                );
              },
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C1810),
      body: Stack(
        children: [
          // Decorative background pattern
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _fadeInAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeInAnimation.value * 0.1,
                  child: CustomPaint(
                    painter: BookPatternPainter(),
                  ),
                );
              },
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo mark
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.auto_stories_rounded,
                          size: 48,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // App name with animated fade
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Column(
                      children: [
                        Text(
                          'BOOKBOUND',
                          style: GoogleFonts.cinzel(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 8,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your Literary Journey Awaits',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            letterSpacing: 1,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const spacing = 40.0;
    const bookHeight = 30.0;
    const bookWidth = 20.0;

    for (double y = -bookHeight; y < size.height + bookHeight; y += spacing) {
      for (double x = -bookWidth; x < size.width + bookWidth; x += spacing) {
        final path = Path();
        path.moveTo(x, y);
        path.lineTo(x + bookWidth, y);
        path.lineTo(x + bookWidth, y + bookHeight);
        path.lineTo(x, y + bookHeight);
        path.close();

        // Add book spine detail
        path.moveTo(x + bookWidth * 0.8, y);
        path.lineTo(x + bookWidth * 0.8, y + bookHeight);

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

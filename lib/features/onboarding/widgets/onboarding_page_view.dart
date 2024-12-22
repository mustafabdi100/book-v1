// lib/features/onboarding/widgets/onboarding_page_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage {
  final String image;
  final String title;
  final String description;
  final List<String> additionalBooks;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.additionalBooks,
  });
}

class OnboardingPageView extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageView({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Book illustration
          SizedBox(
            height: 340,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Decorative circle
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF2C1810).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),

                // Main book
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: Transform.rotate(
                    angle: -0.1,
                    child: BookCover(
                      imagePath: page.image,
                      size: 240,
                    ),
                  ),
                ),

                // Additional books
                ...List.generate(
                  page.additionalBooks.length,
                  (index) {
                    final isLeft = index == 0;
                    return Positioned(
                      left: isLeft ? 20 : null,
                      right: !isLeft ? 20 : null,
                      bottom: 40,
                      child: Transform.rotate(
                        angle: isLeft ? 0.2 : -0.2,
                        child: Transform.translate(
                          offset: Offset(0, index * 20.0),
                          child: BookCover(
                            imagePath: page.additionalBooks[index],
                            size: 180,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1810),
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            page.description,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFF2C1810).withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  final String imagePath;
  final double size;

  const BookCover({
    super.key,
    required this.imagePath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 0.66,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 0),
            blurRadius: 4,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Book spine effect
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
          ),

          // Book cover image
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

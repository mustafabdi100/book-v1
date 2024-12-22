import 'package:flutter/material.dart';
import 'dart:math' as math;

class BookGridLayout extends StatelessWidget {
  const BookGridLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerX = constraints.maxWidth / 2;
        final centerY = constraints.maxHeight / 2;
        final radius =
            math.min(centerX, centerY) * 0.8; // Radius for the circle

        // List of book images to be repeated
        final List<String> bookImages = [
          'assets/images/books/book_night.jpg',
          'assets/images/books/fallen_night.png',
          'assets/images/books/ninth_house.png',
          'assets/images/books/one_dark_window.jpg',
          'assets/images/books/wolf_den.jpg',
        ];

        return Stack(
          fit: StackFit.expand,
          children: [
            // Generate 8 books in a circle
            ...List.generate(8, (index) {
              // Calculate position on the circle
              final angle =
                  (index * 2 * math.pi / 8); // Divide circle into 8 parts
              final x = centerX + radius * math.cos(angle);
              final y = centerY + radius * math.sin(angle);

              // Use modulo to repeat the book images
              final bookImage = bookImages[index % bookImages.length];

              return Positioned(
                left: x - 40, // Center the book (half of book width)
                top: y - 60, // Center the book (half of book height)
                child: Transform.rotate(
                  angle: angle + math.pi / 2, // Rotate book to face outward
                  child: _buildBook(bookImage),
                ),
              );
            }),

            // Center text
            Center(
              child: Text(
                'Escape Into a\nWorld of Words',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBook(String assetPath) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

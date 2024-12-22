// In lib/features/reader/models/reader_theme.dart
import 'package:flutter/material.dart';

class ReaderTheme {
  final String name;
  final Color backgroundColor;
  final Color textColor;
  final Color toolbarColor;
  final Color accentColor;

  const ReaderTheme({
    required this.name,
    required this.backgroundColor,
    required this.textColor,
    required this.toolbarColor,
    required this.accentColor,
  });
}

final List<ReaderTheme> readerThemes = [
  ReaderTheme(
    name: 'Classic',
    backgroundColor: const Color(0xFFF5EFE6),
    textColor: const Color(0xFF2C1810),
    toolbarColor: Colors.white.withOpacity(0.95),
    accentColor: const Color(0xFF2C1810),
  ),
  ReaderTheme(
    name: 'Sepia',
    backgroundColor: const Color(0xFFF8E3C8),
    textColor: const Color(0xFF3E2723),
    toolbarColor: const Color(0xFFFAEBD7).withOpacity(0.95),
    accentColor: const Color(0xFF8B4513),
  ),
  ReaderTheme(
    name: 'Night',
    backgroundColor: const Color(0xFF1A1A1A),
    textColor: const Color(0xFFE0E0E0),
    toolbarColor: const Color(0xFF262626).withOpacity(0.95),
    accentColor: const Color(0xFFBDBDBD),
  ),
];

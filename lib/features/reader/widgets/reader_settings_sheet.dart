// In lib/features/reader/widgets/reader_settings_sheet.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/reader_theme.dart';

class ReaderSettingsSheet extends StatelessWidget {
  final String selectedFont;
  final ReaderTheme currentTheme;
  final double fontSize;
  final Function(String) onFontChanged;
  final Function(ReaderTheme) onThemeChanged;
  final Function(double) onFontSizeChanged;

  const ReaderSettingsSheet({
    super.key,
    required this.selectedFont,
    required this.currentTheme,
    required this.fontSize,
    required this.onFontChanged,
    required this.onThemeChanged,
    required this.onFontSizeChanged,
  });

  TextStyle _getDropdownFontStyle(String fontName, Color color) {
    switch (fontName) {
      case 'Crimson Text':
        return GoogleFonts.crimsonText(
          color: color,
          fontSize: 16,
        );
      case 'Merriweather':
        return GoogleFonts.merriweather(
          color: color,
          fontSize: 16,
        );
      case 'Libre Baskerville':
        return GoogleFonts.libreBaskerville(
          color: color,
          fontSize: 16,
        );
      case 'Lora':
        return GoogleFonts.lora(
          color: color,
          fontSize: 16,
        );
      case 'Playfair Display':
        return GoogleFonts.playfairDisplay(
          color: color,
          fontSize: 16,
        );
      default:
        return GoogleFonts.crimsonText(
          color: color,
          fontSize: 16,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: currentTheme.toolbarColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Reading Settings',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: currentTheme.textColor,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                color: currentTheme.textColor,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Theme Selection
          Text(
            'Theme',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: currentTheme.textColor,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: readerThemes.length,
              itemBuilder: (context, index) {
                final theme = readerThemes[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () => onThemeChanged(theme),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: theme.name == currentTheme.name
                            ? Border.all(
                                color: currentTheme.accentColor, width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_stories,
                            color: theme.textColor,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            theme.name,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: theme.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Font Size Slider
          Text(
            'Text Size',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: currentTheme.textColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.text_decrease, color: currentTheme.textColor),
              Expanded(
                child: Slider(
                  value: fontSize,
                  min: 14,
                  max: 24,
                  divisions: 10,
                  activeColor: currentTheme.accentColor,
                  onChanged: onFontSizeChanged,
                ),
              ),
              Icon(Icons.text_increase, color: currentTheme.textColor),
            ],
          ),
          const SizedBox(height: 24),

          // Font Selection
          Text(
            'Font',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: currentTheme.textColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border:
                  Border.all(color: currentTheme.accentColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedFont,
                isExpanded: true,
                icon:
                    Icon(Icons.arrow_drop_down, color: currentTheme.textColor),
                dropdownColor: currentTheme.backgroundColor,
                items: [
                  'Crimson Text',
                  'Merriweather',
                  'Libre Baskerville',
                  'Lora',
                  'Playfair Display',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          _getDropdownFontStyle(value, currentTheme.textColor),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) onFontChanged(newValue);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

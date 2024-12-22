// In lib/features/reader/widgets/chapter_drawer.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/reader_theme.dart';

class ChapterDrawer extends StatelessWidget {
  final ReaderTheme theme;
  final int currentChapter;
  final Function(int) onChapterSelected;

  const ChapterDrawer({
    super.key,
    required this.theme,
    required this.currentChapter,
    required this.onChapterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      color: theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20).copyWith(top: 40),
            color: theme.toolbarColor,
            child: Row(
              children: [
                Text(
                  'Table of Contents',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.textColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: theme.textColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 20, // Example chapter count
              itemBuilder: (context, index) {
                final isCurrentChapter = index == currentChapter;
                return InkWell(
                  onTap: () {
                    onChapterSelected(index);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isCurrentChapter
                          ? theme.accentColor.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border(
                        left: BorderSide(
                          color: isCurrentChapter
                              ? theme.accentColor
                              : Colors.transparent,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chapter ${index + 1}',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: isCurrentChapter
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: theme.textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'The Path of the Sword', // Example chapter title
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 16,
                            fontWeight: isCurrentChapter
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: theme.textColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/reader_theme.dart';
import '../widgets/reader_settings_sheet.dart';
import '../widgets/chapter_drawer.dart';

class BookReader extends StatefulWidget {
  const BookReader({super.key});

  @override
  State<BookReader> createState() => _BookReaderState();
}

class _BookReaderState extends State<BookReader> {
  int _currentPage = 0;
  int _currentChapter = 0;
  String _selectedFont = 'Crimson Text';
  double _fontSize = 18;
  ReaderTheme _currentTheme = readerThemes[0];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isBookmarked = false;
  final PageController _pageController = PageController();

  TextStyle _getFont(String fontName, Color color, double size) {
    switch (fontName) {
      case 'Crimson Text':
        return GoogleFonts.crimsonText(
          fontSize: size,
          height: 1.6,
          color: color,
        );
      case 'Merriweather':
        return GoogleFonts.merriweather(
          fontSize: size,
          height: 1.6,
          color: color,
        );
      case 'Libre Baskerville':
        return GoogleFonts.libreBaskerville(
          fontSize: size,
          height: 1.6,
          color: color,
        );
      case 'Lora':
        return GoogleFonts.lora(
          fontSize: size,
          height: 1.6,
          color: color,
        );
      case 'Playfair Display':
        return GoogleFonts.playfairDisplay(
          fontSize: size,
          height: 1.6,
          color: color,
        );
      default:
        return GoogleFonts.crimsonText(
          fontSize: size,
          height: 1.6,
          color: color,
        );
    }
  }

  final List<String> _chapterContent = [
    'Chapter 1: The Mysterious Cave\n\nDeep in the heart of the forest, a glowing cave appeared overnight. The villagers, who had passed by the area countless times, were baffled. The entrance shimmered with an otherworldly light, and strange symbols adorned the rocks surrounding it. No one dared to enter, fearing the unknown. Rumors spread quickly, with some claiming it was a portal to another world, while others thought it was a trap set by vengeful spirits.\n\nYoung Arin, however, couldn’t resist the call of adventure. Armed with nothing but a lantern and his courage, he ventured inside. The air grew colder with every step, and the light from the cave’s entrance dimmed. Suddenly, the symbols on the walls began to glow, and Arin realized he wasn’t alone. Shadows danced around him, whispering secrets of a forgotten era.',
    'Chapter 2: The Clockmaker\'s Secret\n\nIn the heart of the bustling town, an ancient clock tower stood as a monument to its rich history. The old clockmaker, Mr. Harlan, had maintained it for decades, his gnarled hands as precise as the gears he tended to. People admired the clock but paid little attention to the man behind its perfection. Yet, within the tower, Harlan harbored a secret known only to him.\n\nOne stormy evening, his apprentice, Clara, stumbled upon a hidden compartment in the clock\'s mechanism. Inside lay a map and a cryptic note: "Time holds the key." Intrigued, Clara confronted Harlan, who revealed that the clock was more than a timekeeper – it was a gateway to moments long past. But tampering with it came at a cost that Clara was not prepared to pay.',
    'Chapter 3: The Forgotten Island\n\nCaptain Elara’s ship was battered by relentless waves, forcing her crew to abandon hope of navigation. When the storm finally passed, they found themselves anchored near an uncharted island. The crew, weary but curious, explored the shoreline. Ancient statues covered in vines stared at them with hollow eyes, and the air was thick with the scent of salt and mystery.\n\nVenturing inland, Elara discovered ruins of what seemed to be an advanced civilization. Amid the rubble, she found a glowing artifact that pulsed with a faint rhythm. Her hand trembled as she touched it, and visions of the island’s past filled her mind. She saw towering cities and thriving people, now reduced to silence. But her connection to the artifact awakened something buried beneath the island, something that didn’t wish to stay forgotten.',
    'Chapter 4: The Time Traveler\n\nLiam stared at the device he had spent years building. It was a patchwork of wires, gears, and glowing crystals, each piece painstakingly assembled. The moment of truth had arrived. With a deep breath, he flipped the switch. A deafening hum filled the room, and in an instant, he was no longer in his workshop. Instead, he stood in a bustling cityscape, the year unmistakably 1927.\n\nThe sights and sounds overwhelmed him – jazz music filled the air, flappers danced in speakeasies, and Model T cars zipped by. As Liam marveled at the past, a mysterious man in a fedora approached him. "You’re out of place," the man said with a knowing smile. Liam’s excitement turned to unease as he realized that the past wasn’t as welcoming as he’d hoped, and the man’s intentions were far from friendly.'
  ];

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ReaderSettingsSheet(
        selectedFont: _selectedFont,
        currentTheme: _currentTheme,
        fontSize: _fontSize,
        onFontChanged: (font) {
          setState(() => _selectedFont = font);
        },
        onThemeChanged: (theme) {
          setState(() => _currentTheme = theme);
        },
        onFontSizeChanged: (size) {
          setState(() => _fontSize = size);
        },
      ),
    );
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isBookmarked ? 'Bookmark added' : 'Bookmark removed',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: _currentTheme.accentColor,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _currentTheme.backgroundColor,
      drawer: ChapterDrawer(
        theme: _currentTheme,
        currentChapter: _currentChapter,
        onChapterSelected: (chapter) {
          setState(() => _currentChapter = chapter);
        },
      ),
      body: Column(
        children: [
          // Reader toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: _currentTheme.toolbarColor,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                    color: _currentTheme.textColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    color: _currentTheme.textColor,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                    ),
                    onPressed: _toggleBookmark,
                    color: _currentTheme.textColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: _showSettings,
                    color: _currentTheme.textColor,
                  ),
                ],
              ),
            ),
          ),

          // Book content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _chapterContent.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: SelectableText(
                    _chapterContent[index],
                    style: _getFont(
                      _selectedFont,
                      _currentTheme.textColor,
                      _fontSize,
                    ),
                  ),
                );
              },
            ),
          ),

          // Progress indicator
          Container(
            padding: const EdgeInsets.all(16),
            color: _currentTheme.toolbarColor,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Text(
                    'Page ${_currentPage + 1} of ${_chapterContent.length}',
                    style: GoogleFonts.inter(
                      color: _currentTheme.textColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${((_currentPage + 1) / _chapterContent.length * 100).round()}%',
                    style: GoogleFonts.inter(
                      color: _currentTheme.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

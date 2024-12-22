import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../reader/screens/book_reader.dart';

class FeaturedSection extends StatefulWidget {
  const FeaturedSection({super.key});

  @override
  State<FeaturedSection> createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<Map<String, dynamic>> continueReadingBooks = [
    {
      'image': 'assets/images/books/swordman.png',
      'title': 'The Last Swordsman',
      'author': 'R.K. Winters',
      'progress': 0.65,
      'chapter': 'Chapter 12',
      'pagesLeft': 124,
      'lastRead': '2 days ago'
    },
    {
      'image': 'assets/images/books/shadow.png',
      'title': 'Shadow Mage Academy',
      'author': 'Elena Blackwood',
      'progress': 0.32,
      'chapter': 'Chapter 6',
      'pagesLeft': 286,
      'lastRead': '5 days ago'
    },
    {
      'image': 'assets/images/books/dragon.png',
      'title': 'Dragon\'s Crown',
      'author': 'Marcus Drake',
      'progress': 0.89,
      'chapter': 'Chapter 24',
      'pagesLeft': 42,
      'lastRead': 'Yesterday'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Text(
            'Continue Reading',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1810),
            ),
          ),
        ),
        SizedBox(
          height: 280,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: continueReadingBooks.length,
                itemBuilder: (context, index) {
                  final book = continueReadingBooks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ContinueReadingCard(
                      bookImage: book['image'],
                      title: book['title'],
                      author: book['author'],
                      progress: book['progress'],
                      chapter: book['chapter'],
                      pagesLeft: book['pagesLeft'],
                      lastRead: book['lastRead'],
                      isActive: _currentPage == index,
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    continueReadingBooks.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF2C1810)
                            : const Color(0xFF2C1810).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContinueReadingCard extends StatelessWidget {
  final String bookImage;
  final String title;
  final String author;
  final double progress;
  final String chapter;
  final int pagesLeft;
  final String lastRead;
  final bool isActive;

  const ContinueReadingCard({
    super.key,
    required this.bookImage,
    required this.title,
    required this.author,
    required this.progress,
    required this.chapter,
    required this.pagesLeft,
    required this.lastRead,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2C1810),
            const Color(0xFF2C1810).withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C1810).withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                bookImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${(progress * 100).round()}%',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$pagesLeft pages left',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        chapter,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '· Last read $lastRead',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 36,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookReader(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF2C1810),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_arrow_rounded, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'Continue Reading',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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

class NewReleasesSection extends StatelessWidget {
  const NewReleasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          final books = [
            {
              'image': 'assets/images/books/ninth_house.png',
              'title': 'Ninth House',
              'author': 'Leigh Bardugo'
            },
            {
              'image': 'assets/images/books/wolf_den.jpg',
              'title': 'Wolf Den',
              'author': 'Elodie Harper'
            },
            {
              'image': 'assets/images/books/one_dark_window.jpg',
              'title': 'One Dark Window',
              'author': 'Rachel Gillig'
            },
            {
              'image': 'assets/images/books/fallen_night.png',
              'title': 'Fallen Night',
              'author': 'C.N. Crawford'
            },
            {
              'image': 'assets/images/books/book_night.jpg',
              'title': 'Book of Night',
              'author': 'Holly Black'
            },
          ];

          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: BookCard(
              image: books[index]['image']!,
              title: books[index]['title']!,
              author: books[index]['author']!,
            ),
          );
        },
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;

  const BookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Book Cover
        Container(
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1810),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                author,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF2C1810).withOpacity(0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          final books = [
            {
              'image': 'assets/images/books/wolf_den.jpg',
              'title': 'Wolf Den',
              'author': 'Elodie Harper',
              'rating': '4.5'
            },
            {
              'image': 'assets/images/books/ninth_house.png',
              'title': 'Ninth House',
              'author': 'Leigh Bardugo',
              'rating': '4.8'
            },
            {
              'image': 'assets/images/books/one_dark_window.jpg',
              'title': 'One Dark Window',
              'author': 'Rachel Gillig',
              'rating': '4.3'
            },
            {
              'image': 'assets/images/books/book_night.jpg',
              'title': 'Book of Night',
              'author': 'Holly Black',
              'rating': '4.6'
            },
          ];

          return TrendingBookCard(
            image: books[index]['image']!,
            title: books[index]['title']!,
            author: books[index]['author']!,
            rating: books[index]['rating']!,
          );
        },
      ),
    );
  }
}

class TrendingBookCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String rating;

  const TrendingBookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Book Cover
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Rating badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFD700),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C1810),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          author,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF2C1810).withOpacity(0.7),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class MonthlyBookBoxSection extends StatelessWidget {
  const MonthlyBookBoxSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coming in Your Next Box',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C1810),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Ships January 1st',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF2C1810).withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Box',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF2C1810),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Color(0xFF2C1810),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final books = [
                {
                  'image': 'assets/images/books/swordman.png',
                  'title': 'The Last Swordsman',
                  'author': 'R.K. Winters',
                  'type': 'Main Selection',
                  'description':
                      'An epic tale of honor, destiny, and the last warrior of an ancient order'
                },
                {
                  'image': 'assets/images/books/shadow.png',
                  'title': 'Shadow Mage Academy',
                  'author': 'Elena Blackwood',
                  'type': 'Bonus Book',
                  'description':
                      'Dark magic and ancient secrets await at this mysterious school of sorcery'
                },
                {
                  'image': 'assets/images/books/dragon.png',
                  'title': 'Dragon\'s Crown',
                  'author': 'Marcus Drake',
                  'type': 'Extra Gift',
                  'description':
                      'A legendary crown holds the power to unite kingdoms and awaken dragons'
                },
              ];

              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: MonthlyBoxBookCard(
                  image: books[index]['image']!,
                  title: books[index]['title']!,
                  author: books[index]['author']!,
                  type: books[index]['type']!,
                  description: books[index]['description']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MonthlyBoxBookCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String type;
  final String description;

  const MonthlyBoxBookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.type,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C1810).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Box Type Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF2C1810).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              type,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF2C1810),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Book Cover
          Center(
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Book Details
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1810),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  author,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF2C1810).withOpacity(0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF2C1810).withOpacity(0.6),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

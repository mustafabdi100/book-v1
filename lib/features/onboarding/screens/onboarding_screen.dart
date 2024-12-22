import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/onboarding_page_view.dart';
import '../../home/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/images/books/book_night.jpg',
      title: 'Curated Collections',
      description:
          'Discover hand-picked books tailored to your literary tastes',
      additionalBooks: [
        'assets/images/books/ninth_house.png',
        'assets/images/books/wolf_den.jpg',
      ],
    ),
    OnboardingPage(
      image: 'assets/images/books/one_dark_window.jpg',
      title: 'Monthly Surprises',
      description:
          'Receive carefully selected books delivered to your doorstep each month',
      additionalBooks: [
        'assets/images/books/fallen_night.png',
        'assets/images/books/book_night.jpg',
      ],
    ),
    OnboardingPage(
      image: 'assets/images/books/ninth_house.png',
      title: 'Join the Community',
      description:
          'Connect with fellow readers and share your literary journey',
      additionalBooks: [
        'assets/images/books/wolf_den.jpg',
        'assets/images/books/one_dark_window.jpg',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFF9F6F0),
                    const Color(0xFFE8E4DD),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return OnboardingPageView(page: _pages[index]);
                    },
                  ),
                ),

                // Page indicator and buttons
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Page indicator dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
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
                      const SizedBox(height: 32),

                      // Navigation buttons
                      Row(
                        children: [
                          if (_currentPage > 0)
                            TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text(
                                'Previous',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: const Color(0xFF2C1810),
                                ),
                              ),
                            ),
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_currentPage < _pages.length - 1) {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2C1810),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  _currentPage < _pages.length - 1
                                      ? 'Next'
                                      : 'Get Started',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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

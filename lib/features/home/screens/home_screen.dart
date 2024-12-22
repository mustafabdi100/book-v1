// In lib/features/home/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home_sections.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFFF9F6F0),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Text(
                'BOOKBOUND',
                style: GoogleFonts.cinzel(
                  color: const Color(0xFF2C1810),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Color(0xFF2C1810)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Color(0xFF2C1810)),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Section
                const FeaturedSection(),
                const SizedBox(height: 32),

                // New Releases
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'New Releases',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1810),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const NewReleasesSection(),
                const SizedBox(height: 32),

                // Trending Now
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Trending Now',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1810),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const TrendingSection(),
                const SizedBox(height: 32),

                // Your Next Read
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Your Next Read',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1810),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const MonthlyBookBoxSection(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

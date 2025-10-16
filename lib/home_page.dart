import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'about_page.dart';
import 'skills_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  final List<String> _navItems = ['Home', 'About', 'Skills', 'Projects', 'Contact'];

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SkillsPage()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsPage()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Column(
        children: [
          // Navigation Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NAYAN.',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFffc500),
                  ),
                ),
                Row(
                  children: _navItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextButton(
                        onPressed: () => _navigateToPage(index),
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: _currentIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _currentIndex == index
                                ? const Color(0xFFffc500)
                                : const Color(0xFFB0B0B0),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF8E0E00),
                          const Color(0xFF1F1C18),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, I\'m',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Nayan Porwal',
                                style: GoogleFonts.poppins(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFffc500),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Flutter & Android Developer',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: const Color(0xFFffc500),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  // Gradient Contact Me Button
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFee0979),
                                          Color(0xFFff6a00),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFffc500).withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => _launchURL('https://wa.me/+918126426210'),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Contact Me',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  OutlinedButton(
                                    onPressed: () => _launchURL('https://github.com/NAYAN410'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                      side: const BorderSide(color: Color(0xFFffc500)),
                                      foregroundColor: const Color(0xFFffc500),
                                    ),
                                    child: Text(
                                      'View GitHub',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF1E1E1E),
                            border: Border.all(
                              color: const Color(0xFFffc500),
                              width: 3,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage('https://i.postimg.cc/50Tck3F1/mp.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Skills Section Preview
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                    color: const Color(0xFF0A0A0A),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Skills & Technologies',
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFffc500),
                              ),
                            ),
                            TextButton(
                              onPressed: () => _navigateToPage(2),
                              child: Text(
                                'View All →',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: const Color(0xFFffc500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            _buildSkillCardWithIconHover('Flutter', FontAwesomeIcons.flutter, const Color(0xFF0253B3)),
                            _buildSkillCardWithIconHover('Dart', FontAwesomeIcons.code, const Color(0xFF00B4AB)),
                            _buildSkillCardWithIconHover('Firebase', FontAwesomeIcons.fire, const Color(0xFFFFA000)),
                            _buildSkillCardWithIconHover('Kotlin', Icons.android, const Color(0xFF540380)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Projects Section Preview
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                    color: const Color(0xFF000000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Featured Projects',
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFffc500),
                              ),
                            ),
                            TextButton(
                              onPressed: () => _navigateToPage(3),
                              child: Text(
                                'View All →',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: const Color(0xFFffc500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            _buildProjectCard(
                              'E-Commerce App',
                              'A complete e-commerce solution with Flutter',
                              Icons.shopping_cart,
                              const Color(0xFFE91E63),
                            ),
                            const SizedBox(width: 30),
                            _buildProjectCard(
                              'Weather App',
                              'Real-time weather application with beautiful UI',
                              Icons.wb_sunny,
                              const Color(0xFF03DAC6),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Footer
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    color: const Color(0xFF1A1A2E),
                    child: Column(
                      children: [
                        Text(
                          'Let\'s work together!',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFffc500),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => _launchURL('https://github.com/NAYAN410'),
                              icon: const Icon(Icons.code, color: Color(0xFFffc500)),
                              iconSize: 30,
                            ),
                            IconButton(
                              onPressed: () => _launchURL('https://www.linkedin.com/in/nayan-porwal-23266923b/'),
                              icon: const Icon(Icons.people, color: Color(0xFFffc500)),
                              iconSize: 30,
                            ),
                            IconButton(
                              onPressed: () => _launchURL('mailto:nayanporwal001@gmail.com'),
                              icon: const Icon(Icons.email, color: Color(0xFFffc500)),
                              iconSize: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '© 2025 Nayan. All rights reserved.',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFB0B0B0),
                          ),
                        ),
                      ],
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

  Widget _buildSkillCardWithIconHover(String title, IconData icon, Color color) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isIconHovered = false;

        return Container(
          width: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: const Color(0xFF333333),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Hoverable Icon with Shine Effect
              MouseRegion(
                onEnter: (_) => setState(() => isIconHovered = true),
                onExit: (_) => setState(() => isIconHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Main Icon
                      Icon(
                        icon,
                        size: 40,
                        color: isIconHovered ? Colors.white : color,
                      ),
                      // Shine Effect Overlay
                      if (isIconHovered)
                        Icon(
                          icon,
                          size: 40,
                          color: Colors.white.withOpacity(0.8),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProjectCard(String title, String description, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF333333),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: GoogleFonts.poppins(
                color: const Color(0xFFB0B0B0),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'View Project',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
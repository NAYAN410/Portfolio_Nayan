import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFffc500)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Skills & Technologies',
          style: GoogleFonts.poppins(
            color: const Color(0xFFffc500),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Technical Skills',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFffc500),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Here are the technologies and tools I work with',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildSkillCard('Flutter', FontAwesomeIcons.flutter, const Color(0xFF0253B3)),
                _buildSkillCard('Dart', FontAwesomeIcons.code, const Color(0xFF00B4AB)),
                _buildSkillCard('Firebase', FontAwesomeIcons.fire, const Color(0xFFFFA000)),
                _buildSkillCard('Kotlin', Icons.android, const Color(0xFF540380)),
                _buildSkillCard('XML', FontAwesomeIcons.code, const Color(0xffdc5d0e)),
                _buildSkillCard('Play Store', FontAwesomeIcons.googlePlay, const Color(0xFF4CAF50)),
                _buildSkillCard('Git', Icons.terminal, const Color(0xFFeba10c)),
                _buildSkillCard('Authentication', Icons.key, const Color(0xFFF4511E)),
                _buildSkillCard('Android', FontAwesomeIcons.android, const Color(0xFF0ec720)),
                _buildSkillCard('iOS', Icons.apple, const Color(0xffffffff)),
                _buildSkillCard('Web', Icons.web, const Color(0xFFeb0c0c)),
                _buildSkillCard('Swift', FontAwesomeIcons.swift, const Color(0xffd8800f)),
                _buildSkillCard('Database', FontAwesomeIcons.database, const Color(0xFF0c3ceb)),
                _buildSkillCard('Hosting', FontAwesomeIcons.earth, const Color(0xFF2deb0c)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard(String title, IconData icon, Color color) {
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
              MouseRegion(
                onEnter: (_) => setState(() => isIconHovered = true),
                onExit: (_) => setState(() => isIconHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 40,
                        color: isIconHovered ? Colors.white : color,
                      ),
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
}
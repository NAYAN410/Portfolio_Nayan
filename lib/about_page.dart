import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

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
          'About Me',
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFffc500), width: 3),
                    image: const DecorationImage(
                      image: NetworkImage('https://i.postimg.cc/50Tck3F1/mp.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nayan Porwal',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFffc500),
                        ),
                      ),
                      Text(
                        'Flutter & Android Developer',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: const Color(0xFF03DAC6),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Passionate mobile app developer with expertise in Flutter, Dart, and native Android development. I create beautiful and functional applications that provide exceptional user experiences.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Education Section
            Text(
              'Education',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFffc500),
              ),
            ),
            const SizedBox(height: 20),
            _buildEducationCard(
              'Bachelor of Technology',
              'Dr.A.P.J. Abdul Kalam Technical University',
              '2021 - 2025',
            ),

            const SizedBox(height: 40),

            // Experience Section
            Text(
              'Experience',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFffc500),
              ),
            ),
            const SizedBox(height: 20),
            _buildExperienceCard(
              'Android Developer',
              'MIRASHKA',
              '2024 - Present',
              'Developed cross-platform mobile applications using Flutter and Dart. Created responsive UIs, integrated REST APIs, and implemented state management solutions.',
              'https://drive.google.com/file/d/1b5xYOLUzl39G9j_sJJlUH-btHvMRFnO2/view?usp=sharing', // Experience letter link
              'https://drive.google.com/file/d/1jMBwrt_nATmZY8lWJygclAq5_fBUUD6l/view?usp=sharing', // Replace with your resume link
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(String degree, String university, String period) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              degree,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              university,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFFffc500),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              period,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFFB0B0B0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(String position, String company, String period, String description, String driveLink, String resumeLink) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              position,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              company,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFFffc500),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              period,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFFB0B0B0),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Download Buttons Row
            Row(
              children: [
                // Download Letter Button
                Expanded(
                  child: Container(
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
                      onPressed: () => _launchURL(driveLink),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.description, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Letter',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                // Download Resume Button
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF03DAC6),
                          Color(0xFF018786),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF03DAC6).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => _launchURL(resumeLink),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.person, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Resume',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
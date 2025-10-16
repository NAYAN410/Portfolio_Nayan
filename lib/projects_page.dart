import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  Map<String, bool> _downloadingStates = {};

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showSnackBar('Could not launch URL');
    }
  }

  Future<void> _downloadFile(String fileUrl, String fileName, String projectName) async {
    setState(() {
      _downloadingStates[projectName] = true;
    });

    try {
      // For web, directly open the download link
      // For mobile apps, this will open in browser and trigger download
      await launchUrl(
        Uri.parse(fileUrl),
        mode: LaunchMode.externalApplication,
      );

      _showSnackBar('Download started for $fileName');
    } catch (e) {
      _showSnackBar('Download failed: $e');
    } finally {
      setState(() {
        _downloadingStates[projectName] = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFffc500),
        content: Text(
          message,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
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
          'My Projects',
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
              'Featured Projects',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFffc500),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Here are some of my recent projects',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                _buildProjectCardDetailed(
                  'Burgerooh - A Cafe App',
                  'A complete Food Ordering solution with kotlin, Firebase, and Stripe integration. Features include user authentication, product catalog, shopping cart, and Razorpay payment processing.',
                  Icons.emoji_food_beverage_rounded,
                  const Color(0xFFE91E63),
                  ['Kotlin', 'Firebase', 'Xml', 'Telegram Api', 'Razorpay Payment Gateway','Glide Library'],
                  'https://drive.google.com/drive/folders/1XWaS4gdR2h2Mjn7GeL80l_Jwao2JsL_B?usp=sharing',
                  'https://drive.google.com/file/d/1RsVl1VefrkrMsCUZfGNNutS1lyjJgrbb/view?usp=sharing',
                  'Burgerooh_App.apk',
                ),
                const SizedBox(height: 30),
                _buildProjectCardDetailed(
                  'Calculator and BMI Calculator',
                  'Dual-functionality app featuring arithmetic operations and gender-specific BMI analysis with persistent data storage',
                  Icons.calculate,
                  const Color(0xFF03DAC6),
                  ['Kotlin', 'REST API', 'Room Database', 'Xml','UI/UX'],
                  'https://drive.google.com/drive/folders/1LwOBJ66WvPwcAmjdD8_rgk2xD3WKgNtg?usp=sharing',
                  'https://drive.google.com/file/d/1glnC7xAxlbR9d6-wP8SoYJkYd6o29GJZ',
                  'Calculator_BMI_App.apk',
                ),
                const SizedBox(height: 30),
                _buildProjectCardDetailed(
                  'Task Manager',
                  'Productivity app for managing daily tasks with features like categories, priorities, reminders, and progress tracking.',
                  Icons.task,
                  const Color(0xFF0253B3),
                  ['Flutter', 'SQLite', 'Local Notifications', 'Bloc Pattern'],
                  'https://github.com/NAYAN410/Task-Manager-App',
                  'https://drive.google.com/uc?export=download&id=YOUR_TASK_MANAGER_APK_FILE_ID',
                  'Task_Manager_App.apk',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCardDetailed(
      String title,
      String description,
      IconData icon,
      Color color,
      List<String> technologies,
      String githubUrl,
      String downloadUrl,
      String fileName,
      ) {
    bool isDownloading = _downloadingStates[title] ?? false;

    return Container(
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
          Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: GoogleFonts.poppins(
              color: const Color(0xFFB0B0B0),
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: technologies.map((tech) => Chip(
              label: Text(tech),
              backgroundColor: color.withOpacity(0.2),
              labelStyle: GoogleFonts.poppins(
                color: Colors.white,
              ),
            )).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Download APK Button
              ElevatedButton.icon(
                onPressed: isDownloading
                    ? null
                    : () => _downloadFile(downloadUrl, fileName, title),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                icon: isDownloading
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.download, size: 20),
                label: Text(
                  isDownloading ? 'Downloading...' : 'Download APK',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // GitHub Button
              OutlinedButton.icon(
                onPressed: () => _launchURL(githubUrl),
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                icon: const Icon(Icons.code, size: 20),
                label: Text(
                  'Source Code',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
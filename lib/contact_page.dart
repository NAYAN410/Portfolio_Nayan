import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String? _selectedPlatform;

  final List<String> platforms = [
    'Upwork',
    'Fiverr',
    'Freelancer',
    'Toptal',
    'PeoplePerHour',
    'Guru',
    'Other',
  ];

  // REPLACE THIS WITH YOUR FORMSPREE URL FROM STEP 3
  final String formspreeURL = 'https://formspree.io/f/xwpravwv';

  bool _isLoading = false;

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse(formspreeURL),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'company': _companyController.text,
            'email': _emailController.text,
            'whatsapp': _whatsappController.text,
            'platform': _selectedPlatform ?? 'Not specified',
            'message': _messageController.text,
            '_subject': 'New Contact Form Submission - Portfolio',
          }),
        ).timeout(const Duration(seconds: 30));

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200) {
          _showSubmissionDialog(
              true,
              'Message sent successfully! 🎉\n\nI\'ll get back to you within 24 hours.'
          );
          _clearForm();
        } else {
          _showSubmissionDialog(
              false,
              'Form submission failed (Error: ${response.statusCode}).\n\nPlease email me directly at nayanporwal001@gmail.com'
          );
        }
      } on http.ClientException catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showSubmissionDialog(
            false,
            'Network connection error. Please check your internet and try again.\n\nError: $e'
        );
      } on TimeoutException catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showSubmissionDialog(
            false,
            'Request timeout. Please try again.\n\nYou can also contact me directly via email or WhatsApp.'
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showSubmissionDialog(
            false,
            'Unexpected error: $e\n\nPlease email me directly at nayanporwal001@gmail.com'
        );
      }
    }
  }

  void _clearForm() {
    _nameController.clear();
    _companyController.clear();
    _emailController.clear();
    _whatsappController.clear();
    _messageController.clear();
    setState(() {
      _selectedPlatform = null;
    });
  }

  void _showSubmissionDialog(bool success, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error_outline,
                color: success ? Color(0xFF4CAF50) : Color(0xFFF44336),
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                success ? 'Success!' : 'Oops!',
                style: GoogleFonts.poppins(
                  color: success ? Color(0xFF4CAF50) : Color(0xFFF44336),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (success) {
                  // Optionally navigate back or do something on success
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFffc500),
              ),
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (!success)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _launchURL('mailto:nayanporwal001@gmail.com?subject=Contact from Portfolio&body=Hello Nayan,');
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF03DAC6),
                ),
                child: Text(
                  'Email Instead',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _messageController.dispose();
    super.dispose();
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
          'Contact Me',
          style: GoogleFonts.poppins(
            color: const Color(0xFFffc500),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Color(0xFFffc500),
              strokeWidth: 3,
            ),
            SizedBox(height: 20),
            Text(
              'Sending your message...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get In Touch',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFffc500),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'I\'m always open to discussing new opportunities and interesting projects.',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),

            // Contact Methods
            _buildContactMethod(
              Icons.email,
              'Email',
              'nayanporwal001@gmail.com',
                  () => _launchURL('mailto:nayanporwal001@gmail.com'),
            ),
            const SizedBox(height: 20),
            _buildContactMethod(
              FontAwesomeIcons.whatsapp,
              'WhatsApp',
              '+91 8126426210',
                  () => _launchURL('https://wa.me/+918126426210'),
            ),
            const SizedBox(height: 20),
            _buildContactMethod(
              Icons.code,
              'GitHub',
              'github.com/NAYAN410',
                  () => _launchURL('https://github.com/NAYAN410'),
            ),
            const SizedBox(height: 20),
            _buildContactMethod(
              Icons.people,
              'LinkedIn',
              'linkedin.com/in/nayan-porwal',
                  () => _launchURL('https://www.linkedin.com/in/nayan-porwal-23266923b/'),
            ),

            const SizedBox(height: 40),

            // Contact Form Section
            _buildContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactMethod(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFffc500), size: 30),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            color: const Color(0xFFB0B0B0),
            fontSize: 14,
          ),
        ),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFffc500), size: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Form(
      key: _formKey,
      child: Card(
        color: const Color(0xFF1E1E1E),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.message, color: const Color(0xFFffc500), size: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Send Me a Message',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFffc500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Fill out the form below and I\'ll get back to you as soon as possible.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFFB0B0B0),
                ),
              ),
              const SizedBox(height: 30),

              // Name Field
              _buildFormField(
                label: 'Name *',
                hintText: 'Enter your full name',
                icon: Icons.person,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Company Name Field
              _buildFormField(
                label: 'Company Name *',
                hintText: 'Enter your company name',
                icon: Icons.business,
                controller: _companyController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Email Field
              _buildFormField(
                label: 'Email *',
                hintText: 'Enter your email address',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // WhatsApp Field (Optional)
              _buildFormField(
                label: 'WhatsApp Number (Optional)',
                hintText: 'Enter your WhatsApp number',
                icon: FontAwesomeIcons.whatsapp,
                keyboardType: TextInputType.phone,
                controller: _whatsappController,
              ),
              const SizedBox(height: 20),

              // Freelancing Platform Field
              _buildFreelancingPlatformDropdown(),
              const SizedBox(height: 20),

              // Message Field (Optional)
              _buildMessageField(),
              const SizedBox(height: 30),

              // Contact Us Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFee0979),
                      Color(0xFFff6a00),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFff6a00).withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey[600],
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    'Send Message',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF444444)),
          ),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(color: const Color(0xFF888888), fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon: Icon(icon, color: const Color(0xFFffc500), size: 20),
              errorStyle: GoogleFonts.poppins(color: Colors.red, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFreelancingPlatformDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Freelancing Platform *',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF444444)),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedPlatform,
            dropdownColor: const Color(0xFF2A2A2A),
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon: Icon(FontAwesomeIcons.briefcase, color: const Color(0xFFffc500), size: 20),
              errorStyle: GoogleFonts.poppins(color: Colors.red, fontSize: 12),
            ),
            items: platforms.map((String platform) {
              return DropdownMenuItem<String>(
                value: platform,
                child: Text(platform),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedPlatform = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a platform';
              }
              return null;
            },
            hint: Text(
              'Select your preferred platform',
              style: GoogleFonts.poppins(color: const Color(0xFF888888), fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Message (Optional)',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF444444)),
          ),
          child: TextField(
            controller: _messageController,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Tell me about your project, timeline, budget, or any specific requirements...',
              hintStyle: GoogleFonts.poppins(color: const Color(0xFF888888), fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon: Icon(Icons.description, color: const Color(0xFFffc500), size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
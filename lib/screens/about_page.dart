//lib/screens/about_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _sendEmail() async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: 'emukumbwa2419@gmail.com',
      query: 'subject=Hello from your Flutter app',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Fallback: show a snackbar
      // (We'll need a BuildContext, so we'll pass it as a parameter or use a global navigator)
      // For simplicity, we'll just print.
      debugPrint('Could not launch email client');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(  // 👈 Wrapped to avoid overflow
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Emmanuel Mukumbwa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Full‑stack developer building practical digital products with Flutter, React, Node.js, and PHP.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Skills',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                Chip(label: Text('Flutter')),
                Chip(label: Text('React')),
                Chip(label: Text('Node.js')),
                Chip(label: Text('PHP')),
                Chip(label: Text('UI/UX')),
                Chip(label: Text('Firebase')),
                Chip(label: Text('Next.js')),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Contact',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('emukumbwa2419@gmail.com'),
              onTap: _sendEmail,   // 👈 Now opens email client
            ),
          ],
        ),
      ),
    );
  }
}
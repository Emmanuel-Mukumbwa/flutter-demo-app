//lib/screens/project_detail_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailPage extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailPage({super.key, required this.project});

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback: show snackbar if URL cannot be launched
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project['title']),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.folder_open, size: 48, color: Colors.deepPurple),
                    const SizedBox(height: 12),
                    Text(
                      project['title'],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project['subtitle'],
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (project['tech'] as List<String>)
                          .map((tech) => Chip(label: Text(tech)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              project['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Key Features',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...(project['features'] as List<String>).map(
              (feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, size: 18, color: Colors.deepPurple),
                    const SizedBox(width: 8),
                    Expanded(child: Text(feature)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (project['demo'] != null || project['repo'] != null)
              const Text(
                'Links',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 8),
            if (project['demo'] != null)
              ListTile(
                leading: const Icon(Icons.open_in_browser),
                title: const Text('Live Demo'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  _launchUrl(project['demo']);
                },
              ),
            if (project['repo'] != null)
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('GitHub Repository'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  _launchUrl(project['repo']);
                },
              ),
          ],
        ),
      ),
    );
  }
}
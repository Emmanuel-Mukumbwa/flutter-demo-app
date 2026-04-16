//lib/screens/projects_page.dart
import 'package:flutter/material.dart';
import 'project_detail_page.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  final List<Map<String, dynamic>> _projects = const [
    {
      'title': 'BackyardBeats',
      'subtitle': 'Music platform for Malawian artists',
      'tech': ['Flutter', 'Firebase', 'Node.js', 'Cloudinary'],
      'description':
          'A full‑stack music platform where artists can upload tracks, manage albums, and fans can discover new music. Includes authentication, playlist creation, and real‑time updates.',
      'features': [
        'Artist onboarding with profile photo and bio',
        'Track upload with artwork',
        'Favourite tracks and playlists',
        'Real‑time listen counts',
        'Admin approval workflow',
      ],
      'demo': 'https://backyardbeats.vercel.app',
      'repo': 'https://github.com/Emmanuel-Mukumbwa/backyard-beats',
    },
    {
      'title': 'CampusTalent',
      'subtitle': 'Gig and recruitment platform for students',
      'tech': ['React', 'Node.js', 'MySQL', 'JWT'],
      'description':
          'A platform connecting university students with recruiters. Students can build portfolios, apply for gigs, and recruiters can post jobs and verify applicants.',
      'features': [
        'Student portfolio builder',
        'Job posting and application system',
        'Recruiter verification workflow',
        'Skill‑based matching',
        'Payment integration (PayChangu)',
      ],
      'demo': 'https://campus-talent-front-end-f28i.vercel.app',
      'repo': 'https://github.com/Emmanuel-Mukumbwa/campus_talent_front_end',
    },
    {
      'title': 'CCNA Networking Portfolio',
      'subtitle': 'Cisco Packet Tracer labs',
      'tech': ['Cisco IOS', 'VLAN', 'NAT', 'DHCP', 'OSPF'],
      'description':
          'A collection of networking projects demonstrating VLAN segmentation, inter‑VLAN routing, NAT/PAT configuration, port security, and DHCP services.',
      'features': [
        'VLAN segmentation with Router‑on‑a‑Stick',
        'NAT overload and static NAT',
        'Port security with sticky MAC',
        'DHCP server and relay',
        'OSPF routing (optional)',
      ],
      'demo': null,
      'repo': 'https://github.com/Emmanuel-Mukumbwa/ccna-portfolio-emmanuelMukumbwa',
    },
    {
      'title': 'Weather Forecast App',
      'subtitle': 'Real‑time weather using OpenWeatherMap',
      'tech': ['React', 'OpenWeather API', 'Bootstrap'],
      'description':
          'A responsive weather app that shows current conditions and a 7‑day forecast for any city. Users can save favourites and switch between Celsius/Fahrenheit.',
      'features': [
        'Search by city name',
        '7‑day forecast',
        'Favourite cities list',
        'Temperature unit toggle',
        'Responsive design',
      ],
      'demo': 'https://weather-app-vert-theta-10.vercel.app',
      'repo': 'https://github.com/Emmanuel-Mukumbwa/weather-app',
    },
    {
      'title': 'Hostel Manager',
      'subtitle': 'Booking and room tracking system',
      'tech': ['PHP', 'MySQL', 'Bootstrap'],
      'description':
          'A web‑based system for managing hostel rooms, student bookings, payments, and maintenance requests. Used internally at a technical college.',
      'features': [
        'Room allocation and availability tracking',
        'Student booking and payment records',
        'Maintenance request portal',
        'Admin dashboard with reports',
        'Print invoices',
      ],
      'demo': null,
      'repo': null,
    },
    {
      'title': 'Password Generator App',
      'subtitle': 'Secure, customizable password generator',
      'tech': ['React'],
      'description':
          'A simple but useful tool to generate strong passwords with options for length, uppercase/lowercase, numbers, and symbols.',
      'features': [
        'Adjustable password length (6–32)',
        'Include/exclude character types',
        'Copy to clipboard',
        'Password strength indicator',
      ],
      'demo': 'https://password-generator-app-lime.vercel.app',
      'repo': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: const Icon(Icons.folder_open, color: Colors.deepPurple),
              title: Text(project['title']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project['subtitle']!),
                  const SizedBox(height: 4),
                  Text(
                    (project['tech'] as List<String>).join(', '),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailPage(project: project),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
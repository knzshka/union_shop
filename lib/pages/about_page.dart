import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavbar(currentRoute: '/about'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We are the community of The Union Shop page of the University of Portsmouth '
                    'Students’ Union.\n\n'
                    'From Students to Students'
                    'We craft, you enjoy',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                color: Colors.grey[50],
                padding: const EdgeInsets.all(24),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchase online 24/7',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Monday - Friday'),
                    Text('on site opening time 10am'),
                    Text('on site closing time 6pm'),
                    SizedBox(height: 8),
                    Text(
                      'any more questions? contact us at shopupsu@myport.ac.uk',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
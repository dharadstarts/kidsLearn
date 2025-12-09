import 'package:flutter/material.dart';

class BabySleepScreen extends StatelessWidget {
  const BabySleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.brown),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    'Baby Sleep',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 20),

              // Transport Section
              const SectionTitle(title: "Transport"),
              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: const [
                  FeatureItem(
                      title: "Car",
                      icon: Icons.directions_car,
                      color: Color(0xFFB0D8FF)),
                  FeatureItem(
                      title: "Bus",
                      icon: Icons.directions_bus,
                      color: Color(0xFFD2B6FF)),
                  FeatureItem(
                      title: "Train",
                      icon: Icons.train,
                      color: Color(0xFFD7B9A3)),
                  FeatureItem(
                      title: "Plane",
                      icon: Icons.flight,
                      color: Color(0xFFF3B8A0)),
                ],
              ),

              const SizedBox(height: 20),

              // Household Section
              const SectionTitle(title: "Household"),
              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: const [
                  FeatureItem(
                      title: "Washing Machine",
                      icon: Icons.local_laundry_service,
                      color: Color(0xFFF2C7E7)),
                  FeatureItem(
                      title: "Vaccum",
                      icon: Icons.cleaning_services,
                      color: Color(0xFFCFF3E7)),
                  FeatureItem(
                      title: "Watch",
                      icon: Icons.watch,
                      color: Color(0xFFD7B9A3)),
                  FeatureItem(
                      title: "Radio",
                      icon: Icons.radio,
                      color: Color(0xFFF1A7C8)),
                  FeatureItem(
                      title: "Hair Dryer",
                      icon: Icons.air,
                      color: Color(0xFFF3B8A0)),
                  FeatureItem(
                      title: "Table Fan",
                      icon: Icons.toys,
                      color: Color(0xFFC9C2FF)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Section title widget
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
      ),
    );
  }
}

// Feature card widget
class FeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const FeatureItem({
    required this.title,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 40,
              color: Colors.brown,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}

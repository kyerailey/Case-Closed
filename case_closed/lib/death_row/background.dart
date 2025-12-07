import 'package:flutter/material.dart';
import '../main.dart'; 
import 'scene.dart'; 

class DeathRowBackground extends StatelessWidget {
  const DeathRowBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('CASE FILE: #001')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "DEATH ON THE ROW HOUSE",
                  style: theme.textTheme.headlineMedium?.copyWith(fontSize: 24, color: AppColors.accent),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              
              // VICTIM PHOTO PLACEHOLDER
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 60, color: Colors.white24),
                      Text("Victim: Ethan", style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text("THE SCENARIO", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)),
              const Divider(color: AppColors.accent),
              const SizedBox(height: 10),
              const Text(
                "Ethan was a new pledge. At 12:15 AM, he fell from the second-story balcony. Police ruled it 'accidental due to intoxication', but anonymous tips suggest he was pushed.\n\nYou have 24 hours to investigate the scene before it is cleaned.",
                style: TextStyle(fontSize: 16, height: 1.6, color: Colors.white70),
              ),
              const SizedBox(height: 20),

              const Text("SUSPECTS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)),
              const Divider(color: AppColors.accent),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.surface.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "• Tyler Bishop (Big Brother)\n• Mason Duquette (President)\n• Jenna Ward (Ex-Girlfriend)\n• Prof. Adrian Kline",
                  style: TextStyle(fontSize: 15, height: 1.8, color: Colors.white, fontFamily: 'Monospace'),
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.search, color: AppColors.textMain),
                  label: const Text("ENTER CRIME SCENE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DeathRowScene()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
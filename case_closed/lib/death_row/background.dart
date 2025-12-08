import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors
import 'scene.dart'; 

class DeathRowBackground extends StatelessWidget {
  const DeathRowBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // Styles for the report to make it look official
    const labelStyle = TextStyle(
      color: Colors.white54, 
      fontSize: 12, 
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    );
    const dataStyle = TextStyle(
      color: Colors.white, 
      fontSize: 16, 
      fontFamily: 'Courier', // Typewriter look
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('OFFICIAL CASE FILE'),
        backgroundColor: const Color(0xFF0F202E),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withOpacity(0.8), width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                "DECEASED",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------------------------------------
              // 1. VICTIM PROFILE (Top Section)
              // ---------------------------------------------------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PHOTO (Left)
                  Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      border: Border.all(color: Colors.white24, width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(2, 2))],
                      // If you have a specific victim image, switch the child to Image.asset
                    ),
                    child: const Icon(Icons.person, size: 60, color: Colors.white12),
                  ),
                  
                  const SizedBox(width: 24),

                  // STATS (Right)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("NAME", style: labelStyle),
                        const Text("Ethan Ward", style: dataStyle),
                        const SizedBox(height: 12),
                        
                        const Text("AGE", style: labelStyle),
                        const Text("19", style: dataStyle),
                        const SizedBox(height: 12),

                        const Text("MAJOR", style: labelStyle),
                        const Text("Political Science", style: dataStyle),
                        const SizedBox(height: 12),

                        const Text("AFFILIATION", style: labelStyle),
                        const Text("Delta Sigma (Pledge)", style: dataStyle),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Divider(color: Colors.white24),
              const SizedBox(height: 20),

              // ---------------------------------------------------
              // 2. FACTS OF THE CASE (Full Width)
              // ---------------------------------------------------
              const Row(
                children: [
                  Icon(Icons.assignment, color: AppColors.accent, size: 20),
                  SizedBox(width: 10),
                  Text(
                    "INCIDENT REPORT SUMMARY",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: AppColors.textMain, 
                      letterSpacing: 1.2
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // The Narrative Text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.3),
                  border: Border.all(color: Colors.white10),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 15, height: 1.6, color: Colors.white70, fontFamily: 'Roboto'),
                    children: [
                      TextSpan(text: "TIMELINE:\n", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      TextSpan(text: "At approximately 00:15 hours, patrols responded to a distress call at the Delta Sigma fraternity house. The subject, Ethan Ward, was found unresponsive on the concrete patio directly below the second-story balcony.\n\n"),
                      
                      TextSpan(text: "INITIAL ASSESSMENT:\n", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      TextSpan(text: "First responders pronounced the subject dead at the scene. While intoxication was a factor (BAC .18), the Medical Examiner noted blunt force trauma to the upper back consistent with a shove, not a stumble.\n\n"),
                      
                      TextSpan(text: "CURRENT STATUS:\n", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      TextSpan(text: "The scene has been frozen. Frat brothers are being held for questioning. Anonymous tips suggest a hazing ritual gone wrong."),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),

              // ---------------------------------------------------
              // 3. ACTION BUTTON
              // ---------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  icon: const Icon(Icons.search),
                  label: const Text(
                    "ENTER CRIME SCENE",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                  ),
                  onPressed: () {
                    // Navigate to the Scene
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DeathRowScene()),
                    );
                  },
                ),
              ),
              
              // Helper text
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Center(
                  child: Text(
                    "Warning: Contains graphic descriptions.",
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
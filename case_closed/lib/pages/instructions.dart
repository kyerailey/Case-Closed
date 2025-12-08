import 'package:flutter/material.dart';
import '../main.dart'; // Import to access AppColors
// Import the Background Page so we can link to it
import '../death_row/background.dart'; 

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(
        title: const Text("Field Guide"),
        backgroundColor: AppColors.background,
        elevation: 0,
        
        // ****************************************************
        // NEW: CASE REVIEW BUTTON (Top Right)
        // ****************************************************
        actions: [
          IconButton(
            icon: const Icon(Icons.description), // File Document Icon
            tooltip: "Review Case File",
            onPressed: () {
              // Navigate to the Background Story Page
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const DeathRowBackground())
              );
            },
          ),
        ],
      ),
      
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.menu_book, size: 50, color: AppColors.accent),
                      const SizedBox(height: 10),
                      Text(
                        "INVESTIGATOR MANUAL",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Standard Operating Procedures",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // 2. THE SECTIONS
                _buildSection(
                  icon: Icons.search,
                  title: "1. The Scene",
                  content: "Tap hotspots to examine objects. Clues in this game are factual observations—they will not tell you the answer directly. You must look at an object (e.g., a receipt) and deduce what it means yourself.",
                ),
                
                _buildSection(
                  icon: Icons.person_search,
                  title: "2. The Suspects",
                  content: "Tap a suspect to view their file. Use the 'Search Suspect/Room' button to find hidden evidence on their person or in their belongings. Cross-reference their personal effects with items found at the scene.",
                ),

                _buildSection(
                  icon: Icons.inventory,
                  title: "3. The Evidence",
                  content: "Items you collect are stored in your Evidence Bag. You will need to select specific items later to prove your case to the Judge.",
                ),

                _buildSection(
                  icon: Icons.gavel,
                  title: "4. Filing a Warrant",
                  content: "To win, you must file a Warrant Application. You must correctly identify:\n\n"
                           "• The Suspect\n"
                           "• The Key Evidence (The 'Smoking Gun')\n"
                           "• The Correct Motive\n\n"
                           "If any detail is wrong, the District Attorney will reject your case.",
                ),

                const Divider(color: AppColors.accent),
                const SizedBox(height: 20),

                // 3. PRO TIPS
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.lightbulb, color: Colors.yellowAccent),
                          SizedBox(width: 10),
                          Text(
                            "CRITICAL THINKING TIPS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "• Don't trust what suspects say; trust the physics of the scene.\n"
                        "• Timestamps are crucial. Compare receipt times to the time of death.\n"
                        "• Not all evidence is visible on the floor; you must search the suspects.",
                        style: TextStyle(color: Colors.grey[300], height: 1.5),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // CLOSE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white10,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("CLOSE MANUAL"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required IconData icon, required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.accent, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
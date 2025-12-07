import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
const InstructionsScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF2B4059),

  appBar: AppBar(
    backgroundColor: const Color(0xFF2B4059),
    elevation: 0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    title: const Text(
      "Instructions",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  body: Center(
    child: SingleChildScrollView(
      child: Container(
        width: 500, // centered card width (adjust for mobile/tablet)
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),

        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start, // ← KEY CHANGE (left-align text)
          children: [

            // Header (centered)
            Center(
              child: Text(
                "Case CLOSED Instructions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Goal
            Text(
              "Goal:",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Explore the scene, collect clues, study suspects, and solve who committed the murder — and why.\n",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17,
                color: Colors.white,
                height: 1.4,
              ),
            ),

            // 1. Crime Scene
            Text(
              "1. Crime Scene",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "• Click hotspots to uncover clues or objects.\n"
              "• Each item you collect is saved in the Evidence tab.\n"
              "• Some hotspots unlock after others — look carefully!\n",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17,
                color: Colors.white,
                height: 1.4,
              ),
            ),

            // 2. Suspects
            Text(
              "2. Suspects",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "• Tap a suspect’s name to open their profile.\n"
              "• Each includes:\n"
              "  • Alibi – where they were\n"
              "  • Motive – why they might kill\n"
              "  • History – past behavior or secrets\n"
              "• Compare their stories with your evidence.\n",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17,
                color: Colors.white,
                height: 1.4,
              ),
            ),

            // 3. Evidence
            Text(
              "3. Evidence",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "• Review all collected clues here.\n"
              "• Click items for details.\n"
              "• Match evidence to suspects to reveal contradictions and truths.\n",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17,
                color: Colors.white,
                height: 1.4,
              ),
            ),

            // 4. Solve the Case
            Text(
              "4. Solve the Case",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "When ready, name the culprit, their motive, and the key evidence that proves it.\n",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17,
                color: Colors.white,
                height: 1.4,
              ),
            ),

            // Tips
            Text(
              "💡 Tips",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "• Check all hotspots.\n"
              "• Revisit suspects after finding new clues.\n"
              "• Think like a detective — connect motives, lies, and proof.\n",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 17,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

}
}

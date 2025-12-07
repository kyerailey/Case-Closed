import 'package:flutter/material.dart';
import 'intro.dart'; // <--- 1. Import the file so we can access IntroPage

class CommonCasesScreen extends StatelessWidget {
  const CommonCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B4059), 
      
      body: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 450,
            maxHeight: 300,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            // The darker "Midnight Blue" you liked
            color: const Color(0xFF1A2639), 
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
              width: 8, 
            ),
          ),
          child: Stack(
            children: [
              // The Content Text
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    "The truth hides in the shadows, but not for long.\nReturn once the evidence is ready to be revealed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: Color(0xFFEE7674), 
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4.0,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // The Close (X) Button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 32),
                  color: Colors.white,
                  onPressed: () {
                    // 2. FORCE navigate back to IntroPage
                    // We use pushReplacement so you don't get a white screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IntroPage(), // <--- Matches your class name
                      ),
                    );
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
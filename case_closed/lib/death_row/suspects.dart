import 'package:flutter/material.dart';

class SuspectsTab extends StatefulWidget {
  const SuspectsTab({super.key});
  @override
  State<SuspectsTab> createState() => _SuspectsTabState();
}

class _SuspectsTabState extends State<SuspectsTab> {
  final List<Map<String, String>> suspects = [
    {
      "name": "Tyler Bishop", "role": "The 'Big Brother'",
      "alibi": "Claims he was in the kitchen cutting limes.",
      "motive": "Ethan threatened to report hazing violations.",
      "notes": "Personal Effects: Wallet contains Visa ending in #8842. Right arm has fresh linear abrasions.",
      "image": "assets/images/suspect_tyler.png", 
    },
    {
      "name": "Mason Duquette", "role": "Frat President",
      "alibi": "Seen on CCTV in backyard (11:55 PM - 12:20 AM).",
      "motive": "Protecting fraternity reputation.",
      "notes": "Room Search: Door found open. 'Benzodiazepine' vials found in desk, but no fingerprints on them.",
      "image": "assets/images/suspect_mason.png",
    },
    {
      "name": "Jenna Ward", "role": "Ex-Girlfriend",
      "alibi": "Traffic cam shows her car leaving campus at 11:59 PM.",
      "motive": "Anger over breakup.",
      "notes": "Forensics: Fingerprints on balcony railing match hers, but dust analysis suggests they are 4+ hours old.",
      "image": "assets/images/suspect_jenna.png",
    },
    {
      "name": "Prof. Adrian Kline", "role": "Faculty Advisor",
      "alibi": "Faculty Dinner downtown.",
      "motive": "Ethan discovered academic fraud.",
      "notes": "Personal Effects: Receipt from 'The Golden Steakhouse' timestamped 12:05 AM. Distance: 15 miles.",
      "image": "assets/images/suspect_kline.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFBFB5AF),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: suspects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final s = suspects[index];
          return GestureDetector(
            onTap: () => showDialog(context: context, builder: (_) => SuspectCarouselDialog(suspects: suspects, startIndex: index)),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(
                    width: 70, height: 70,
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(s["image"]??""), fit: BoxFit.cover, onError: (_,__) {})),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(s["name"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)), Text(s["role"]!, style: const TextStyle(fontSize: 14, color: Colors.black54))],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SuspectCarouselDialog extends StatefulWidget {
  final List<Map<String, String>> suspects;
  final int startIndex;
  const SuspectCarouselDialog({super.key, required this.suspects, required this.startIndex});
  @override
  State<SuspectCarouselDialog> createState() => _SuspectCarouselDialogState();
}

class _SuspectCarouselDialogState extends State<SuspectCarouselDialog> {
  late int currentIndex;
  @override
  void initState() { super.initState(); currentIndex = widget.startIndex; }

  @override
  Widget build(BuildContext context) {
    final suspect = widget.suspects[currentIndex];
    return Dialog(
      backgroundColor: Colors.transparent, insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFF5F7FA), borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("SUSPECT FILE #${currentIndex + 1}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
              IconButton(icon: const Icon(Icons.close, color: Colors.black), onPressed: () => Navigator.pop(context)),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 100, height: 120, decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(10), image: DecorationImage(image: AssetImage(suspect["image"]??""), fit: BoxFit.cover, onError: (_,__) {}))),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _row("Name:", suspect["name"]!), const SizedBox(height: 8),
                _row("Alibi:", suspect["alibi"]!), const SizedBox(height: 8),
                _row("Motive:", suspect["motive"]!),
              ])),
            ]),
            const SizedBox(height: 12),
            Container(padding: const EdgeInsets.all(10), width: double.infinity, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)), child: Text("NOTES:\n${suspect['notes']}", style: TextStyle(fontSize: 13, color: Colors.grey.shade800))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C3E50), foregroundColor: Colors.white),
                icon: const Icon(Icons.assignment_turned_in),
                label: const Text("BUILD CASE (FILE WARRANT)"),
                onPressed: () { Navigator.pop(context); Navigator.pushNamed(context, '/Warrant'); },
              ),
            ),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              currentIndex > 0 ? IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => setState(() => currentIndex--)) : const SizedBox(width: 48),
              currentIndex < widget.suspects.length - 1 ? IconButton(icon: const Icon(Icons.arrow_forward, color: Colors.black), onPressed: () => setState(() => currentIndex++)) : const SizedBox(width: 48),
            ]),
          ],
        ),
      ),
    );
  }
  Widget _row(String l, String v) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)), Text(v, style: const TextStyle(fontSize: 14, color: Colors.black54))]);
}
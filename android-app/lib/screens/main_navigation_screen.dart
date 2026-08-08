import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tap_bpm_screen.dart';
import 'audio_analyzer_screen.dart';
import 'metronome_screen.dart';
import 'delay_reverb_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TapBpmScreen(),
    AudioAnalyzerScreen(),
    MetronomeScreen(),
    DelayReverbScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.border, width: 1.0)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.touch_app_outlined),
              activeIcon: Icon(Icons.touch_app_rounded),
              label: 'Tap BPM',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer_outlined),
              activeIcon: Icon(Icons.equalizer_rounded),
              label: 'Analyzer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer_outlined),
              activeIcon: Icon(Icons.timer_rounded),
              label: 'Metronome',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined),
              activeIcon: Icon(Icons.calculate_rounded),
              label: 'Calculator',
            ),
          ],
        ),
      ),
    );
  }
}

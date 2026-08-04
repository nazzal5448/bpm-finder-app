import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class MetronomeScreen extends StatefulWidget {
  const MetronomeScreen({super.key});

  @override
  State<MetronomeScreen> createState() => _MetronomeScreenState();
}

class _MetronomeScreenState extends State<MetronomeScreen> {
  int _bpm = 120;
  bool _isPlaying = false;
  int _beatsPerMeasure = 4;
  int _currentBeat = 0;
  Timer? _metronomeTimer;

  final List<String> _timeSignatures = ['2/4', '3/4', '4/4', '6/8'];

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _startMetronome();
    } else {
      _stopMetronome();
    }
  }

  void _startMetronome() {
    _stopMetronome();
    final intervalMs = (60000 / _bpm).round();
    _metronomeTimer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      if (mounted) {
        setState(() {
          _currentBeat = (_currentBeat + 1) % _beatsPerMeasure;
        });
        if (_currentBeat == 0) {
          HapticFeedback.heavyImpact();
        } else {
          HapticFeedback.lightImpact();
        }
      }
    });
  }

  void _stopMetronome() {
    _metronomeTimer?.cancel();
    setState(() {
      _currentBeat = 0;
    });
  }

  void _updateBpm(int newBpm) {
    setState(() {
      _bpm = newBpm.clamp(30, 300);
    });
    if (_isPlaying) {
      _startMetronome();
    }
  }

  @override
  void dispose() {
    _stopMetronome();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BPM Finder - Tap Metronome'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Beat Lights Indicator Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_beatsPerMeasure, (index) {
                    final isActive = _isPlaying && _currentBeat == index;
                    final isAccent = index == 0;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 60),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isActive
                            ? (isAccent ? AppTheme.primary : AppTheme.accent)
                            : AppTheme.surfaceVariant,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive ? AppTheme.textPrimary : AppTheme.border,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isActive ? Colors.white : AppTheme.textSecondary,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              // BPM Large Display Card
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      '$_bpm',
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontSize: 72,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2.0,
                      ),
                    ),
                    const Text(
                      'BPM TEMPO',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Slider & Adjusters
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    onPressed: () => _updateBpm(_bpm - 1),
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Slider(
                      value: _bpm.toDouble(),
                      min: 30,
                      max: 300,
                      divisions: 270,
                      activeColor: AppTheme.primary,
                      inactiveColor: AppTheme.border,
                      onChanged: (val) => _updateBpm(val.round()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton.filledTonal(
                    onPressed: () => _updateBpm(_bpm + 1),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Time Signature Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _timeSignatures.map((sig) {
                  final beats = int.parse(sig.split('/')[0]);
                  final isSelected = _beatsPerMeasure == beats;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(sig),
                      selected: isSelected,
                      selectedColor: AppTheme.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _beatsPerMeasure = beats;
                            _currentBeat = 0;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              // Giant Play / Pause Button
              ElevatedButton.icon(
                onPressed: _togglePlay,
                icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 32),
                label: Text(_isPlaying ? 'PAUSE METRONOME' : 'START METRONOME'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPlaying ? AppTheme.textPrimary : AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 0.8),
                  elevation: 0,
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

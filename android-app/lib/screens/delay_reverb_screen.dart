import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DelayReverbScreen extends StatefulWidget {
  const DelayReverbScreen({super.key});

  @override
  State<DelayReverbScreen> createState() => _DelayReverbScreenState();
}

class _DelayReverbScreenState extends State<DelayReverbScreen> {
  int _bpm = 120;

  double get _quarterNoteMs => 60000 / _bpm;
  double get _eighthNoteMs => _quarterNoteMs / 2;
  double get _sixteenthNoteMs => _quarterNoteMs / 4;
  double get _dottedEighthMs => _quarterNoteMs * 0.75;
  double get _tripletEighthMs => (_quarterNoteMs * 2) / 3;

  double get _tightPredelayMs => _sixteenthNoteMs / 2;
  double get _naturalPredelayMs => _sixteenthNoteMs;
  double get _spaciousPredelayMs => _eighthNoteMs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delay & Reverb Calculator'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // BPM Input Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SONG TEMPO (BPM)',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          '$_bpm BPM',
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: _bpm.toDouble(),
                      min: 40,
                      max: 240,
                      divisions: 200,
                      activeColor: AppTheme.primary,
                      inactiveColor: AppTheme.border,
                      onChanged: (val) {
                        setState(() {
                          _bpm = val.round();
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Delay Note Divisions Section
              const Text(
                'DELAY NOTE DIVISIONS',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),

              _buildTimingRow('Quarter Note (1/4)', _quarterNoteMs),
              _buildTimingRow('Eighth Note (1/8)', _eighthNoteMs),
              _buildTimingRow('Dotted Eighth (1/8d)', _dottedEighthMs),
              _buildTimingRow('Triplet Eighth (1/8t)', _tripletEighthMs),
              _buildTimingRow('Sixteenth Note (1/16)', _sixteenthNoteMs),

              const SizedBox(height: 24),

              // Reverb Pre-Delay Section
              const Text(
                'REVERB PRE-DELAY SETTINGS',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),

              _buildTimingRow('Tight Vocal Pre-Delay', _tightPredelayMs),
              _buildTimingRow('Natural Room Pre-Delay', _naturalPredelayMs),
              _buildTimingRow('Spacious Hall Pre-Delay', _spaciousPredelayMs),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimingRow(String label, double valueMs) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppTheme.border, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${valueMs.toStringAsFixed(1)} ms',
            style: const TextStyle(
              color: AppTheme.primary,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

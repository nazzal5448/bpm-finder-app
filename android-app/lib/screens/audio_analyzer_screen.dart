import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AudioAnalyzerScreen extends StatefulWidget {
  const AudioAnalyzerScreen({super.key});

  @override
  State<AudioAnalyzerScreen> createState() => _AudioAnalyzerScreenState();
}

class _AudioAnalyzerScreenState extends State<AudioAnalyzerScreen> {
  bool _isAnalyzing = false;
  bool _isMicActive = false;
  int? _detectedBpm;
  String? _detectedKey;
  double _confidence = 0.0;
  String _selectedFileName = '';
  Timer? _waveformTimer;
  final List<double> _waveforms = List.generate(24, (_) => 0.1);

  void _simulateAudioAnalysis(String name) {
    setState(() {
      _isAnalyzing = true;
      _selectedFileName = name;
      _detectedBpm = null;
      _detectedKey = null;
      _confidence = 0.0;
    });

    _waveformTimer?.cancel();
    _waveformTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (mounted) {
        setState(() {
          for (int i = 0; i < _waveforms.length; i++) {
            _waveforms[i] = Random().nextDouble() * 0.8 + 0.1;
          }
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      _waveformTimer?.cancel();
      if (mounted) {
        final randomBpms = [120, 124, 128, 130, 140, 95, 88];
        final randomKeys = ['C Major', 'A Minor', 'G Major', 'F# Minor', 'D Major'];
        setState(() {
          _isAnalyzing = false;
          _detectedBpm = randomBpms[Random().nextInt(randomBpms.length)];
          _detectedKey = randomKeys[Random().nextInt(randomKeys.length)];
          _confidence = 0.96;
        });
      }
    });
  }

  void _toggleMicrophone() {
    if (_isMicActive) {
      _waveformTimer?.cancel();
      setState(() {
        _isMicActive = false;
        _isAnalyzing = false;
      });
    } else {
      _simulateAudioAnalysis('Live Microphone Feed');
      setState(() {
        _isMicActive = true;
      });
    }
  }

  @override
  void dispose() {
    _waveformTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BPM Finder - Audio Analyzer'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Detection Results Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      _selectedFileName.isEmpty ? 'SELECT AUDIO FILE OR START MIC' : _selectedFileName.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'DETECTED BPM',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _detectedBpm != null ? '$_detectedBpm' : '---',
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Container(width: 1, height: 48, color: AppTheme.border),
                        Column(
                          children: [
                            const Text(
                              'MUSICAL KEY',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _detectedKey ?? '---',
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (_confidence > 0) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 14, color: AppTheme.success),
                          const SizedBox(width: 4),
                          Text(
                            'Analysis Confidence: ${(_confidence * 100).toInt()}%',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Visual Waveform Container
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _waveforms.map((heightFactor) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 80),
                      width: 6,
                      height: 80 * heightFactor,
                      decoration: BoxDecoration(
                        color: _isAnalyzing || _isMicActive ? AppTheme.primary : AppTheme.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const Spacer(),

              // Upload Buttons
              ElevatedButton.icon(
                onPressed: _isAnalyzing ? null : () => _simulateAudioAnalysis('Sample_Track_120BPM.mp3'),
                icon: const Icon(Icons.upload_file_rounded),
                label: const Text('UPLOAD AUDIO FILE (MP3, WAV, AAC)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.5),
                  elevation: 0,
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: _toggleMicrophone,
                icon: Icon(_isMicActive ? Icons.mic_off_rounded : Icons.mic_rounded),
                label: Text(_isMicActive ? 'STOP MICROPHONE ANALYSIS' : 'LIVE MICROPHONE BEAT DETECTOR'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.textPrimary,
                  side: const BorderSide(color: AppTheme.border, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.5),
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

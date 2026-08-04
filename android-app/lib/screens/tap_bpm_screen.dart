import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class TapBpmScreen extends StatefulWidget {
  const TapBpmScreen({super.key});

  @override
  State<TapBpmScreen> createState() => _TapBpmScreenState();
}

class _TapBpmScreenState extends State<TapBpmScreen> {
  final List<DateTime> _tapTimes = [];
  int? _calculatedBpm;
  double? _avgIntervalMs;
  int _tapCount = 0;
  bool _isTapping = false;

  void _registerTap() {
    HapticFeedback.lightImpact();
    final now = DateTime.now();

    setState(() {
      // If last tap was more than 3 seconds ago, reset
      if (_tapTimes.isNotEmpty && now.difference(_tapTimes.last).inMilliseconds > 3000) {
        _tapTimes.clear();
      }

      _tapTimes.add(now);
      _tapCount = _tapTimes.length;
      _isTapping = true;

      if (_tapTimes.length >= 2) {
        final intervals = <int>[];
        for (int i = 1; i < _tapTimes.length; i++) {
          intervals.add(_tapTimes[i].difference(_tapTimes[i - 1]).inMilliseconds);
        }
        final sum = intervals.reduce((a, b) => a + b);
        _avgIntervalMs = sum / intervals.length;
        if (_avgIntervalMs! > 0) {
          _calculatedBpm = (60000 / _avgIntervalMs!).round();
        }
      }
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _isTapping = false;
        });
      }
    });
  }

  void _resetTaps() {
    HapticFeedback.mediumImpact();
    setState(() {
      _tapTimes.clear();
      _calculatedBpm = null;
      _avgIntervalMs = null;
      _tapCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BPM Finder - Tap Tempo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset Taps',
            onPressed: _resetTaps,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Metric Display Card
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Column(
                  children: [
                    const Text(
                      'CALCULATED TEMPO',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _calculatedBpm != null ? '$_calculatedBpm' : '---',
                      style: TextStyle(
                        color: _calculatedBpm != null ? AppTheme.primary : AppTheme.textSecondary,
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                    Text(
                      'BEATS PER MINUTE',
                      style: TextStyle(
                        color: _calculatedBpm != null ? AppTheme.primary : AppTheme.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Total Taps', '$_tapCount'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Avg Interval',
                      _avgIntervalMs != null ? '${_avgIntervalMs!.round()} ms' : '---',
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Giant Tactile Tap Button
              GestureDetector(
                onTapDown: (_) => _registerTap(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  height: 180,
                  decoration: BoxDecoration(
                    color: _isTapping ? AppTheme.primaryHover : AppTheme.primary,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppTheme.textPrimary, width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.touch_app_rounded,
                          size: 48,
                          color: _isTapping ? Colors.white70 : Colors.white,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _tapCount == 0 ? 'TAP TO COUNT BPM' : 'KEEP TAPPING...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppTheme.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

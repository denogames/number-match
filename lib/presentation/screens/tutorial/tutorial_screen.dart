import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/analytics/analytics_event.dart';
import '../../../application/providers.dart';
import '../../common/widgets/app_button.dart';

class TutorialScreen extends ConsumerStatefulWidget {
  const TutorialScreen({super.key});

  @override
  ConsumerState<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends ConsumerState<TutorialScreen> {
  int _currentStep = 0;

  // Mini tutorial board states for each step
  // Step 0: Identical numbers (4, 4)
  // Step 1: Sum to 10 (3, 7)
  // Step 2: Row Wrap (last cell of row 1 and first cell of row 2)
  // Step 3: Add Numbers

  List<int> _boardValues = [4, 4, 3, 7];
  Set<int> _cleared = {};
  int? _selected;
  bool _stepCompleted = false;

  final List<Map<String, String>> _stepsInfo = [
    {
      'title': '1. Match Identical Numbers',
      'instruction': 'Tap both 4s to match them. Identical numbers clear each other!',
    },
    {
      'title': '2. Numbers That Sum to 10',
      'instruction': 'Tap 3 and 7! Any two numbers whose sum is exactly 10 make a valid pair.',
    },
    {
      'title': '3. Reading Order & Row Wrapping',
      'instruction': 'Pairs can match across row ends to row beginnings in reading order!',
    },
    {
      'title': '4. Add Numbers',
      'instruction': 'When you run out of moves, tap "Add Numbers" to duplicate remaining numbers to the bottom.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupStep(0);
    ref.read(analyticsServiceProvider).logEvent(AnalyticsEventType.tutorialStarted);
  }

  void _setupStep(int step) {
    setState(() {
      _currentStep = step;
      _selected = null;
      _stepCompleted = false;

      switch (step) {
        case 0:
          _boardValues = [4, 4, 1, 2];
          _cleared = {};
          break;
        case 1:
          _boardValues = [3, 7, 2, 8];
          _cleared = {};
          break;
        case 2:
          _boardValues = [
            1, 2, 3, 4, 5, 6, 7, 8, 9,
            9, 5, 5, 2, 1, 3, 4, 6, 7,
          ];
          _cleared = {};
          break;
        case 3:
          _boardValues = [2, 8];
          _cleared = {};
          break;
      }
    });
  }

  void _handleCellTap(int index) {
    if (_cleared.contains(index)) return;

    final haptics = ref.read(hapticServiceProvider);
    final audio = ref.read(audioServiceProvider);

    if (_selected == null) {
      setState(() => _selected = index);
      haptics.selection();
      audio.playSelect();
      return;
    }

    if (_selected == index) {
      setState(() => _selected = null);
      haptics.selection();
      return;
    }

    final first = _selected!;
    final val1 = _boardValues[first];
    final val2 = _boardValues[index];

    final isMatch = (val1 == val2) || (val1 + val2 == 10);

    if (isMatch) {
      haptics.matchSuccess();
      audio.playMatch();
      setState(() {
        _cleared.add(first);
        _cleared.add(index);
        _selected = null;
        _stepCompleted = true;
      });
    } else {
      haptics.invalid();
      audio.playInvalid();
      setState(() => _selected = null);
    }
  }

  void _nextStep() {
    if (_currentStep < _stepsInfo.length - 1) {
      _setupStep(_currentStep + 1);
    } else {
      _finishTutorial();
    }
  }

  Future<void> _finishTutorial() async {
    final prefs = ref.read(preferencesProvider);
    await prefs.setTutorialCompleted(true);
    await ref.read(analyticsServiceProvider).logEvent(AnalyticsEventType.tutorialCompleted);
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;
    final info = _stepsInfo[_currentStep];

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: theme.textPrimary,
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'How to Play',
          style: TextStyle(
            fontSize: 18.0 * settings.textScale,
            fontWeight: FontWeight.w700,
            color: theme.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _finishTutorial,
            child: Text(
              'Skip',
              style: TextStyle(
                color: theme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Bar
              LinearProgressIndicator(
                value: (_currentStep + 1) / _stepsInfo.length,
                backgroundColor: theme.surfaceSubtle,
                valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 24),

              // Step Title Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info['title']!,
                      style: TextStyle(
                        fontSize: 18.0 * settings.textScale,
                        fontWeight: FontWeight.w900,
                        color: theme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      info['instruction']!,
                      style: TextStyle(
                        fontSize: 14.0 * settings.textScale,
                        color: theme.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Interactive Practice Board
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.surfaceSubtle,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme.divider),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _boardValues.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _currentStep == 2 ? 9 : 4,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      final val = _boardValues[index];
                      final isCleared = _cleared.contains(index);
                      final isSelected = _selected == index;

                      if (isCleared) {
                        return Container(
                          decoration: BoxDecoration(
                            color: theme.cellCleared,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }

                      return InkWell(
                        onTap: () => _handleCellTap(index),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.cellSelectedBackground
                                : theme.cellBackground,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? theme.cellSelectedBorder
                                  : theme.cellBorder,
                              width: isSelected ? 2.5 : 1.2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$val',
                            style: TextStyle(
                              fontSize: 20.0 * settings.textScale,
                              fontWeight: isSelected
                                  ? FontWeight.w900
                                  : FontWeight.w700,
                              color: isSelected
                                  ? theme.cellSelectedText
                                  : theme.cellText,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Step Completion Indicator or Next Button
              if (_currentStep == 3) ...[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.accent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  label: const Text('Simulate "Add Numbers"'),
                  onPressed: () {
                    setState(() {
                      _boardValues = [..._boardValues, ..._boardValues];
                      _stepCompleted = true;
                    });
                  },
                ),
                const SizedBox(height: 10),
              ],

              AppButton(
                label: _currentStep == _stepsInfo.length - 1
                    ? 'Start Playing!'
                    : 'Next Step',
                icon: Icons.arrow_forward_rounded,
                isFullWidth: true,
                onPressed: _stepCompleted || _currentStep == 3
                    ? _nextStep
                    : null,
                textScale: settings.textScale,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

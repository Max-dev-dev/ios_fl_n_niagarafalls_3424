import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ios_fl_n_niagarafalls_3424/models/quiz_models.dart';

class ShadowQuizScreen extends StatefulWidget {
  const ShadowQuizScreen({super.key});

  @override
  State<ShadowQuizScreen> createState() => _ShadowQuizScreenState();
}

class _ShadowQuizScreenState extends State<ShadowQuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _answered = false;
  bool _isCorrect = false;

  late List<ShadowQuizQuestion> _questions;

  @override
  void initState() {
    super.initState();
    _questions = _loadQuestions();
  }

  List<ShadowQuizQuestion> _loadQuestions() {
    return [
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/1_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_a.png',
            isCorrect: true,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_b.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_c.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_d.png',
            isCorrect: false,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/2_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_a.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_b.png',
            isCorrect: true,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_c.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_d.png',
            isCorrect: false,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/3_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_a.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_b.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_c.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_d.png',
            isCorrect: true,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/4_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_a.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_b.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_c.png',
            isCorrect: true,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_d.png',
            isCorrect: false,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/5_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/5.png',
            isCorrect: true,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/3.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_c.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_d.png',
            isCorrect: false,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/6_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/5.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/3.png',
            isCorrect: true,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_c.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1_d.png',
            isCorrect: false,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/7_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/2.png',
            isCorrect: true,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/7.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/4.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1.png',
            isCorrect: false,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/8_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/2.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/7.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/4.png',
            isCorrect: true,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1.png',
            isCorrect: false,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/9_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/2.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/7.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/4.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/1.png',
            isCorrect: true,
          ),
        ],
      ),
      ShadowQuizQuestion(
        shadowAsset: 'assets/images/games/10_q.png',
        options: [
          ShadowQuizOption(
            imageAsset: 'assets/images/games/6.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/7.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/4.png',
            isCorrect: false,
          ),
          ShadowQuizOption(
            imageAsset: 'assets/images/games/2.png',
            isCorrect: true,
          ),
        ],
      ),
    ];
  }

  void _submitAnswer() async {
    if (_selectedOptionIndex == null) return;

    final selected = _questions[_currentIndex].options[_selectedOptionIndex!];
    setState(() {
      _answered = true;
      _isCorrect = selected.isCorrect;
      if (_isCorrect) _score++;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    final isLast = _currentIndex == _questions.length - 1;

    await _showAnswerFeedback(
      correct: _isCorrect,
      correctImage: _getCorrectImage(),
    );

    if (isLast) {
      _showFinalDialog();
    } else {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null;
        _answered = false;
      });
    }
  }

  void _showFinalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Game over',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D583A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Rank',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1D583A)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Observer',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D583A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_score/10',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1D583A),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap:
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ShadowQuizScreen(),
                              ),
                            ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          child: Image.asset(
                            'assets/images/try_again.png',
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          child: Image.asset(
                            'assets/images/leave.png',
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Future<void> _showAnswerFeedback({
    required bool correct,
    required String correctImage,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  if (correct) ...[
                    const Text(
                      'You answered\ncorrectly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D583A),
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Try again',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D583A),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Corrent Answer',
                      style: TextStyle(fontSize: 16, color: Color(0xFF1D583A)),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(correctImage, height: 150),
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ),
    );
  }

  String _getCorrectImage() {
    return _questions[_currentIndex].options
        .firstWhere((o) => o.isCorrect)
        .imageAsset;
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/game_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_currentIndex + 1}/10',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1D583A),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(
                          'assets/images/leave.png',
                          width: 50,
                          height: 50,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(34.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Find the shadow of the waterfall',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1D583A),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(question.shadowAsset, height: 160),
                      const SizedBox(height: 20),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final option = question.options[index];
                          final isSelected = _selectedOptionIndex == index;

                          Color borderColor = Colors.transparent;
                          if (_answered) {
                            borderColor =
                                option.isCorrect
                                    ? Colors.green
                                    : isSelected
                                    ? Colors.red
                                    : Colors.transparent;
                          } else if (isSelected) {
                            borderColor = const Color(0xFFFEC20C);
                          }

                          return GestureDetector(
                            onTap:
                                _answered
                                    ? null
                                    : () => setState(
                                      () => _selectedOptionIndex = index,
                                    ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderColor,
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(option.imageAsset),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      _answered || _selectedOptionIndex == null
                          ? null
                          : _submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedOptionIndex != null
                            ? const Color(0xFFFEC20C)
                            : const Color(0xFF676767),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Answer',
                    style: TextStyle(
                      color:
                          _selectedOptionIndex != null
                              ? Colors.white
                              : const Color(0xFF9C9C9C),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

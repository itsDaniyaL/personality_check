import 'package:flutter/material.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:provider/provider.dart';

class AnswersProgressIndicator extends StatefulWidget {
  const AnswersProgressIndicator({super.key});

  @override
  State<AnswersProgressIndicator> createState() =>
      _AnswersProgressIndicatorState();
}

class _AnswersProgressIndicatorState extends State<AnswersProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AppState state;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 10).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    state = Provider.of<AppState>(context);
    _animateProgress(state.progress);
  }

  void _animateProgress(double newProgress) {
    _animation = Tween<double>(begin: _animation.value, end: newProgress)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: LinearProgressIndicator(
        value: _animation.value,
        semanticsLabel: 'Answers Progress Indicator',
        backgroundColor: const Color(0xFFD9D9D9),
        color: const Color(0xFF000000),
      ),
    );
  }
}

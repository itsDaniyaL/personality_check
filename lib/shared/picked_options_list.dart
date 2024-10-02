import 'package:flutter/material.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:provider/provider.dart';

class PickedOptionsList extends StatelessWidget {
  const PickedOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      final questions = state.questions;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(questions.length, (index) {
          final selectedOption = questions[index].selectedOption != null
              ? questions[index]
                  .options
                  .keys
                  .elementAt(questions[index].selectedOption!)
              : null;
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? 25.0 : 5.0,
                right: index == questions.length - 1 ? 25.0 : 5.0),
            child: SizedBox(
              width: 210,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 210),
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                questions[index]
                                    .title
                                    .replaceAll("\n\nYou:", ""),
                                style: const TextStyle(fontSize: 12)),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xFF1E1515)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedOption ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          );
        })),
      );
    });
  }
}

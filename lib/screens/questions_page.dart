import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personality_checker/screens/getting_started.dart';
import 'package:personality_checker/screens/personality_preview_page.dart';
import 'package:personality_checker/shared/answers_progress_indicator.dart';
import 'package:personality_checker/shared/filled_button.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:provider/provider.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColorLight,
            ),
            onPressed: () {
              showConfirmationDialog(
                context,
              );
            },
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return Consumer<AppState>(builder: (context, state, child) {
            final question = state.currentQuestion;
            final optionsKeys = question.options.keys.toList();

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 15.0),
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : Flex(
                        direction: Axis.vertical,
                        children: [
                          const AnswersProgressIndicator(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Expanded(
                            flex: 6,
                            child: SingleChildScrollView(
                              child: Flex(
                                direction: Orientation.portrait == orientation
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                children: [
                                  Expanded(
                                    flex: Orientation.portrait == orientation
                                        ? 0
                                        : 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: Orientation.landscape ==
                                                  orientation
                                              ? 20.0
                                              : 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          question.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: Orientation.portrait == orientation
                                        ? 0
                                        : 3,
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                            minHeight: 250),
                                        child: IntrinsicHeight(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .dialogBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: List.generate(
                                                    optionsKeys.length,
                                                    (index) {
                                                  var selectedOption = index ==
                                                      question.selectedOption;
                                                  return GestureDetector(
                                                    onTap: () {
                                                      state.selectAnswer(index);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: selectedOption
                                                                ? Theme.of(
                                                                        context)
                                                                    .primaryColorLight
                                                                : Colors
                                                                    .transparent),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 25,
                                                                height: 25,
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: selectedOption
                                                                        ? Colors
                                                                            .transparent
                                                                        : Colors
                                                                            .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: selectedOption
                                                                        ? const Icon(
                                                                            Icons.check,
                                                                            color:
                                                                                Colors.white,
                                                                          )
                                                                        : Text("${index + 1}"),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 12.0),
                                                              Expanded(
                                                                child: Text(
                                                                  optionsKeys[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: selectedOption
                                                                          ? Colors
                                                                              .white
                                                                          : Theme.of(context)
                                                                              .primaryColorLight,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Visibility(
                                visible: state.currentQuestionIndex != 0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomFilledButton(
                                    onPressed: state.currentQuestionIndex == 0
                                        ? null
                                        : state.previousQuestion,
                                    buttonColor:
                                        Theme.of(context).primaryColorLight,
                                    child: const Text("Previous",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomFilledButton(
                                    onPressed: state.checkSelected()
                                        ? null
                                        : () async {
                                            if (state.isLastQuestion) {
                                              await state.finalizePersonality();
                                              if (context.mounted) {
                                                Navigator.push<void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const PersonalityPreviewPage(),
                                                  ),
                                                );
                                              }
                                            } else {
                                              state.nextQuestion();
                                            }
                                          },
                                    buttonColor:
                                        Theme.of(context).primaryColorLight,
                                    child: Text(
                                        state.isLastQuestion
                                            ? "Check"
                                            : "Continue",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            );
          });
        }));
  }

  Future<void> showConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('This will clear all selected answers'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var state = Provider.of<AppState>(context, listen: false);
                await state.clearQuestions();
                if (context.mounted) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const GettingStartedPage(),
                      ),
                      (Route<dynamic> route) => false);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

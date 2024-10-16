import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personality_checker/screens/getting_started.dart';
import 'package:personality_checker/shared/filled_button.dart';
import 'package:personality_checker/shared/picked_options_list.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:provider/provider.dart';

class PersonalityPreviewPage extends StatefulWidget {
  const PersonalityPreviewPage({super.key});

  @override
  State<PersonalityPreviewPage> createState() => _PersonalityPreviewPageState();
}

class _PersonalityPreviewPageState extends State<PersonalityPreviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFilledButton(
        onPressed: () async {
          var state = Provider.of<AppState>(context, listen: false);
          await state.clearQuestions();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const GettingStartedPage(),
              ),
              (Route<dynamic> route) => false);
        },
        buttonColor: Theme.of(context).primaryColorLight,
        child: const Text("Retake",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            )),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Consumer<AppState>(builder: (context, state, child) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      'assets/images/illustration_1.svg',
                      width: 30,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "All done",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "You are more of an",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(state.personalityType,
                                    style:TextStyle(
                                        color: Theme.of(context).secondaryHeaderColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            if (orientation == Orientation.landscape)
                              Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/images/${state.personalityImage()}.svg',
                                  width: 125,
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            state.personalityDescription,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (orientation == Orientation.portrait)
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/${state.personalityImage()}.svg',
                              width: 125,
                            ),
                          ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, top: 15.0, bottom: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your choices",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const PickedOptionsList(),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      'assets/images/illustration_2.svg',
                      width: 60,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      }),
    );
  }
}

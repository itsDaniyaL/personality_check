import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personality_checker/shared/filled_button.dart';
import 'package:personality_checker/shared/picked_options_list.dart';

class PersonalityPreviewPage extends StatefulWidget {
  const PersonalityPreviewPage({super.key});

  @override
  State<PersonalityPreviewPage> createState() => _PersonalityPreviewPageState();
}

class _PersonalityPreviewPageState extends State<PersonalityPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFilledButton(
        onPressed: () {},
        textColor: Colors.white,
        buttonColor: const Color(0xFF1E1515),
        child: const Text("Recheck",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            )),
      ),
      body: Center(
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
                    const Text(
                      "All done",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "You are more of an",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Text("introvert",
                        style: TextStyle(
                            color: Color(0xFFFD9191),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "You feel that living alone is to live happily, and you prefer hiding in a crowd rather than standing out in one. You are perpetually tormented by the idea of doing things wrong, not understanding or not being alert enough or intelligent enough to do what others expect of you. You lack in self-confidence and you seem to believe that others are better than you. While in a conversation, for example, you would be more likely to go along with the other’s points of view as you don’t fully respect your own opinions.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/introvert_illustration.svg',
                        width: 125,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
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
      ),
    );
  }
}

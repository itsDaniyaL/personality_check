import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personality_checker/screens/questions_page.dart';
import 'package:personality_checker/shared/filled_button.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:provider/provider.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future fetchQuestions() async {
    setState(() {
      isLoading = true;
    });
    var state = Provider.of<AppState>(context, listen: false);
    await state.loadQuestionsFromPreferences();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Flex(
            direction: orientation == Orientation.portrait
                ? Axis.vertical
                : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Get started\nwith your\n",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColorLight,)),
                            TextSpan(
                                text: "Personality Check",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).secondaryHeaderColor,)),
                          ]),
                        ),
                        if (orientation == Orientation.landscape)
                          CustomFilledButton(
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const QuestionsPage(),
                                ),
                              );
                            },
                            buttonColor: Theme.of(context).primaryColorLight,
                            child: const Text("Continue",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                      ]),
                ),
              ),
              if (orientation == Orientation.portrait) const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (orientation == Orientation.portrait)
                    CustomFilledButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              await fetchQuestions();
                              if (context.mounted) {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const QuestionsPage(),
                                  ),
                                );
                              }
                            },
                      buttonColor: Theme.of(context).primaryColorLight,
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            )
                          : const Text("Continue",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              )),
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/abstract_shapes.svg',
                      width: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height / 2
                          : MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }
}

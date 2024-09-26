import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personality_checker/screens/questions_page.dart';
import 'package:personality_checker/shared/filled_button.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
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
                          text: const TextSpan(children: [
                            TextSpan(
                                text: "Get started\nwith your\n",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF1E1515))),
                            TextSpan(
                                text: "Personality Check",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFD9191))),
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
                            textColor: Colors.white,
                            buttonColor: const Color(0xFF1E1515),
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
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const QuestionsPage(),
                          ),
                        );
                      },
                      textColor: Colors.white,
                      buttonColor: const Color(0xFF1E1515),
                      child: const Text("Continue",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // if (orientation == Orientation.portrait)
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

import 'package:flutter/material.dart';
import 'package:personality_checker/shared/filled_button.dart';

class QuestionsNavigator extends StatelessWidget {
  const QuestionsNavigator({
    super.key,
    required this.forwardPage,
    required this.validation,
  });

  final Widget forwardPage;
  final bool validation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Row(
        children: [
          Visibility(
            visible: Navigator.canPop(context),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomFilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                buttonColor: Theme.of(context).primaryColorLight,
                textColor: Theme.of(context).secondaryHeaderColor,
                width: 80,
                height: 60,
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
                onPressed: validation
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => forwardPage),
                        );
                      }
                    : null,
                buttonColor: Theme.of(context).primaryColorLight,
                textColor: Theme.of(context).secondaryHeaderColor,
                width: 80,
                height: 60,
                child: const Text("Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

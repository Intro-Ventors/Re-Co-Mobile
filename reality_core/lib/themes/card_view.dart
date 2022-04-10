import 'package:flutter/material.dart';
import 'package:reality_core/models/faq_model.dart';

@immutable
class QuestionCard extends StatelessWidget {
  final Question _question;

  const QuestionCard(this._question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("${_question.query}"))
              ],
            ),
            Row(
              children: [
                Text(_question.answer!,
                    style: Theme.of(context).textTheme.headline6),
                const Spacer(),
              ],
            )
          ],
        ),
      )),
    );
  }
}

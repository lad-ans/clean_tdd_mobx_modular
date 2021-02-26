import 'package:flutter/material.dart';

import '../../../../core/util/injection.dart';
import '../stores/number_trivia_store.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            getConcrete();
          },
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: getConcrete,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: Text('Get random trivia'),
                onPressed: getRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void getConcrete() {
    controller.clear();
    Injection.numberTriviaStore.triviaAndStateSetter(Trivia.concrete);
    Injection.getConcreteNumberTriviaStore(inputStr);
  }

  void getRandom() {
    controller.clear();
    Injection.numberTriviaStore.triviaAndStateSetter(Trivia.random);
    Injection.getRandomNumberTriviaStore();
  }
}

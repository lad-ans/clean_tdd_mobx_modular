import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/util/injection.dart';
import '../stores/number_trivia_store.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Observer(
              builder: (_) {
                final state = Injection.numberTriviaStore.stateSwitcher;
                final trivia = Injection.numberTriviaStore.triviaSwitcher;
                if (state == StoreState.initial) {
                  return MessageDisplay(message: 'Start searching!');
                } else if (state == StoreState.loading) {
                  return Loading();
                } else if (state == StoreState.loaded) {
                  return TriviaDisplay(numberTrivia: trivia);
                } else {
                  return MessageDisplay(message: 'Error');
                }
              },
            ),
            SizedBox(height: 20),
            TriviaControls()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }
}

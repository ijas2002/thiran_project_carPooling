import 'package:flutter/material.dart';
import 'package:thiran_project/learn_block/counterBlock.dart';

class CounterPage extends StatelessWidget {
  //const CounterPage({Key? key}) : super(key: key);
  CounterBloc counterBloc=CounterBloc();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("bloc learning"),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("counter text here"),
            StreamBuilder(
              stream: counterBloc.counterStream,
              builder: (context, snapshot) {
                return Text("${snapshot.data}");
              }
            ),
            FloatingActionButton(onPressed: (){
            counterBloc.eventSink.add(CounterAction.Increment);
            },child: Icon(Icons.add),)
          ],
        ),
      )
    );
  }
}

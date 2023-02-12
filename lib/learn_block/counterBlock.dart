import 'dart:async';
enum CounterAction{Increment}

class CounterBloc{
  late int counter;

  final _stateStreamController = StreamController<int>();

  StreamSink <int> get counterSink => _stateStreamController.sink;
  Stream <int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();

  StreamSink <CounterAction>get eventSink => _eventStreamController.sink;
  Stream <CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc(){
    counter=0;
    eventStream.listen((event) {
      if(event==CounterAction.Increment){
        counter++;
counterSink.add(counter);
      }
    });


}

}
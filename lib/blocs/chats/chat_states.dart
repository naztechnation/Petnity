import 'package:equatable/equatable.dart'; 


abstract class ChatStates extends Equatable {
  const ChatStates();
}

class InitialState extends ChatStates {
  const InitialState();
  @override
  List<Object> get props => [];
}



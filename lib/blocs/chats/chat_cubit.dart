
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/chat_controller.dart';
import '../../requests/repositories/account_repo/account_repository.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit({required this.accountRepository, required this.viewModel})
      : super(const InitialState());
  final AccountRepository accountRepository;
  final MessageController viewModel;

  
}

import 'package:equatable/equatable.dart';
import 'package:petnity/model/account_models/pet_types.dart';

import '../../model/account_models/create_agent.dart';
import '../../model/account_models/auth_data.dart';
import '../../model/account_models/pet_profile.dart';
import '../../model/user_models/service_type.dart';


abstract class AccountStates extends Equatable {
  const AccountStates();
}

class InitialState extends AccountStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class AccountProcessing extends AccountStates {
  @override
  List<Object> get props => [];
}

class AccountLoaded extends AccountStates {
  final AuthData userData;
  const AccountLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class PetProfileLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class PetProfileLoaded extends AccountStates {
  final   PetProfile petData;
  const PetProfileLoaded(this.petData);
  @override
  List<Object> get props => [petData];
}

class AgentResLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class AgentResLoaded extends AccountStates {
  final   CreateAgents agents;
  const AgentResLoaded(this.agents);
  @override
  List<Object> get props => [agents];
}

class AccountUpdated extends AccountStates {
  final AuthData user;
  const AccountUpdated(this.user);
  @override
  List<Object> get props => [user];
}

class AccountPinChanged extends AccountStates {
  final String message;
  const AccountPinChanged(this.message);
  @override
  List<Object> get props => [message];
}

class OTPResent extends AccountStates {
  final String message;
  const OTPResent(this.message);
  @override
  List<Object> get props => [message];
}


class PinResetOTPSent extends AccountStates {
  final String message;
  const PinResetOTPSent(this.message);
  @override
  List<Object> get props => [message];
}

class PinResetOTPVerified extends AccountStates {
  final String message;
  const PinResetOTPVerified(this.message);
  @override
  List<Object> get props => [message];
}

class PinResetCompleted extends AccountStates {
  final String message;
  const PinResetCompleted(this.message);
  @override
  List<Object> get props => [message];
}

class PetTypesLoading extends AccountStates {
  @override
  List<Object> get props => [];
}
 
class PetTypesLoaded extends AccountStates {
  final PetTypesModel services;
  const PetTypesLoaded(this.services);
  @override
  List<Object> get props => [services];
}

class AccountLoggedOut extends AccountStates {
  final String message;
  const AccountLoggedOut(this.message);
  @override
  List<Object> get props => [message];
}

class AccountNetworkErr extends AccountStates {
  final String? message;
  const AccountNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class AccountApiErr extends AccountStates {
  final String? message;
  const AccountApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

import 'package:equatable/equatable.dart';

import '../../model/service_provider_models/create_services_amount.dart';
import '../../model/user_models/create_order.dart';




abstract class ServiceProviderState extends Equatable {
  const ServiceProviderState();
}

class InitialState extends ServiceProviderState {
  const InitialState();
  @override
  List<Object> get props => [];
}



class CreateServiceLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}
 
class CreateServiceLoaded extends ServiceProviderState {
  final CreateOrder createService;
  const CreateServiceLoaded(this.createService);
  @override
  List<Object> get props => [createService];
}

class CreateServiceAmountLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}
 
class CreateServiceAmountLoaded extends ServiceProviderState {
  final ServiceAmount serviceAmount;
  const CreateServiceAmountLoaded(this.serviceAmount);
  @override
  List<Object> get props => [serviceAmount];
}



class CreateServiceNetworkErr extends ServiceProviderState {
  final String? message;
  const CreateServiceNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CreateServiceNetworkErrApiErr extends ServiceProviderState {
  final String? message;
  const CreateServiceNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}




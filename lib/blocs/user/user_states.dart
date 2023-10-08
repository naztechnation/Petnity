import 'package:equatable/equatable.dart';

import '../../model/user_models/reviews_data.dart';
import '../../model/user_models/service_provider_lists.dart';
import '../../model/user_models/service_type.dart';



abstract class UserStates extends Equatable {
  const UserStates();
}

class InitialState extends UserStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class ServiceProviderListLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class ServicesLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ServicesLoaded extends UserStates {
  final GetServiceTypes services;
  const ServicesLoaded(this.services);
  @override
  List<Object> get props => [services];
}
class ServiceProviderListLoaded extends UserStates {
  final ServiceProvidersList userData;
  const ServiceProviderListLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class ReviewLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ReviewLoaded extends UserStates {
  final GetReviews reviews;
  const ReviewLoaded(this.reviews);
  @override
  List<Object> get props => [reviews];
}

class UserNetworkErr extends UserStates {
  final String? message;
  const UserNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class UserNetworkErrApiErr extends UserStates {
  final String? message;
  const UserNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}




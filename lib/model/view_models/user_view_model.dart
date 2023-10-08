 

import '../../res/enum.dart';
import '../user_models/reviews_data.dart';
import '../user_models/service_provider_lists.dart';
import '../user_models/service_type.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
   
   List<ServiceTypes> _services = [];
   List<Agents> _agents = [];
   List<Reviews> _reviews = [];


   Future<void> setServicesList({required List<ServiceTypes> services}) async {
    _services = services;
    setViewState(ViewState.success);
  }
   Future<void> setAgentDetails({required List<Agents> agents}) async {
    _agents = agents;
    setViewState(ViewState.success);
  }
  
  Future<void> setReviews({required List<Reviews> reviews}) async {
    _reviews = reviews;
    setViewState(ViewState.success);
  }

  List<ServiceTypes> get services => _services;
  List<Agents> get agents => _agents;
  List<Reviews> get reviews => _reviews;

   List<ServicesDetails> get servicesItems => servicesResults();
   List<Pets> get servicesPetList => servicesPets();
   

  List<ServicesDetails> servicesResults() {
    List<ServicesDetails> list = [];

    for (var service in _agents ?? []) {
      list.addAll(service.services);
    }

    return list;
  }

   List<Pets> servicesPets() {
    List<Pets> list = [];

    for (var servicePets in _agents ?? []) {
      list.addAll(servicePets.petTypes);
    }

    return list;
  }



}

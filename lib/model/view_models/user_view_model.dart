import 'package:intl/intl.dart';
import 'package:petnity/model/user_models/gallery_data.dart';

import '../../res/enum.dart';
import '../account_models/agents_packages.dart';
import '../user_models/order_list.dart';
import '../user_models/reviews_data.dart';
import '../user_models/service_provider_lists.dart';
import '../user_models/service_type.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  List<ServiceTypes> _services = [];
  List<Packages> _packages = [];
  List<Agents> _agents = [];
  List<Reviews> _reviews = [];
  List<GalleryElements> _gallery = [];
  List<UserOrders> _ordersList = [];

  UserOrderList? _userOrder;

  bool _reviewStatus = false;
  bool _galleryStatus = false;

  Future<void> setOrderList({required UserOrderList orders}) async {
    _userOrder = orders;
    setViewState(ViewState.success);
  }

  Future<void> setServicesList({required List<ServiceTypes> services}) async {
    _services = services;
    setViewState(ViewState.success);
  }

  Future<void> setAgentDetails({required List<Agents> agents}) async {
    _agents = agents;
    setViewState(ViewState.success);
  }

  Future<void> setAgentPackages(
      {required GetAgentsPackages agentPackage}) async {
    _packages = agentPackage.packages ?? [];
    setViewState(ViewState.success);
  }

  Future<void> emptyReviews() async {
    _galleryStatus = false;
    _gallery = [];
    setViewState(ViewState.success);
  }

  Future<void> emptyGallery() async {
    _reviewStatus = false;
    _reviews = [];
    setViewState(ViewState.success);
  }

  Future<void> setReviews({required GetReviews reviews}) async {
    _reviewStatus = reviews.status ?? false;
    _reviews = reviews.reviews ?? [];
    setViewState(ViewState.success);
  }

  Future<void> setGallery({required GalleryAgents gallery}) async {
    _galleryStatus = gallery.status ?? false;
    _gallery = gallery.galleryElements ?? [];
    setViewState(ViewState.success);
  }

  String formatDateTimeToAMPM(String dateTimeString) {
  try {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  } catch (e) {
    print('Error parsing the date string: $e');
    return ''; 
  } 
}

double calculateTimeDifferenceInHours(String startTimeString, String endTimeString) {
  try {
    final startTime = DateTime.parse(startTimeString);
    final endTime = DateTime.parse(endTimeString);

    final difference = endTime.difference(startTime);
    final hoursDifference = difference.inHours.toDouble();

    return hoursDifference;
  } catch (e) {
    print('Error parsing the date strings: $e');
    return 0.0; 
  }
}

  List<ServiceTypes> get services => _services;
  List<Agents> get agents => _agents;
  List<Packages> get packages => _packages;
  List<Reviews> get reviews => _reviews;
  List<GalleryElements> get gallery => _gallery;
  bool get reviewStatus => _reviewStatus;
  bool get galleryStatus => _galleryStatus;
  List<ServicesDetails> get servicesItems => servicesResults();
  List<Pets> get servicesPetList => servicesPets();

  List<UserOrders> get ordersList => _ordersList;

  List<UserOrders> get onGoingOrdersList => onGoingServices();
  List<UserOrders> get onPendingOrderList => onPendingServices();
  List<UserOrders> get onCompletedOrdersList => onCompletedOrderServices();
  List<UserOrders> get onRejectedOrdersList => onRejectedServices();

  List<ServicesDetails> servicesResults() {
    List<ServicesDetails> list = [];

    for (var service in _agents ?? []) {
      list.addAll(service.services);
    }

    return list;
  }

  List<UserOrders> onRejectedServices() {
    List<UserOrders> list = [];

    for (var order in _ordersList) {
      if (order.isRejected == true) {
        list.add(order);
      }
    }

    return list;
  }

  List<UserOrders> onGoingServices() {
    List<UserOrders> list = [];

    for (var order in _ordersList) {
      if (order.isOngoing == true) {
        list.add(order);
      }
    }

    return list;
  }

  List<UserOrders> onPendingServices() {
    List<UserOrders> list = [];

    for (var order in _ordersList) {
      if (order.isPaid == true && order.isAccepted == false) {
        list.add(order);
      }
    }

    return list;
  }

  List<UserOrders> onCompletedOrderServices() {
    List<UserOrders> list = [];

    for (var order in _ordersList) {
      if (order.isCompleted == true) {
        list.add(order);
      }
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

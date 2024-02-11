import 'package:intl/intl.dart';
import 'package:petnity/model/user_models/gallery_data.dart';

import '../../res/enum.dart';
import '../account_models/agents_packages.dart';
import '../agent/agent.dart' as agent;
import '../user_models/get_services.dart';
import '../user_models/order.dart';
import '../user_models/order_lists.dart';
import '../user_models/packages.dart';
import '../user_models/pet_profile_details.dart';
import '../user_models/pets.dart';
import '../user_models/reviews_data.dart';
import '../user_models/service_type.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  List<ServiceType>? _servicesType = [];
  List<Packages> _packages = [];
  List<agent.Agent> _agents = [];
  List<Reviews> _reviews = [];
  List<GalleryElements> _gallery = [];
  List<Orders> _ordersList = [];

   GetServices? _services;

  String _petPicture = '';

  PetProfileDetails? _petProfile;

  UserOrders? _userOrder;

  bool _reviewStatus = false;
  bool _galleryStatus = false;

  double _totalHours = 0;
  double _remainingHours = 0;

  Future<void> setOrderList({required UserOrders orders}) async {
    _userOrder = orders;

    _ordersList = orders.data?.orders ?? [];
    setViewState(ViewState.success);
  }

  Future<void> setPetPicture({required String petPicture}) async {
    _petPicture = petPicture;
    setViewState(ViewState.success);
  }

  Future<void> setServicesTypeList({required List<ServiceType>? services}) async {
    _servicesType = services;
    setViewState(ViewState.success);
  }

   Future<void> setServicesList({required GetServices? services}) async {
    _services = services;
    setViewState(ViewState.success);
  }

  Future<void> setAgentDetails({required List<agent.Agent> agents}) async {
    _agents = agents;
    setViewState(ViewState.success);
  }

  Future<void> setPetDetails({required PetProfileDetails pet}) async {
    _petProfile = pet;
    setViewState(ViewState.success);
  }

  Future<void> clearPetDetails() async {
    _petProfile = null;

    setViewState(ViewState.success);
  }

  Future<void> setAgentPackages(
      {required GetAgentsPackages agentPackage}) async {
    _packages = agentPackage.data?.packages ?? [];
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
    _reviews = reviews.data?.reviews ?? [];
    setViewState(ViewState.success);
  }

  Future<void> setGallery({required GalleryAgents gallery}) async {
    _galleryStatus = gallery.status ?? false;
    _gallery = gallery.data?.galleryElements ?? [];
    setViewState(ViewState.success);
  }

  String formatDateTimeToAMPM(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final formattedTime = DateFormat('h:mm a').format(dateTime.toLocal());
      return formattedTime;
    } catch (e) {
      print('Error parsing the date string: $e');
      return '';
    }
  }

  String calculateTimeDifferenceInHours(
      String startTimeString, String endTimeString) {
    try {
      final startTime = DateTime.parse(startTimeString);
      final endTime = DateTime.parse(endTimeString);

      final difference = startTime.isBefore(endTime)
          ? endTime.difference(startTime)
          : startTime.difference(endTime);

      final hoursDifference = (difference.inMinutes / 60).toDouble();

      return '${hoursDifference.toStringAsFixed(1)}';
    } catch (e) {
      print('Error parsing the date strings: $e');
      return '0.0';
    }
  }

  String calculateRemainingTimeInHours(String endTimeString) {
    try {
      final currentTime = DateTime.now();
      final endTime = DateTime.parse(endTimeString);

      if (currentTime.isAfter(endTime)) {
        return 'Elapsed';
      }

      final difference = endTime.difference(currentTime);

      final hours = difference.inMinutes / 60;

      return '${hours.toStringAsFixed(1)}';
    } catch (e) {
      print('Error parsing the date string: $e');
      return 'Invalid date format';
    }
  }

  double calculateRemainingProgressTime(String endTimeString) {
    try {
      final currentTime = DateTime.now();
      final endTime = DateTime.parse(endTimeString);

      if (endTime.isBefore(currentTime)) {
        return 1.0;
      }

      final difference = endTime.difference(currentTime);

      final remainingTimeInHours = difference.inMinutes / 60;
      final percentageOfCompletion = remainingTimeInHours /
          (DateTime.parse(endTimeString)
              .difference(DateTime.now())
              .inHours
              .toDouble());
      return percentageOfCompletion;
    } catch (e) {
      print('Error parsing the date strings: $e');
      return 0.0;
    }
  }

  double calculateTimeDifference(String startTimeString, String endTimeString) {
    try {
      final startTime = DateTime.parse(startTimeString);
      final endTime = DateTime.parse(endTimeString);

      final difference = startTime.isBefore(endTime)
          ? endTime.difference(startTime)
          : startTime.difference(endTime);

      final hoursDifference = (difference.inMinutes / 60).toDouble();

      return hoursDifference;
    } catch (e) {
      print('Error parsing the date strings: $e');
      return 0.0;
    }
  }

  double calculateTimeRemainingInHours(String endTimeString) {
    try {
      final currentTime = DateTime.now();
      final endTime = DateTime.parse(endTimeString);

      if (endTime.isBefore(currentTime)) {
        return 0.0; // Time has already passed
      }

      final difference = endTime.difference(currentTime);
      final hoursRemaining = difference.inMinutes / 60.0;

      return hoursRemaining;
    } catch (e) {
      print('Error parsing the date string: $e');
      return 0.0; // Return 0.0 for invalid dates or errors
    }
  }

  getProgressTime(String endTimeString) {
    double totalHours = calculateTimeDifference(
        DateTime.now().toIso8601String(), endTimeString);
    double remainingHours = calculateTimeRemainingInHours(endTimeString);

    _totalHours = totalHours;
    _remainingHours = remainingHours;

    setViewState(ViewState.success);
    return _remainingHours / _totalHours;
  }

  List<ServiceType> get servicesType => _servicesType ?? [];
  GetServices? get services => _services;
  List<agent.Agent> get agents => _agents;
  List<Packages> get packages => _packages;
  List<Reviews> get reviews => _reviews;
  List<GalleryElements> get gallery => _gallery;
  bool get reviewStatus => _reviewStatus;
  String get petPicture => _petPicture;
  bool get galleryStatus => _galleryStatus;
  PetProfileDetails? get petDetails => _petProfile;
  List<ServiceType> get servicesItems => servicesResults();
  List<Pets> get servicesPetList => servicesPets();

  List<Orders> get ordersList => _ordersList;

  List<Orders> get onGoingOrdersList => onGoingServices();
  List<Orders> get onPendingOrderList => onPendingServices();
  List<Orders> get onCompletedOrdersList => onCompletedOrderServices();
  List<Orders> get onRejectedOrdersList => onRejectedServices();

  List<ServiceType> servicesResults() {
    List<ServiceType> list = [];

    for (var service in _agents ?? []) {
      list.addAll(service.services);
    }

    return list;
  }

  List<Orders> onRejectedServices() {
    List<Orders> list = [];

    for (var order in _ordersList) {
      if (order.isRejected == true) {
        list.add(order);
      }
    }

    return list;
  }

  List<Orders> onGoingServices() {
    List<Orders> list = [];

    for (var order in _ordersList) {
      if (order.isOngoing == true && order.isCompleted != true) {
        list.add(order);
      }
    }

    return list;
  }

  List<Orders> onPendingServices() {
    List<Orders> list = [];

    for (var order in _ordersList) {
      if (order.isPaid == true && order.isAccepted == false) {
        list.add(order);
      }
    }

    return list;
  }

  List<Orders> onCompletedOrderServices() {
    List<Orders> list = [];

    for (var order in _ordersList) {
      if (order.isPaid == true &&
          order.isCompleted == true &&
          order.agentMarkedDelivered == true &&
          order.userMarkedDelivered == true) {
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

import 'package:petnity/model/user_models/order_list.dart';

import '../agent/agent.dart';
import '../packages/packages.dart';
import '../profile/profile.dart';

class AgentServicesList {
  bool? status;
  List<AgentServicesListOrders>? orders;
  List<AgentServicesListVetOrders>? vetOrders;

  AgentServicesList({this.status, this.orders, this.vetOrders});

  AgentServicesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <AgentServicesListOrders>[];
      json['orders'].forEach((v) {
        orders!.add(new AgentServicesListOrders.fromJson(v));
      });
    }
    if (json['vet_orders'] != null) {
      vetOrders = <AgentServicesListVetOrders>[];
      json['vet_orders'].forEach((v) {
        vetOrders!.add(new AgentServicesListVetOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.vetOrders != null) {
      data['vet_orders'] = this.vetOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgentServicesListOrders {
  int? id;
  String? pickupLocation;
  String? pickupTime;
  String? dropoffTime;
  bool? shouldNotify;
  String? fee;
  String? purchaseId;
  bool? isPaid;
  bool? isAccepted;
  bool? isRejected;
  bool? isOngoing;
  bool? userMarkedDelivered;
  bool? agentMarkedDelivered;
  bool? isCompleted;
  bool? paymentReleased;
  String? dateCreated;
  Profile? profile;
  Agent? agent;
  Package? package;

  AgentServicesListOrders(
      {this.id,
      this.pickupLocation,
      this.pickupTime,
      this.dropoffTime,
      this.shouldNotify,
      this.fee,
      this.purchaseId,
      this.isPaid,
      this.isAccepted,
      this.isRejected,
      this.isOngoing,
      this.userMarkedDelivered,
      this.agentMarkedDelivered,
      this.isCompleted,
      this.paymentReleased,
      this.dateCreated,
      this.profile,
      this.agent,
      this.package});

  AgentServicesListOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupLocation = json['pickup_location'];
    pickupTime = json['pickup_time'];
    dropoffTime = json['dropoff_time'];
    shouldNotify = json['should_notify'];
    fee = json['fee'];
    purchaseId = json['purchase_id'];
    isPaid = json['is_paid'];
    isAccepted = json['is_accepted'];
    isRejected = json['is_rejected'];
    isOngoing = json['is_ongoing'];
    userMarkedDelivered = json['user_marked_delivered'];
    agentMarkedDelivered = json['agent_marked_delivered'];
    isCompleted = json['is_completed'];
    paymentReleased = json['payment_released'];
    dateCreated = json['date_created'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_time'] = this.pickupTime;
    data['dropoff_time'] = this.dropoffTime;
    data['should_notify'] = this.shouldNotify;
    data['fee'] = this.fee;
    data['purchase_id'] = this.purchaseId;
    data['is_paid'] = this.isPaid;
    data['is_accepted'] = this.isAccepted;
    data['is_rejected'] = this.isRejected;
    data['is_ongoing'] = this.isOngoing;
    data['user_marked_delivered'] = this.userMarkedDelivered;
    data['agent_marked_delivered'] = this.agentMarkedDelivered;
    data['is_completed'] = this.isCompleted;
    data['payment_released'] = this.paymentReleased;
    data['date_created'] = this.dateCreated;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    return data;
  }
}




class AgentServicesListVetOrders {
  int? id;
  String? sessionTime;
  bool? shouldNotify;
  String? fee;
  String? purchaseId;
  bool? isPaid;
  bool? isAccepted;
  bool? isRejected;
  bool? isOngoing;
  bool? userMarkedDelivered;
  bool? agentMarkedDelivered;
  bool? isCompleted;
  bool? paymentReleased;
  String? dateCreated;
  Profile? profile;
  Agent? agent;
  VetService? vetService;

  AgentServicesListVetOrders(
      {this.id,
      this.sessionTime,
      this.shouldNotify,
      this.fee,
      this.purchaseId,
      this.isPaid,
      this.isAccepted,
      this.isRejected,
      this.isOngoing,
      this.userMarkedDelivered,
      this.agentMarkedDelivered,
      this.isCompleted,
      this.paymentReleased,
      this.dateCreated,
      this.profile,
      this.agent,
      this.vetService});

  AgentServicesListVetOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionTime = json['session_time'];
    shouldNotify = json['should_notify'];
    fee = json['fee'];
    purchaseId = json['purchase_id'];
    isPaid = json['is_paid'];
    isAccepted = json['is_accepted'];
    isRejected = json['is_rejected'];
    isOngoing = json['is_ongoing'];
    userMarkedDelivered = json['user_marked_delivered'];
    agentMarkedDelivered = json['agent_marked_delivered'];
    isCompleted = json['is_completed'];
    paymentReleased = json['payment_released'];
    dateCreated = json['date_created'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    vetService = json['vet_service'] != null
        ? new VetService.fromJson(json['vet_service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_time'] = this.sessionTime;
    data['should_notify'] = this.shouldNotify;
    data['fee'] = this.fee;
    data['purchase_id'] = this.purchaseId;
    data['is_paid'] = this.isPaid;
    data['is_accepted'] = this.isAccepted;
    data['is_rejected'] = this.isRejected;
    data['is_ongoing'] = this.isOngoing;
    data['user_marked_delivered'] = this.userMarkedDelivered;
    data['agent_marked_delivered'] = this.agentMarkedDelivered;
    data['is_completed'] = this.isCompleted;
    data['payment_released'] = this.paymentReleased;
    data['date_created'] = this.dateCreated;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.vetService != null) {
      data['vet_service'] = this.vetService!.toJson();
    }
    return data;
  }
}



 

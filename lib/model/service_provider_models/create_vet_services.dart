
import '../agent/agent.dart';
import '../profile/profile.dart';
import '../user_models/vet_services.dart';

class CreateVetOrder {
  bool? status;
  String? message;
  Order? order;

  CreateVetOrder({this.status, this.message, this.order});

  CreateVetOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
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

  Order(
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

  Order.fromJson(Map<String, dynamic> json) {
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







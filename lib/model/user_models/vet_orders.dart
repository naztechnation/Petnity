import '../agent/agent.dart';
import '../user/user.dart';
import 'vet_service.dart';

class VetOrders {
  bool? shouldNotify;
  bool? isPaid;
  bool? isAccepted;
  bool? isRejected;
  bool? isOngoing;
  bool? userMarkedDelivered;
  bool? agentMarkedDelivered;
  bool? isCompleted;
  bool? paymentReleased;
  String? sId;
  User? user;
  Agent? agent;
  VetService? vetService;
  String? sessionTime;
  int? fee;
  String? createdAt;
  String? updatedAt;

  VetOrders(
      {this.shouldNotify,
      this.isPaid,
      this.isAccepted,
      this.isRejected,
      this.isOngoing,
      this.userMarkedDelivered,
      this.agentMarkedDelivered,
      this.isCompleted,
      this.paymentReleased,
      this.sId,
      this.user,
      this.agent,
      this.vetService,
      this.sessionTime,
      this.fee,
      this.createdAt,
      this.updatedAt});

  VetOrders.fromJson(Map<String, dynamic> json) {
    shouldNotify = json['shouldNotify'];
    isPaid = json['isPaid'];
    isAccepted = json['isAccepted'];
    isRejected = json['isRejected'];
    isOngoing = json['isOngoing'];
    userMarkedDelivered = json['userMarkedDelivered'];
    agentMarkedDelivered = json['agentMarkedDelivered'];
    isCompleted = json['isCompleted'];
    paymentReleased = json['paymentReleased'];
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    vetService = json['vetService'] != null
        ? new VetService.fromJson(json['vetService'])
        : null;
    sessionTime = json['sessionTime'];
    fee = json['fee'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shouldNotify'] = this.shouldNotify;
    data['isPaid'] = this.isPaid;
    data['isAccepted'] = this.isAccepted;
    data['isRejected'] = this.isRejected;
    data['isOngoing'] = this.isOngoing;
    data['userMarkedDelivered'] = this.userMarkedDelivered;
    data['agentMarkedDelivered'] = this.agentMarkedDelivered;
    data['isCompleted'] = this.isCompleted;
    data['paymentReleased'] = this.paymentReleased;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.vetService != null) {
      data['vetService'] = this.vetService!.toJson();
    }
    data['sessionTime'] = this.sessionTime;
    data['fee'] = this.fee;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
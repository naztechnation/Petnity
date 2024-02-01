import '../agent/agent.dart';
import '../packages/packages.dart';
import '../user/user.dart';

class Orders {
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
  String? transactionId;
  User? user;
  Agent? agent;
  Package? package;
  String? pickupLocation;
  String? pickupTime;
  String? dropoffTime;
  int? fee;
  String? createdAt;
  String? updatedAt;

  Orders(
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
      this.transactionId,
      this.user,
      this.agent,
      this.package,
      this.pickupLocation,
      this.pickupTime,
      this.dropoffTime,
      this.fee,
      this.createdAt,
      this.updatedAt});

  Orders.fromJson(Map<String, dynamic> json) {
    shouldNotify = json['shouldNotify'];
    isPaid = json['isPaid'];
    isAccepted = json['isAccepted'];
    isRejected = json['isRejected'];
    isOngoing = json['isOngoing'];
    userMarkedDelivered = json['userMarkedDelivered'];
    agentMarkedDelivered = json['agentMarkedDelivered'];
    isCompleted = json['isCompleted'];
    paymentReleased = json['paymentReleased'];
    transactionId = json['transactionId'];
    sId = json['_id'];
     user = json['user'] != null ? new User.fromJson(json['user']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    pickupLocation = json['pickupLocation'];
    pickupTime = json['pickupTime'];
    dropoffTime = json['dropoffTime'];
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
    data['user'] = this.user;
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    data['pickupLocation'] = this.pickupLocation;
    data['pickupTime'] = this.pickupTime;
    data['dropoffTime'] = this.dropoffTime;
    data['fee'] = this.fee;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}


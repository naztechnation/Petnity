import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';



class PricingPage extends StatefulWidget {
  final String amount;
  final String email;
  const PricingPage({super.key, required this.amount, required this.email});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  final String amount = '';

  String email = '';

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  String selectedPlan = '';

  @override
  void initState() {

    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 5,
            title: const Text('Make Payment'),
            leading: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.secondary,
                size: 32,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor),
        body: SizedBox.shrink(),
      ),
    );
  }
}

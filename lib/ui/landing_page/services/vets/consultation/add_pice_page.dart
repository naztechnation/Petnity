import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../../model/user_models/medium_types.dart';
import '../../../../../model/user_models/session_types.dart';
import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../utils/validator.dart';
import '../../../../widgets/text_edit_view.dart';
import 'review_services_page.dart';

class AddPricePage extends StatefulWidget {

 final List<VetSessionTypes> sessionTypesSelectedItems;
 final List<VetContactMediums> contactMediumsSelectedItems;

  const AddPricePage({super.key, required this.sessionTypesSelectedItems, required this.contactMediumsSelectedItems});

  @override
  _AddPricePageState createState() => _AddPricePageState();
}

class _AddPricePageState extends State<AddPricePage> {
  final amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  double screenSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Vets'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add prices',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'InterSans',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Input price per 5 mins',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'InterSans',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: TextEditView(
                    controller: amountController,
                    fillColor: Colors.white,
                    borderColor: Colors.white,
                    keyboardType: TextInputType.number,
                    borderRadius: 30,
                    validator: (value) {
                      return Validator.validate(value, 'Amount');
                    },
                    isDense: true,
                    textViewTitle: '',
                    hintText: 'Input session amount',
                  ),
                ),
                Spacer(),
                
                  ButtonView(
                      onPressed: () {
                        saveAmount(context, serviceProvider);
                      },
                      child: Text(
                        'Finish up',
                        style: TextStyle(color: Colors.white),
                      )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  saveAmount(BuildContext ctx, serviceProvider) {
    if (_formKey.currentState!.validate()) { 
      FocusScope.of(ctx).unfocus();

      serviceProvider.updateAmountController(amountController.text);
      AppNavigator.pushAndStackPage(context,
                            page: ReviewServices(sessionTypesSelectedItems: widget.sessionTypesSelectedItems, contactMediumsSelectedItems: widget.contactMediumsSelectedItems, ));

    }}
}

import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/home.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/pet_selling_section/pet_selling_home.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/vet_home_screen.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import 'package:petnity/ui/landing_page/widgets/listofservices_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/filter_search_section.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';

class ServiceProviderHomePage extends StatefulWidget {
  ServiceProviderHomePage({super.key});

  @override
  State<ServiceProviderHomePage> createState() => _ServiceProviderHomePageState();
}

class _ServiceProviderHomePageState extends State<ServiceProviderHomePage> {
  final TextEditingController search = TextEditingController();

  String username = '';

  getUsername() async {
    username = await StorageHandler.getUserName();
     
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AccountViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: screenSize(context).height * .9,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: screenSize(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                                child: Text(
                                  'Hi ${username.capitalizeFirstOfEach},',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: AppStrings.interSans),
                                ),
                              ),
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
                Text(
                  'How is your pet doing?',
                  style: TextStyle(
                      fontFamily: AppStrings.interSans,
                      fontWeight: FontWeight.w800,
                      fontSize: 22),
                ),
                FilterSearchView(
                  showFilter: false,
                  controller: search,
                ),
                SizedBox(
                  height: 20,
                ),
                ServiceProviderPetDeliveryHomeBody()
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget card(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: Row(
        children: [
          Container(
            width: screenSize(context).width * .60,
            height: screenSize(context).height * .2,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Begin by adding your services and pricing',
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      fontFamily: AppStrings.interSans),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonView(
                  borderRadius: 30,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  onPressed: () {},
                  child: Text('Begin Now'),
                  expanded: false,
                ),
              ],
            ),
          ),
          SizedBox(width: 130, child: ImageView.asset(AppImages.playingCat))
        ],
      ),
    );
  }

  Widget emptyBody(BuildContext context) {
    return Container(
      height: screenSize(context).height * .6,
      child: Column(
        children: [
          card(context),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenSize(context).width * .04),
            height: screenSize(context).height * .2,
            width: screenSize(context).width * .9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Card(
                child: Center(
                    child: Text('Your ongoing sessions would appear here')),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

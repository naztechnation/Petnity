import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/blocs/location/location_cubit.dart';
import 'package:petnity/model/view_models/account_view_model.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/services/vets/treatments/schedule_date.dart';
import 'package:petnity/ui/location/widgets/map_view.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../../requests/repositories/location_repo/location_repository_impl.dart';

class Treatment extends StatefulWidget {
  const Treatment({Key? key})
      : scale = false,
        super(key: key);

  const Treatment.scale({Key? key})
      : scale = true,
        super(key: key);

  final bool scale;

  @override
  State<Treatment> createState() => _TreatmentState();
}

class _TreatmentState extends State<Treatment> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          lazy: false,
          create: (_) => LocationCubit(
              locationRepository: LocationRepositoryImpl(),
              userViewModel:
                  Provider.of<AccountViewModel>(context, listen: false)),
        )
      ],
      child: Scaffold(
        bottomNavigationBar: Container(
          height: screenSize(context).height * .15,
          padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
          child: ButtonView(
              borderRadius: 50,
              onPressed: () {
                AppNavigator.pushAndStackPage(context, page: ScheduleDate());
              },
              child: Text('Continue')),
        ),
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: CustomText(
            textAlign: TextAlign.center,
            maxLines: 2,
            text: 'Vets',
            weight: FontWeight.w600,
            size: 22,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          leading: backButton(context),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text('Treatment requires you to go to the vet'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: Colors.black12,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      MapViews(
                        zoom: 15,
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          width: screenSize(context).width * .9,
                          height: screenSize(context).height * .1,
                          margin: EdgeInsets.all(10),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  'Get directions to vets address on map - 223km away',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: AppStrings.interSans,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              height: screenSize(context).height * .3,
              width: screenSize(context).width,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:provider/provider.dart';

import '../../blocs/location/location.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/location_repo/location_repository_impl.dart';
import '../../res/app_strings.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import 'widgets/location_search.dart';
import 'widgets/map_view.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({Key? key})
      : scale = false,
        super(key: key);

  const SetLocationScreen.scale({Key? key})
      : scale = true,
        super(key: key);

  final bool scale;

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
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
          body: Scaffold(
            body: Stack(
              children: [
                const MapViews(),
                Container(
                  height: screenSize(context).height,
                  width: screenSize(context).width,
                  color: Colors.black12,
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: SafeArea(
                    child: Row(
                      children: [
                        backButton(context),
                        const SizedBox(
                          width: 40,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'Pick up location',
                          weight: FontWeight.w600,
                          size: 22,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Builder(builder: (_) {
              if (!widget.scale) {
                return const LocationSearch();
              }
              return const SizedBox.shrink();
            }),
            bottomSheet: Builder(builder: (_) {
              if (widget.scale) {
                return const LocationSearch();
              }
              return const SizedBox.shrink();
            }),
          ),
        ));
  }
}

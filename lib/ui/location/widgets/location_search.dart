import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:provider/provider.dart';

import '../../../blocs/location/location.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/data_models/location/location_prediction.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_images.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../landing_page/services/contact_provider.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/text_edit_view.dart';

class LocationSearch extends StatefulWidget {
  final void Function()? onPressed;

  const LocationSearch({Key? key, this.onPressed}) : super(key: key);

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  late LocationCubit _locationCubit;

  bool useCurrentLocation = false;
  bool showNextBtn = false;

  String username = '';


  getUsername() async {
    username = await StorageHandler.getUserName();
    }

  @override
  void initState() {
    getUsername();
    _locationCubit = context.read<LocationCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

    return BlocConsumer<LocationCubit, LocationStates>(
        listener: (_, locationState) {},
        builder: (context, locationState) {
          return Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30), right: Radius.circular(30))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text('Hey ${username.capitalizeFirstOfEach}, your location',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10.0),
                        Text(_locationCubit.userViewModel.address,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Visibility(
                      visible: !showNextBtn,
                      child: ButtonView(
                          onPressed: () {
                            setState(() {
                              showNextBtn = true;
                              useCurrentLocation = true; 
                            });
                          },
                          processing: false,
                          expanded: false,
                          child: const Text('Use current location',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400))),
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),
                const CustomText(
                  text: 'Search address You \nwant your pet to be picked up',
                  size: 14,
                  weight: FontWeight.w600,
                  maxLines: 2,
                ),
                const SizedBox(height: 25.0),
                RawAutocomplete(
                  displayStringForOption: (LocationPrediction option) =>
                      option.description,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<LocationPrediction>.empty();
                    } else if (locationState is LocationsLoaded) {
                      return locationState.locations;
                    } else {
                      return _locationCubit.locations;
                    }
                  },
                  onSelected: (LocationPrediction option) =>
                      _locationCubit.locationFromAddress(option.description),
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                        if(useCurrentLocation){
                          textEditingController.text = _locationCubit.userViewModel.address;
                        }
                          user.setUserLocation(textEditingController.text);

                    return TextEditView(
                      controller: textEditingController,
                      focusNode: focusNode,
                      isDense: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      hintText: 'Search Location',
                      borderWidth: 0,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ImageView.svg(
                          AppImages.searchIcon,
                          width: 22,
                          height: 22,
                        ),
                      ),
                      onChanged: (value) => {
                        if (value.isNotEmpty)
                          {
                            //_locationCubit.fetchSuggestions(value),
                          setState(() {
                              showNextBtn = true;
                            }),
                          
                          }else if(value.length == 0){
                             setState(() {
                              showNextBtn = false;
                              useCurrentLocation = false;
                            })
                          }
                      },
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      void Function(LocationPrediction) onSelected,
                      Iterable<LocationPrediction> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                          elevation: 4.0,
                          child: SizedBox(
                            height: 200,
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8.0),
                              itemCount: options.length,
                              separatorBuilder: (context, i) {
                                return const Divider();
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final option = options.elementAt(index);
                                return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.location_on_outlined),
                                          const SizedBox(width: 5.0),
                                          Expanded(
                                              child: Text(option.description)),
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          )),
                    );
                  },
                ),
                const SizedBox(height: 25.0),
                if (showNextBtn)
                  ButtonView(
                      onPressed: () {
                        AppNavigator.pushAndStackPage(context,
                            page: ContactProvider());
                        // print(user.location);
                      },
                      processing: false,
                      child: const Text('Next',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500))),
              ],
            ),
          );
        });
  }
}

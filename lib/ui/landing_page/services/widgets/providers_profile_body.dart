import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/blocs/user/user.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/user/user_cubit.dart';
import '../../../../model/user_models/service_provider_lists.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../../res/app_strings.dart';
import '../../../../utils/validator.dart';
import '../../../widgets/custom_multi_toogle.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/modals.dart';
import '../../../widgets/ratings_views.dart';
import '../../../widgets/text_edit_view.dart';
import 'contact_info.dart';


class ProviderProfileBody extends StatelessWidget {
   final Agents? agents;
  const ProviderProfileBody(
      {super.key, required this.agents,  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ProviderProfile(
        agents: agents,
       
      ),
    );
  }
}
class ProviderProfile extends StatefulWidget {
  final Agents? agents;

  ProviderProfile({super.key, this.agents});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  List<String> services = [];

  List<String> animals = [];

  String servicesInfo = '';
  String animalsInfo = '';
  int ratings = 4;

  bool isProcessing = false;

  int ratingNumber = 0;
  final commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late UserCubit _userCubit;

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();
     
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: false);
    user.getUsername();
    services = widget.agents!.services != null
        ? widget.agents!.services!.map((service) => service.name ?? '').toList()
        : <String>[];

    animals = widget.agents!.petTypes != null
        ? widget.agents!.petTypes!
            .map((petTypes) => petTypes.name ?? '')
            .toList()
        : <String>[];

    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is PostProductReviewsLoaded){
        if (state.postReview.status!) {
          Modals.showToast(state.postReview.message ?? '');
            _userCubit.getReviews(userId: widget.agents?.id.toString() ?? '');
           setState(() {
        isProcessing = false;
      });
          Navigator.pop(context);
        } else {}
      } else if (state is UserNetworkErrApiErr) {
        Modals.showToast(state.message ?? '');
      } else if (state is UserNetworkErr) {
        Modals.showToast(state.message ?? '');
      }
    }, builder: (context, state) {
      

      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                textAlign: TextAlign.start,
                maxLines: 2,
                text: 'Service',
                weight: FontWeight.w700,
                size: 16,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonView(
                onPressed: () {},
                borderRadius: 30,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  '${services[0]}',
                  style: TextStyle(color: AppColors.lightSecondary),
                ),
                expanded: false,
                color: AppColors.lightSecondary.withOpacity(0.3),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                textAlign: TextAlign.start,
                maxLines: 2,
                text: 'Other services',
                weight: FontWeight.w700,
                size: 16,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
            ),
            CustomMultiToggle(
              title: services,
              fontSize: 11,
              color: AppColors.lightPrimary,
              selectedTextColor: AppColors.lightPrimary,
              height: 35,
              contentMargin: const EdgeInsets.all(5),
              onSelected: (index) {
                setState(() {
                  servicesInfo = services[index];
                });
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                textAlign: TextAlign.start,
                maxLines: 2,
                text: 'Animals',
                weight: FontWeight.w700,
                size: 16,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
            ),
            CustomMultiToggle(
              title: animals,
              fontSize: 11,
              color: AppColors.lightPrimary,
              selectedTextColor: AppColors.lightPrimary,
              height: 35,
              contentMargin: const EdgeInsets.all(5),
              onSelected: (index) {
                setState(() {
                  animalsInfo = animals[index];
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: 'About',
                  weight: FontWeight.w600,
                  size: 14,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
    
                ButtonView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  expanded: false,
                  borderRadius: 30,
                  onPressed: () {
                    Modals.showBottomSheetModal(context,
                        isDissmissible: true,
                        heightFactor: 1,
                        page: Ratings(
                            ctxt: context,
                            username: user.username,
                            agentName: widget.agents?.name ?? '',
                            agentId: widget.agents?.id.toString() ?? ''));
                  },
                  child: Text('Add Review'),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     CustomText(
                //       textAlign: TextAlign.start,
                //       maxLines: 2,
                //       text: 'Ratings',
                //       weight: FontWeight.w600,
                //       size: 14,
                //       fontFamily: AppStrings.interSans,
                //       color: Colors.black,
                //     ),
                //     const SizedBox(width: 12,),
                //     RatingWidget(coloredStars: widget.agents!., size: 25,),
    
                //   ],
                // )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: '${widget.agents!.gender}',
              weight: FontWeight.w500,
              size: 14,
              color: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              textAlign: TextAlign.start,
              maxLines: 4,
              text: '${widget.agents!.about}',
              weight: FontWeight.w500,
              size: 14,
              color: Colors.black,
            ),
            contactInfo(
                phone: widget.agents!.profile!.phoneNumber,
                email: widget.agents!.profile!.user!.email),
            const SizedBox(
              height: 30,
            ),
          ]));
  });
  }

  Ratings({
    required String username,
    required BuildContext ctxt,
    required String agentName,
    required String agentId,
  }) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate this ${agentName.capitalizeFirstOfEach}\'s Services',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              RatingView(
                rating: ratingNumber,
                size: 30,
                onSelected: (value) {
                  setState((() {
                    ratingNumber = value + 1;
                  }));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: TextEditView(
                  controller: commentController,
                  validator: (value) {
                    return Validator.validate(value, 'comment');
                  },
                  isDense: true,
                  textViewTitle: 'Write a review',
                  hintText: 'Enter comment',
                  borderWidth: 0.5,
                  fillColor: AppColors.lightPrimary,
                  borderColor: Color.fromARGB(255, 41, 12, 12),
                  borderRadius: 30,
                  onChanged: ((value) {
                    setState(() {});
                  }),
                  maxLines: 6,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (commentController.text.isEmpty)
                Center(
                  child: Text(
                    'Report ${agentName.capitalizeFirstOfEach}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              if (commentController.text.isNotEmpty)
                ButtonView(
                  processing: isProcessing,
                  onPressed: () {
                    setState(() {});
                    _postProductReviews(
                      ctx: ctxt,
                      username: username,
                      agentId: widget.agents?.id.toString() ?? "",
                      rating: ratingNumber.toString(),
                      comment: commentController.text,
                    );
                  },
                  color: AppColors.lightSecondary,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Submit',
                    weight: FontWeight.w400,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  _postProductReviews(
      {required BuildContext ctx,
      required String username,
      required String agentId,
      required String rating,
      required String comment}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
      });
      await _userCubit.postProductReviews(
            url: 'users/add-review/$agentId/$username',
            rating: rating,
            comment: comment,
          );
      setState(() {
        isProcessing = false;
      });
      FocusScope.of(ctx).unfocus();
    } else {
      Modals.showToast('please enter a comment');
    }
  }
}

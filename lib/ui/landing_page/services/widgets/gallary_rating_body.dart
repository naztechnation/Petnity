import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/user/user.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../model/user_models/reviews_data.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../single_image_view.dart';
import 'review_container.dart';

class GallaryRatingBody extends StatelessWidget {
  final bool isGallary;
  final String? userId;
  GallaryRatingBody({super.key, required this.isGallary,  this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: GallaryRating(
        isGallary: isGallary, userId: userId ?? '',
      ),
    );
  }
}

class GallaryRating extends StatefulWidget {
  final bool isGallary;
  final String userId;
  GallaryRating({super.key, required this.isGallary, required this.userId});

  @override
  State<GallaryRating> createState() => _GallaryRatingState();
}

class _GallaryRatingState extends State<GallaryRating> {
  late UserCubit _userCubit;
  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId();
    _userCubit = context.read<UserCubit>();
    _userCubit.getReviews(userId: widget.userId);
  }

  List<Reviews> reviewsList = [];

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = Provider.of<UserViewModel>(context, listen: false).reviews;

    if (widget.isGallary)
      return Container(
        height: 230,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.white),
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemCount: 6,
          itemBuilder: (ctx, i) {
            return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                child: GestureDetector(
                    onTap: () {
                      AppNavigator.pushAndStackPage(context,
                          page: SingleImageView());
                    },
                    child: ImageView.asset(AppImages.dogPet)));
          },
        ),
      );
    else {
      return BlocProvider<UserCubit>(
          lazy: false,
          create: (_) => UserCubit(
              userRepository: UserRepositoryImpl(),
              viewModel: Provider.of<UserViewModel>(context, listen: false)),
          child: BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {
              if (state is ReviewLoaded) {
                if (state.reviews.status!) {
                  reviewsList = state.reviews.reviews ?? [];
                  Modals.showToast('message');
                } else {}
              } else if (state is UserNetworkErrApiErr) {
              } else if (state is UserNetworkErr) {}
            },
            builder: (context, state) => (state is ReviewLoading)
                ? LoadingPage()
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: reviews.length,
                    itemBuilder: (_, index) {
                      return ReviewContainer(
                        review: reviews[index],
                      );
                    }),
          ));
    }
  }
}

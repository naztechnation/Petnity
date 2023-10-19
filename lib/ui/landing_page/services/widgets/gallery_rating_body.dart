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

class GalleryRatingBody extends StatelessWidget {
  final bool isGallery;
  final String? userId;
  GalleryRatingBody({super.key, required this.isGallery,  this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: GalleryRating(
        isGallery: isGallery, userId: userId ?? '',
      ),
    );
  }
}

class GalleryRating extends StatefulWidget {
  final bool isGallery;
  final String userId;
  GalleryRating({super.key, required this.isGallery, required this.userId});

  @override
  State<GalleryRating> createState() => _GalleryRatingState();
}

class _GalleryRatingState extends State<GalleryRating> {
  late UserCubit _userCubit;
  String userId = '';
  getUserId() async {
    userId = await StorageHandler.getUserId();
    _userCubit = context.read<UserCubit>();

   await  _userCubit.viewModel.emptyReviews();
   await _userCubit.getReviews(userId: widget.userId);

   
    if(_userCubit.viewModel.reviewStatus){
   reviewsList = _userCubit.viewModel.reviews;

    }else{
      reviewsList = [];
    }

  }

  List<Reviews> reviewsList = [];

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final reviews = Provider.of<UserViewModel>(context, listen: true).reviews;
    if (widget.isGallery)
      return Container(
        height: 230,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.white),
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
                    physics: NeverScrollableScrollPhysics(),

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
      return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: reviewsList.length,
                    itemBuilder: (_, index) {
                      return ReviewContainer(
                        review: reviewsList[index],
                      );
                    });
    }
  }
}

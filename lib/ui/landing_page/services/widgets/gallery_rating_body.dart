import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/model/user_models/gallery_data.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';
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
  GalleryRatingBody({super.key, required this.isGallery, this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: GalleryRating(
        isGallery: isGallery,
        userId: userId ?? '',
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

  List<Reviews> reviewsList = [];
  List<GalleryElements> galleryList = [];

  getUserId() async {
    userId = await StorageHandler.getUserId();
    _userCubit = context.read<UserCubit>();
    await _userCubit.viewModel.emptyGallery();
    await _userCubit.getGallery(userId: widget.userId);

    if (_userCubit.viewModel.galleryStatus) {
      galleryList = _userCubit.viewModel.gallery;
    } else {
      galleryList = [];
    }

    setState(() {});

    await _userCubit.viewModel.emptyReviews();
    await _userCubit.getReviews(userId: widget.userId);

    if (_userCubit.viewModel.reviewStatus) {
      reviewsList = _userCubit.viewModel.reviews;
    } else {
      reviewsList = [];
    }
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final reviews = Provider.of<UserViewModel>(context, listen: true).reviews;
    if (widget.isGallery)
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: GridView.builder(
              padding: const EdgeInsets.all(.0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: galleryList.length,
              itemBuilder: (ctx, i) {
                return Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: GestureDetector(
                        onTap: () {
                          AppNavigator.pushAndStackPage(context,
                              page: SingleImageView(
                                image: galleryList[i].image ?? '',
                              ));
                        },
                        child: ImageView.network(
                          galleryList[i].image,
                          placeholder: AppImages.logo,
                          fit: BoxFit.cover,
                        )));
              },
            ),
          ),
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

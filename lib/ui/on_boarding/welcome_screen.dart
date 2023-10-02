import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/on_boarding/widgets/page_indicator.dart';
import 'package:petnity/ui/widgets/button_view.dart';

import '../../model/onboarding_page/onboarding_page_item.dart';
import '../../res/app_constants.dart';
import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';
import 'widgets/fading_sliding_in.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Rect? rect;

  int pageIndex = 0;
  static List<OnboardPageItem> onboardPageItems = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();

    onboardPageItems = OnboardPageItem.onboardPageItems;
    super.initState();
  }

  nextPage() {
    setState(() {
      if (pageIndex == 4) {
        AppNavigator.pushAndReplaceName(context, name: AppRoutes.signUpScreen);

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);

        return;
      } else {
        pageIndex++;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      ),
      Positioned(
        top: screenSize(context).height * 0.04,
        right: 20,
        child: GestureDetector(
          onTap: () => AppNavigator.pushAndReplaceName(context,
              name: AppRoutes.signUpScreen),
          child: CustomText(
            maxLines: 1,
            text: 'SKIP',
            weight: FontWeight.w900,
            size: 14,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
        ),
      ),
      Positioned(
        top: screenSize(context).height * 0.16,
        left: 80,
        right: 80,
        child: ScaleTransition(
          scale: _animationController.drive(
            Tween<double>(begin: 1.3, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.2, 0.4, curve: Curves.elasticInOut),
              ),
            ),
          ),
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(260),
                child: ImageView.asset(
                  onboardPageItems[pageIndex].gifAsset,
                  width: 200,
                  height: 260,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: screenSize(context).height * 0.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(screenSize(context).width, 90.0))),
          child: Column(children: [
            const SizedBox(
              height: 47,
            ),
            FadingSlidingWidget(
              animationController: _animationController,
              interval: const Interval(0.5, 0.9),
              child: CustomText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: onboardPageItems[pageIndex].title,
                weight: FontWeight.w900,
                size: 22,
                fontFamily: AppStrings.montserrat,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            FadingSlidingWidget(
              animationController: _animationController,
              interval: const Interval(0.5, 0.9),
              child: CustomText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: onboardPageItems[pageIndex].description,
                weight: FontWeight.w400,
                size: 16,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            FadingSlidingWidget(
              animationController: _animationController,
              interval: const Interval(0.5, 0.9),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Interval(
                  0,
                  0.5,
                  curve: Curves.easeInOut,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 20),
                  child: ButtonView(
                    onPressed: () {
                      nextPage();
                    },
                    color: AppColors.lightSecondary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: (pageIndex == 4) ? 'Lets\'s go' : 'Continue',
                          weight: FontWeight.w400,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageIndicator(
                    isIndex: pageIndex >= 0,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  PageIndicator(
                    isIndex: pageIndex >= 1,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  PageIndicator(
                    isIndex: pageIndex >= 2,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  PageIndicator(
                    isIndex: pageIndex >= 3,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  PageIndicator(
                    isIndex: pageIndex >= 4,
                  ),
                ],
              ),
            ),
          ]),
        ),
      )
    ]));
  }
}

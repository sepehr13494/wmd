import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/onboarding_appbar.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/onboarding_asset_view.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/onboarding_security_view.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/onboarding_wealth_view.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/injection_container.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  AppState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends AppState<OnBoardingPage> {
  // OnBoardingPage({Key? key}) : super(key: key);

  final CarouselController buttonCarouselController = CarouselController();
  int currentPage = 0;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    final sliderList = [
      const OnBoardingWealthView(),
      const OnBoardingAssetView(),
      const OnBoardingSecurityView(),
    ];

    return BlocProvider(
        create: (context) => sl<UserStatusCubit>()..getUserStatus(),
        child: Scaffold(
            appBar: const OnboardingAppBar(),
            body: BlocConsumer<UserStatusCubit, UserStatusState>(
              listener:
                  BlocHelper.defaultBlocListener(listener: (context, state) {
                if (state is UserStatusLoaded) {
                  if (state.userStatus.loginAt != null) {
                    context.goNamed(AppRoutes.main);
                  }
                }
              }),
              builder: BlocHelper.defaultBlocBuilder(builder: (context, state) {
                return CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.8,
                      // height: responsiveHelper.isMobile
                      //     ? MediaQuery.of(context).size.height * 1.9
                      //     : MediaQuery.of(context).size.height * 0.8,
                      autoPlay: false,
                      viewportFraction: 1,
                      onPageChanged: (val, _) {
                        setState(() {
                          // print("new index $val");
                          currentPage = val;
                        });
                      }),
                  items: sliderList.map((i) {
                    final index = sliderList.indexOf(i);
                    return Builder(
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                              padding: responsiveHelper.paddingForMobileTab,
                              decoration: BoxDecoration(
                                  color: textTheme.bodySmall!.color!
                                      .withOpacity(0.05),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6))),
                              margin: responsiveHelper.marginForMobileTab,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  i,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: currentPage == 0
                                                ? Theme.of(context).primaryColor
                                                : AppColors
                                                    .dashBoardGreyTextColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: currentPage == 1
                                                ? Theme.of(context).primaryColor
                                                : AppColors
                                                    .dashBoardGreyTextColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: currentPage == 2
                                                ? Theme.of(context).primaryColor
                                                : AppColors
                                                    .dashBoardGreyTextColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 26),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            context.goNamed(
                                                AppRoutes.addAssetsView);
                                          },
                                          child: const Text('Skip'),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            debugPrint(index.toString());
                                            if (index == 2) {
                                              context.goNamed(
                                                  AppRoutes.addAssetsView);
                                            } else {
                                              buttonCarouselController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.linear);
                                            }
                                          },
                                          child: const Text('Next'),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  }).toList(),
                );
              }),
            )));
  }
}

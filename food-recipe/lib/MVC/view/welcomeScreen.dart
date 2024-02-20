import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe/MVC/view/homeScreen.dart';
import 'package:food_recipe/components/spring_widget.dart';
import 'package:food_recipe/constant/constants.dart';
import 'package:food_recipe/constant/navigation.dart';
import 'package:food_recipe/constant/theme.dart';
import 'package:get/get.dart';
import '../../../components/round_button.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            decoration: BoxDecoration(color: themecontroller.backgoundcolor),
            child: Column(
              children: [
                // "assets/images/titleLogo.png",
                Expanded(flex: 2, child: SizedBox(height: 30.sp)),
                Container(
                  height: 300.sp,
                  width: 300.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/splash-image.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.sp,
                ),
                 Container(
                  height: 70.sp,
                  // width: 300.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/title-image.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),

                Expanded(flex: 2, child: SizedBox(height: 30.sp)),
                SpringWidget(
                  onTap: () {
                    Navigation.getInstance.RightToLeft_PageNavigation(context, HomeScreen());
                  },
                  child: RoundButton(
                    margin: 0,
                    backgroundColor: themecontroller.colorPrimary,
                    borderColor: themecontroller.colorwhite,
                    height: 58.sp,
                    onTap: () {
                      // controller.selectedUserType.value = 'user';
                      // log('object  ${controller.selectedUserType.value}');
                    },
                    title: 'Get Started',
                    gradient: false,
                    textColor: themecontroller.colorwhite,
                  ),
                ),
                SizedBox(height: 12.sp),
              ],
            ),
          ),
        ),
      );
    });
  }
}

//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe/MVC/controller/homeController.dart';
import 'package:food_recipe/MVC/view/favScreen.dart';
import 'package:food_recipe/components/custom_textfiled.dart';
import 'package:food_recipe/components/recipeCard.dart';
import 'package:food_recipe/components/small_loader.dart';
import 'package:food_recipe/components/spring_widget.dart';
import 'package:food_recipe/constant/constants.dart';
import 'package:food_recipe/constant/navigation.dart';
import 'package:food_recipe/constant/theme.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      homeController.getRecipeData();
    }, builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Food Recipes',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              SpringWidget(
                onTap: () {
                  Navigation.getInstance
                      .RightToLeft_PageNavigation(context, favListScreen());
                },
                child: Icon(
                  Icons.favorite_border,
                  color: themecontroller.colorPrimary,
                  size: 30.sp,
                ),
              ),
              SizedBox(
                width: 20.sp,
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await homeController.getRecipeData();
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.screenPadding),
              decoration: BoxDecoration(color: themecontroller.backgoundcolor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.sp,
                    ),
                    CustomTextFieldWidget(
                        controller: homeController.SearchController,
                        hintText: 'Search Food..',
                        onsubmit: () {},
                        onchange: (value) {
                          homeController.searchFilter(value);
                        },
                        inputType: TextInputType.name,
                        label: '',
                        enabled: true),
                    Obx(
                      () => homeController.Isloading.value
                          ? SmallLoader()
                          : homeController.filterlist.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Data Not Loaded..',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                )
                              : ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: homeController.filterlist.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = homeController.filterlist[index];
                                    return recipeCard(
                                      recipedata: data,
                                      Isfav: true,
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

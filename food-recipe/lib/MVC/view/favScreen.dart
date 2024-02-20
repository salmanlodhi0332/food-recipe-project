import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe/MVC/controller/homeController.dart';
import 'package:food_recipe/components/custom_textfiled.dart';
import 'package:food_recipe/components/recipeCard.dart';
import 'package:food_recipe/components/small_loader.dart';
import 'package:food_recipe/constant/constants.dart';
import 'package:food_recipe/constant/theme.dart';
import 'package:get/get.dart';

class favListScreen extends StatelessWidget {
  favListScreen({
    super.key,
  });
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
       builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Scaffold(
          appBar: AppBar(title: Text('Favorite Recipes'),),
          body: Container(
            padding:
                EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            decoration: BoxDecoration(color: themecontroller.backgoundcolor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  
                  Obx(
                    () => homeController.Isloading.value
                        ? SmallLoader()
                        : homeController.Favrecipelist.isEmpty
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
                                itemCount: homeController.Favrecipelist.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  var data = homeController.Favrecipelist[index];
                                  return recipeCard(
                                    recipedata: data,
                                    Isfav: false,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

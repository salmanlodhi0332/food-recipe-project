import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe/MVC/controller/homeController.dart';
import 'package:food_recipe/MVC/model/recipeModel.dart';
import 'package:food_recipe/components/image_widget.dart';
import 'package:food_recipe/constant/constants.dart';
import 'package:food_recipe/constant/theme.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';

class recipeCard extends StatelessWidget {
  recipeCard({
    super.key,
    required this.recipedata,
    required this.Isfav
  });
  final RecipeModel recipedata;
  bool Isfav;
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.sp),
        child: Container(
          height: 150.sp,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              height: 120.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(0, 2),
                    spreadRadius: 1.8,
                    blurRadius: 8,
                  ),
                ],
                color: themecontroller.backgoundcolor,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.screenPadding),
                child: Column(children: [
                  SizedBox(
                    height: 50.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.sp,
                        child: Text(
                          recipedata.title,
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14.sp,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      if(Isfav)
                      LikeButton(
                        size: 30.sp,
                        circleColor:
                            CircleColor(start: Colors.orange, end: Colors.red),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.yellowAccent,
                          dotSecondaryColor: Colors.red,
                        ),
                        likeBuilder: (bool isLiked) {
                          if (isLiked) {
                            homeController.addOrRemoveFavorite(recipedata, 1);
                          } else {
                            homeController.addOrRemoveFavorite(recipedata, 0);
                          }
                          return Icon(
                            Icons.favorite,
                            color: isLiked
                                ? Colors.red
                                : themecontroller.colorPrimary,
                            size: 30.sp,
                          );
                        },
                        // onTap: (isLiked) async {
                          
                        //   isLiked = !isLiked;
                        //   print(isLiked);
                          // if (isLiked) {
                          //   homeController.addOrRemoveFavorite(recipedata, 1);
                          // } else {
                          //   homeController.addOrRemoveFavorite(recipedata, 0);
                          // }
                        // },
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Positioned(
              top: 0,
              left: 20.sp,
              child: Container(
                height: 70.sp,
                width: 70.sp,
                child: ClipOval(child: ImageWidget(imageUrl: recipedata.image)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      offset: Offset(0, 2),
                      spreadRadius: 1.8,
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}

//

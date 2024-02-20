import 'package:flutter/material.dart';
import 'package:food_recipe/MVC/model/recipeModel.dart';
import 'package:food_recipe/services/app_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  
  final SearchController = TextEditingController();
  final RxList<RecipeModel> recipelist = <RecipeModel>[].obs;
  final RxBool Isloading = false.obs;

  getRecipeData() async {
    try {
      Isloading.value = true;
      var serverResponse = await AppService.getInstance.getRecipeData();
      recipelist.addAll(serverResponse);

      print('recipelist count :${recipelist.length}');
      Isloading.value = false;
    } catch (e) {
      print('error in getRecipeData: $e');
      Isloading.value = false;
      return [];
    }
  }

  void onClose() {
    super.onClose();
  }
}

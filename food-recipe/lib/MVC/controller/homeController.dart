import 'package:flutter/material.dart';
import 'package:food_recipe/MVC/model/recipeModel.dart';
import 'package:food_recipe/services/app_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final SearchController = TextEditingController();
  final RxList<RecipeModel> recipelist = <RecipeModel>[].obs;
  final RxList<RecipeModel> filterlist = <RecipeModel>[].obs;
  final RxList<RecipeModel> Favrecipelist = <RecipeModel>[].obs;
  final RxBool Isloading = false.obs;

  getRecipeData() async {
    try {
      Isloading.value = true;
      var serverResponse = await AppService.getInstance.getRecipeData();
      recipelist.addAll(serverResponse);

      print('recipelist count :${recipelist.length}');
      searchFilter(SearchController.text);
      Isloading.value = false;
    } catch (e) {
      print('error in getRecipeData: $e');
      Isloading.value = false;
      searchFilter(SearchController.text);
      return [];
    }
  }

  void searchFilter(String search) {
    if (search.isEmpty) {
      filterlist.value = recipelist.value;
    } else {
      List<RecipeModel> filteredList = recipelist
          .where((e) => e.title.toLowerCase().contains(search.toLowerCase()))
          .toList();

      filterlist.value = filteredList;
    }
  }

  addOrRemoveFavorite(RecipeModel recipeData, int actiontype) {
    if (actiontype == 1) {
      Favrecipelist.add(recipeData);
      print('Favrecipelist: ${Favrecipelist.length}');
    } else {
      Favrecipelist.remove(recipeData);
      print('Favrecipelist: ${Favrecipelist.length}');
    }
  }

  void onClose() {
    super.onClose();
  }
}

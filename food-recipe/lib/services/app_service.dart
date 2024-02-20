import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:food_recipe/MVC/model/recipeModel.dart';
import 'package:food_recipe/constant/constants.dart';
import 'package:food_recipe/constant/flutter_toast.dart';

class AppService {
  static AppService? _instance;
  static AppService get getInstance => _instance ??= AppService();

  late Dio dio;

  AppService() {
    // log("headerMap: ${DataStroge.getInstance.headersMap}");
    dio = Dio(
      BaseOptions(
        baseUrl: Constants.API_HOST,

        // headers: DataStroge.getInstance.headersMap,
      ),
    );
    // print("[AppService] ${DataStroge.getInstance.headersMap}");
  }
  void updateDioHeaders() {
    if (dio != null) {
      // dio.options.headers = DataStroge.getInstance.headersMap;
    }
  }

  getRecipeData() async {
    try {
      Response response;
      response = await dio.get(Constants.getrecipes,

      queryParameters: {
            'offset': 0,
            'number': 100,
            'apiKey': '2ea5cc69a1624b26b3add2adce2fd0d6',
            'limitLicense': true
          },
          options: Options(
            headers: {
              // 'Authorization': 'Bearer ${DataStroge.AccessToken}',
            },
          ),
          // data: {
          //   'offset': 0,
          //   'number': 100,
          //   'apiKey': '2ea5cc69a1624b26b3add2adce2fd0d6',
          //   'limitLicense': true
          // }
          );

      print("statusCode => " + response.statusCode.toString());
      print('getRecipeData API done 👌✅');
      print(response.data['data']);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<RecipeModel> recipelist = (response.data as List)
              .map((data) => RecipeModel.fromJson(data))
              .toList();

          return recipelist;
        } else if (responseData is Map) {
          List<RecipeModel> recipelist = (responseData['results'] as List)
              .map((data) => RecipeModel.fromJson(data))
              .toList();

          return recipelist;
        }
      }
    } on DioException catch (e) {
      print(e);
      FlutterToastDisplay.getInstance
          .showToast("${e.response!.data['message']}");
      return [];
    }
  }
}

import 'package:food_recipe/MVC/model/recipeModel.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';

class DataStorage extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    openDatabaseConnection();
  }

  Future<Database> openDatabaseConnection() async {
    return await openDatabase(
      'my_database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE fav_recipetbl (
          id INTEGER PRIMARY KEY,
          title TEXT,
          image TEXT,
          imageType TEXT
        )
      ''');
      print('Database has be created');
      },
    );
  }

  Future<void> insertRecipe(RecipeModel recipe) async {
    final Database db = await openDatabaseConnection();
    await db.insert(
      'fav_recipetbl',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<RecipeModel>> getRecipes() async {
  final Database db = await openDatabaseConnection();
  final List<Map<String, dynamic>> maps = await db.query('fav_recipetbl');

  // Convert List<Map<String, dynamic>> to List<Recipe>
  return List.generate(maps.length, (i) {
    return RecipeModel(
      id: maps[i]['id'],
      title: maps[i]['title'],
      image: maps[i]['image'],
      imageType: maps[i]['imageType'],
    );
  });
}

}

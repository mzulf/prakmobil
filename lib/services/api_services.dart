import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Meal>> getRandomMeals(int count) async {
    List<Meal> meals = [];
    for (int i = 0; i < count; i++) {
      final response = await http.get(Uri.parse('$baseUrl/random.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        meals.add(Meal.fromJson(data['meals'][0]));
      }
    }
    return meals;
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List?)?.map((meal) => Meal.fromJson(meal)).toList() ?? [];
    }
    return [];
  }

  static Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/list.php?c=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List?)?.map((category) => category['strCategory'] as String).toList() ?? [];
    }
    return [];
  }

  static Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List?)?.map((meal) => Meal.fromJson(meal)).toList() ?? [];
    }
    return [];
  }
}
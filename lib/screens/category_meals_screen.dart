import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/dummy_data.dart';
import 'package:meals/widgets/meal_item.dart';

import '../widgets/dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/categories-meal';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    displayMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: displayMeals[index].id,
              title: displayMeals[index].title,
              duration: displayMeals[index].duration,
              affordability: displayMeals[index].affordability,
              imageURL: displayMeals[index].imageUrl,
              complexity: displayMeals[index].complexity);
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}

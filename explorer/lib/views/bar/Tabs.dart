
import 'package:explorer/views/categories/categories.dart';
import 'package:explorer/views/drawer/drawer.dart';
import 'package:explorer/views/mealsscreen/meals.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:explorer/providers/meals_provider.dart';
import 'package:explorer/providers/favoritemeals_provider.dart';
import 'package:explorer/providers/filters_provider.dart';

import '../filters/filter.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  int _selectedPageIndex = 0;


  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String index) async {
    if(index == 'filters'){
      Navigator.of(context).pop();
      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
          builder: (context) => const FilterScreen()
      ));

    }else{
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activefilters = ref.watch(filtersProvider);
    final avaiableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreens(
        avaibleMeals: avaiableMeals,
    );

    Widget activeAppBar = AppBar(
      backgroundColor: Colors.black,
      title: const Text('Categories'),
    );

    Widget secundaryAppBar = AppBar(
        backgroundColor: Colors.black,
        title: const Text('Favorites'),
    );

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
          meals: favoriteMeals,
      );
      activeAppBar = secundaryAppBar;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: activeAppBar,
        automaticallyImplyLeading: false,
      ),
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: _selectPage,
        selectedLabelStyle: const TextStyle(
          color: Colors.amber,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                Icons.category,
              color: _selectedPageIndex == 0 ? Colors.amber : Colors.white,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.star,
                color: _selectedPageIndex == 1 ? Colors.amber : Colors.white
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

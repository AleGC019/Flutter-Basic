import 'package:flutter/material.dart';

class NavigationContainer extends StatelessWidget{

  const NavigationContainer({super.key});

  @override
  Widget build(context){
    return  BottomAppBar(
      color: Colors.white,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  size: 30.0,
                ),
                color: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 30.0,
                ),
                color: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 30.0,
                ),
                color: Colors.black,
                onPressed: () {},
              ),
            ],
          )
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'horizontal_scrollView.dart';

class AppTabMenu extends StatelessWidget {
  final List<String> menuItemsList;
  Function(int index) onItemClick;
  final int selectedIndex;
  final double fontSize;
  final EdgeInsets? margin, padding;

  AppTabMenu(
      {required this.menuItemsList,
        required this.onItemClick,
        required this.selectedIndex,
        this.fontSize = 16,
        this.margin,
        this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      // width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.borderShade3)
      ),
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal:10,
              vertical: 10),
      // padding:padding?? EdgeInsets.all(20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HorizontalScrollView(
              children: List.generate(menuItemsList.length, (index) {
                var menuItem = menuItemsList[index];
                return GestureDetector(
                  onTap:() => onItemClick(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: selectedIndex == index
                                  ? Colors.blue
                                  : Colors.white,
                              width: 5)),
                    ),
                    padding: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
                    child: Text(
                      menuItem,
                     //
                      style: TextStyle(

                          fontSize: fontSize,color: selectedIndex==index?Colors.blue:Colors.black
                      ),


                    ),
                  ),
                );
              }),
            ),
          ]),
    );
  }
}
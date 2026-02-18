import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomNavigationbar extends StatelessWidget {
  const CustomNavigationbar(
      {super.key, required this.ontap, required this.index});

  final int index;
  final Function(int) ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.backgroundcolor,
        unselectedItemColor: AppColors.lighttextcolor.withOpacity(.7),
        currentIndex: index,
        onTap: ontap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_restaurant_sharp),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

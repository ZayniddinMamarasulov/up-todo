import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/utils/colors.dart';
import 'package:up_todo/utils/images.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppImages.ic_menu),
        ),
        backgroundColor: Colors.black,
        title: Text("HomePage"),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      floatingActionButton: Container(
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.C_8687E7,
          ),
          child: Center(
            child: Text(
              "+",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          iconSize: 28,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.50),
          backgroundColor: AppColors.C_363636,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Index',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(null),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch_later_outlined),
              label: 'Focus',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

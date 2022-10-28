import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo/screens/home_page.dart';
import 'package:up_todo/screens/screen_1.dart';
import 'package:up_todo/screens/widgets/add_task_widget.dart';
import 'package:up_todo/utils/colors.dart';
import 'package:up_todo/utils/images.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(),
      Screen1(),
      Container(),
      Container(),
      Container(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(24),
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: AppColors.C_363636,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(AppImages.ic_fingerprint),
                        SizedBox(height: 12),
                        Text(
                          "Please hold your finger at "
                          "the fingerprint scanner to verify your identity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.87),
                              fontSize: 20),
                        ),
                        SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 48),
                                primary: AppColors.C_363636,
                                shadowColor: null,
                                elevation: 0,
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.C_8875FF),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 48),
                                primary: AppColors.C_8687E7,
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Use Password",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
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
      floatingActionButton: Stack(children: [
        Positioned(
          bottom: 34,
          left: 155.9,
          child: Container(
            width: 90,
            height: 45.5,
            decoration: BoxDecoration(
                color: Color(0xff121212),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(76, 80),
                    bottomRight: Radius.elliptical(76, 80))),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 165,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: AppColors.C_363636,
                context: context,
                builder: (context) {
                  return AddTaskWidget(
                    onNewTask: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  );
                },
              );
            },
            child: Container(
                height: 72,
                width: 72,
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
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
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

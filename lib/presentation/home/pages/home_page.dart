import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_training/core/constants/app_colors.dart';
import 'package:flutter_training/presentation/home/pages/calls_page.dart';
import 'package:flutter_training/presentation/home/pages/communities_page.dart';
import 'package:flutter_training/presentation/home/pages/statuses_page.dart';
import 'package:flutter_training/presentation/home/widgets/custom_appbar.dart';

import 'chats_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const ChatsPage(), // index 0
    const StatusesPage(), // index 1
    const CommunitiesPage(), // index 2
    const CallsPage() // index 3
  ];
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  Widget _buildBody(int index) {
    if (index == 0) {
      return const ChatsPage();
    } else if (index == 1) {
      return const StatusesPage();
    } else if (index == 2) {
      return const CommunitiesPage();
    } else if (index == 3) {
      return const CallsPage();
    } else {
      return const Center(child: Text('Page non trouvée'));
    }
  }

  _onCurrentPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(),
      // body: _pages[currentPageIndex],
      // body: _buildBody(currentPageIndex),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onCurrentPageChanged,
        // onPageChanged: (index) => _onCurrentPageChanged(index),
        // onPageChanged: (index) {
        //   _onCurrentPageChanged(index);
        // },
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onCurrentPageChanged,
        indicatorColor: AppColors.primaryLight,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          //Icon: currentIndex == 0 ?? Icon(dark) : Icon(light)
          NavigationDestination( // index 0
            //icon: currentPageIndex == 0 ? Icon(Icons.chat, color: AppColors.primaryDark) : Icon(Icons.chat),
            //selectedIcon: Icon(Icons.chat_outlined, color: AppColors.primaryDark),
            icon: Icon(Icons.chat_outlined, color: currentPageIndex == 0 ? AppColors.primaryDark : null),
            label: 'Discussions',
          ),
          NavigationDestination( // index 1
            icon: Icon(Icons.circle_outlined, color: currentPageIndex == 1 ? AppColors.primaryDark : null),
            label: 'Actus',
          ),
          NavigationDestination( // index 2
            icon: Icon(Icons.groups_outlined, color: currentPageIndex == 2 ? AppColors.primaryDark : null),
            label: 'Communautés',
          ),
          NavigationDestination( // index 3
            icon: Icon(Icons.call_outlined, color: currentPageIndex == 3 ? AppColors.primaryDark : null),
            label: 'Appels',
          ),
        ],
      ),
    );
  }
}

// StatelessWidget = UI fixe (sans memmoire)

// StatefulWidget = UI dynamique (avec memmoire)



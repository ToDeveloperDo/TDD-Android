// 메인 위젯
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/level_select_widget.dart';
import '../widget/period_select_widget.dart';
import '../widget/position_select_widget.dart';
import '../widget/stack_select_widget.dart';

class GoalSettingFlow extends StatefulWidget {
  @override
  _GoalSettingFlowState createState() => _GoalSettingFlowState();
}

class _GoalSettingFlowState extends State<GoalSettingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;  // 현재 페이지 인덱스 추가

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // 스와이프 방지
        children: [
          StackSelectionPage(onNext: () => _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )),
          PositionSelectionPage(onNext: () => _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )),
          PeriodSelectionPage(onNext: () => _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )),
          LevelSelectionPage(onNext: () => _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF8B4DFF),
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '캘린더'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '팀원'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '목표 설정'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}
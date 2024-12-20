import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd/calendar/view/calendar_view.dart';
import 'package:tdd/user/view/profile_view.dart';

import '../../main/provider/navigatior_provider.dart';
import 'objective_view.dart';
import 'objective_flow_view.dart';

class CreateScreen extends ConsumerStatefulWidget {
  static String get routeName => 'createpage';
  const CreateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                ref.read(navigationIndexProvider.notifier).state = 2; // 목표 설정 인덱스 설정
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ObjectiveScreen(),
                  ),
                      (route) => false, // 모든 이전 스택 제거
                );
              },
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          const Spacer(),
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/object_logo.png',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalSettingFlow(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4DFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '시작하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF8B4DFF),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;

          switch (index) {
            case 0: // 캘린더
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendarScreen(),
                ),
                    (route) => false,
              );
              break;
            case 1: // 탐색
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ObjectiveScreen(),
                ),
                    (route) => false,
              );
              break;
            case 2: // 목표 설정
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateScreen(),
                ),
                    (route) => false,
              );
              break;
            case 3: // 내 정보
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
                    (route) => false,
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '캘린더'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '탐색'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '목표 설정'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}

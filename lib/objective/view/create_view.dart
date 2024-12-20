import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main/provider/navigatior_provider.dart';
import 'objective_flow_view.dart';

class CreateScreen extends ConsumerStatefulWidget {
  static String get routeName => "createpage";
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
                Navigator.pop(context);
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

          // 해당 화면으로 이동
          if (index == 0) {
            Navigator.pushNamed(context, '/mainpage');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/calendarpage');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/objectivepage');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profilepage');
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

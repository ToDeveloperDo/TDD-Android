import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelSelectionPage extends StatefulWidget {
  final VoidCallback onNext;

  const LevelSelectionPage({super.key, required this.onNext});

  @override
  State<LevelSelectionPage> createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<LevelSelectionPage> {
  int selectedIndex = 0;
  final List<String> stacks = ['상', '중', '하'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Text(
                '현재 레벨을 알려주세요!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '선택한 수준에 따라 커리큘럼을 세밀하게 조정합니다',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            stacks[selectedIndex],
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 370,
          height: 1,
          color: const Color(0xff647693),
        ),
        const SizedBox(height: 10),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(stacks.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: selectedIndex == index
                        ? const Color(0xFF647693)
                        : Colors.white,
                    side: BorderSide(
                      color: selectedIndex == index
                          ? const Color(0xFF647693)
                          : const Color(0xFFE6E6E6),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: const Size(111, 34), // 버튼 크기를 고정
                  ),
                  child: Text(
                    stacks[index],
                    style: TextStyle(
                      color: selectedIndex == index
                          ? Colors.white
                          : const Color(0xFF666666),
                      fontSize: 14, // 폰트 크기도 약간 키움
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed:(){
            print('생성하기 누름');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4DFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '생성하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

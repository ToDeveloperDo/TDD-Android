import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackSelectionPage extends StatefulWidget {
  final VoidCallback onNext;

  const StackSelectionPage({super.key, required this.onNext});

  @override
  State<StackSelectionPage> createState() => _StackSelectionPageState();
}

class _StackSelectionPageState extends State<StackSelectionPage> {
  int selectedIndex = 0;  // null 대신 0으로 초기화
  final List<String> stacks = [
    'React', 'React1', 'React2', 'React3',
    'React', 'React', 'React', 'React',
    'React', 'React', 'React', 'React',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 60),
          child: Text(
            '어떤 기술을 배우고 싶으신가요?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //SizedBox(height: 70,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            stacks[selectedIndex!],
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.5,
              ),
              itemCount: stacks.length,
              itemBuilder: (context, index) {
                return OutlinedButton(
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    stacks[index],
                    style: TextStyle(
                      color: selectedIndex == index
                          ? Colors.white
                          : const Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4DFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '다음 단계',
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

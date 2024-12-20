import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdd/objective/view/objective_view.dart';
import 'package:tdd/search/view/friend_list_view.dart';

import '../../calendar/view/calendar_view.dart';
import '../../objective/view/create_view.dart';
import '../../user/view/profile_view.dart';
import '../provider/navigatior_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  static String get routeName => "mainpage";

  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();
  String? _tag;
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final FocusNode _tagFocusNode = FocusNode();
  final FocusNode _todoFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final List<Widget> _screens = [
    CalendarScreen(),  // 캘린더 화면
    FriendListScreen(),  // 팀원 화면
    ObjectiveScreen(),  // 할일 화면
    ProfileScreen(),  // 프로필 화면,
    CreateScreen()
  ];
  @override
  void initState() {
    super.initState();
    _tagFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _tagFocusNode.removeListener(_onFocusChange);
    _todoController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    _todoFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_tagFocusNode.hasFocus && _tagController.text.isNotEmpty) {
      _convertToTag();
    }
  }

  void _convertToTag() {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _tag = _tagController.text;
      });
    }
  }

  void _removeTag() {
    setState(() {
      _tag = null;
      _tagController.clear();
    });
    // 태그 입력 필드에 포커스를 주어 키보드가 다시 올라오게 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_tagFocusNode);
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
          backgroundColor: const Color(0xFF8393AD),
          shape: const CircleBorder(),
          elevation: 0,
          child: SvgPicture.asset(
            'assets/images/plus_button.svg',
            width: 24,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_selectedDate.year}년 ${_selectedDate.month.toString().padLeft(2, '0')}월 ${_selectedDate.day.toString().padLeft(2, '0')}일",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _todoController,
                          focusNode: _todoFocusNode,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: '어떤 일을 하시겠습니까?',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _descriptionController,
                          focusNode: _descriptionFocusNode,
                          decoration: const InputDecoration(
                            hintText: '설명을 입력해주세요',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_tag != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: _removeTag,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9F9F9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.local_offer,
                                        color: Color(0xffD7BDFF),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(_tag!),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.close, size: 16),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey.withOpacity(0.3), // 구분선 추가
                              ),
                            ],
                          )
                        else
                          TextField(
                            controller: _tagController,
                            focusNode: _tagFocusNode,
                            decoration: const InputDecoration(
                              hintText: '태그를 입력해주세요',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(),
                            ),
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                _convertToTag();
                              }
                            },
                          ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            shape: const CircleBorder(),
                            mini: true,
                            backgroundColor: const Color(0xFF8393AD),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              // TODO => 할 일 등록 백엔드 API연동
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
            : null, // 캘린더 화면이 아니면 FloatingActionButton 숨김
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                ref.read(navigationIndexProvider.notifier).state = index;
              },
              selectedItemColor: const Color(0xFF8B4DFF),
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              iconSize: 24,
              //onTap: _onTabTapped, // 탭 변경 시 상태 업데이트
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  activeIcon: Icon(Icons.calendar_month),
                  label: "캘린더",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  activeIcon: Icon(Icons.people),
                  label: "탐색",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.checklist_outlined),
                  activeIcon: Icon(Icons.checklist),
                  label: "목표 설정",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: "내 정보",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

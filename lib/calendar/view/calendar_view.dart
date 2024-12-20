import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdd/search/view/friend_list_view.dart';

import '../../objective/view/create_view.dart';
import '../../objective/view/objective_view.dart';
import '../../user/view/profile_view.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static String get routeName => "calendarpage";

  const CalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarScreen> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
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

  void _onTapOutside() {
    if (_tagController.text.isNotEmpty) {
      _convertToTag();
    }
    FocusScope.of(context).unfocus();
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

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday % 7;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_focusedDate);
    final firstDayOfMonth = _getFirstDayOfMonth(_focusedDate);

    return GestureDetector(
      onTap: _onTapOutside,
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        extendBody: true,
        body: Column(
          children: [
            const SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.purple),
                    onPressed: () {
                      setState(() {
                        _focusedDate = DateTime(
                          _focusedDate.year,
                          _focusedDate.month - 1,
                        );
                        _selectedDate = _focusedDate;
                      });
                    },
                  ),
                  const SizedBox(width: 70),
                  Text(
                    "${_focusedDate.year}년 ${_focusedDate.month.toString().padLeft(2, '0')}월",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 70),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: Colors.purple),
                    onPressed: () {
                      setState(() {
                        _focusedDate = DateTime(
                          _focusedDate.year,
                          _focusedDate.month + 1,
                        );
                        _selectedDate = _focusedDate;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 345,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('일', style: TextStyle(color: Colors.red)),
                    Text('월', style: TextStyle(color: Colors.black)),
                    Text('화', style: TextStyle(color: Colors.black)),
                    Text('수', style: TextStyle(color: Colors.black)),
                    Text('목', style: TextStyle(color: Colors.black)),
                    Text('금', style: TextStyle(color: Colors.black)),
                    Text('토', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 345,
              height: 240,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: 42,
                itemBuilder: (context, index) {
                  final prevMonthDays = _getDaysInMonth(
                    DateTime(_focusedDate.year, _focusedDate.month - 1),
                  );

                  final dayNumber = index - firstDayOfMonth + 1;
                  final isValidDay = dayNumber > 0 && dayNumber <= daysInMonth;

                  String displayNumber;
                  if (dayNumber <= 0) {
                    displayNumber = '${prevMonthDays + dayNumber}';
                  } else if (dayNumber > daysInMonth) {
                    displayNumber = '${dayNumber - daysInMonth}';
                  } else {
                    displayNumber = '$dayNumber';
                  }

                  final textColor = !isValidDay
                      ? Colors.grey.withOpacity(0.5)
                      : (index % 7 == 0)
                      ? Colors.red
                      : Colors.black;

                  return GestureDetector(
                    onTap: isValidDay
                        ? () {
                      setState(() {
                        _selectedDate = DateTime(
                          _focusedDate.year,
                          _focusedDate.month,
                          dayNumber,
                        );
                      });
                    }
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isValidDay && dayNumber == _selectedDate.day
                            ? Colors.purple.withOpacity(0.3)
                            : null,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          displayNumber,
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //진행 중
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "진행 중",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xffF2F2F2)),
                  Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool? value) {
                            setState(() {
                              // 체크박스 상태 변경 로직
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xffE5E5E5),
                          side: const BorderSide(
                            color: Color(0xffE5E5E5),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                        ),
                        const Text(
                          "설",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ]
                  ),
                ],

              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "완료",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width:4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CD964),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Color(0xffF2F2F2)),
                  Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {
                            setState(() {
                              // 체크박스 상태 변경 로직
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: const Color(0xff9B69FF),
                          side: const BorderSide(
                            color: Color(0xff9B69FF),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                        ),
                        const Text(
                          "내일 뭐먹지",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ]
                  ),
                ],

              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
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
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

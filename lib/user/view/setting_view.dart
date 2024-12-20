import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd/user/view/profile_view.dart';

class SettingScreen extends ConsumerStatefulWidget {
  static String get routeName => "settingpage";

  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff9B69FF)),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero, // 패딩 제거
        ),
        titleSpacing: 0,
        title: const Text(
          '설정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.pop(context);
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildSettingItem('개인정보 처리 방침'),
            _buildSettingItem('문의하기'),
            _buildSettingItem('팀 소개'),
            _buildSettingItem('로그아웃'),
            _buildSettingItem('회원 탈퇴'),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 16, color: Color(0xff9B69FF)),
          onTap: () {
            // 각 메뉴 항목 클릭 처리
          },
        ),
      ],
    );
  }
}

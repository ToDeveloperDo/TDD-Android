import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/widget/friend_grid.dart';

class FriendListScreen extends ConsumerStatefulWidget{
  static String get routeName => "friendlistpage";

  const FriendListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendListScreen();

}

class _FriendListScreen extends ConsumerState<FriendListScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: Column(
        children: [
          const SizedBox(height: 70),
          // 검색바
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: '계정 검색하기',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 팀원 그리드
          Expanded(
            child:GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return FriendCard(
                  name: '이름',
                  githubUrl: 'https://github.com',
                  onDelete: () {
                    // 삭제 처리
                  },
                  onFollow: () {
                    // 팔로우/언팔로우 처리
                  },
                  isFollowing: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  final String name;
  final String githubUrl;
  final VoidCallback onDelete;
  final VoidCallback onFollow;
  final bool isFollowing;

  const FriendCard({
    super.key,
    required this.name,
    required this.githubUrl,
    required this.onDelete,
    required this.onFollow,
    this.isFollowing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 280,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
              Positioned(
                top: -30,
                right: -45,
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Color(0xffDADADA),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            githubUrl,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 148,
            height: 34,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6D5FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onFollow,
              child: Text(
                isFollowing ? '팔로잉' : '팔로우',
                style: const TextStyle(
                  color: Color(0xFF8B4DFF),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

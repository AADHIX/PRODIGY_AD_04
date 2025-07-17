import 'package:flutter/material.dart';

class ProfileNavBar extends StatelessWidget {
  final String? profileImageUrl;
  final String userName;
  final String userEmail;

  const ProfileNavBar({
    super.key,
    this.profileImageUrl,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: Colors.blueAccent,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
                ? NetworkImage(profileImageUrl!)
                : null,
            backgroundColor: Colors.grey[400],
            child: profileImageUrl == null || profileImageUrl!.isEmpty
                ? const Icon(Icons.person, size: 32, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userEmail,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

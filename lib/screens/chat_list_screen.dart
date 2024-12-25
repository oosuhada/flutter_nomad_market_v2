// screens/chat_list_screen.dart
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, color: Colors.grey[400]),
            ),
            title: const Row(
              children: [
                Text('Sarah Kim'),
                SizedBox(width: 8),
                Icon(Icons.verified, color: Colors.blue, size: 16),
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    '안녕하세요, 해당 상품 구매 가능한가요?',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Text(
                  '오후 2:30',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
        );
      },
    );
  }
}

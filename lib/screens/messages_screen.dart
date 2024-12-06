import 'package:flutter/material.dart';
import 'chat_screen.dart';

/// A screen that displays a list of chat conversations.
/// Includes a search bar at the top and a scrollable list of chat previews below.
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  // Controller for the search input field
  final TextEditingController _searchController = TextEditingController();
  
  // Sample chat data - Replace with actual data from a backend
  final List<ChatPreview> _chats = [
    ChatPreview(
      username: "John Doe",
      lastMessage: "See you tomorrow!",
      time: "10:30 AM",
      avatar: "JD",
      unread: true,
    ),
    ChatPreview(
      username: "Alice Smith",
      lastMessage: "The project looks great!",
      time: "9:15 AM",
      avatar: "AS",
      unread: true,
    ),
    ChatPreview(
      username: "Bob Johnson",
      lastMessage: "Thanks for your help",
      time: "Yesterday",
      avatar: "BJ",
      unread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search bar with subtle background
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search messages...',
              leading: const Icon(Icons.search),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              ),
            ),
          ),
          // List of chat conversations
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return ChatPreviewTile(chat: chat);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _searchController.dispose();
    super.dispose();
  }
}

/// Data model for a chat conversation preview.
/// Contains all the information needed to display a chat in the list.
class ChatPreview {
  final String username;    // Name of the chat participant
  final String lastMessage; // Most recent message in the conversation
  final String time;        // Timestamp of the last message
  final String avatar;      // Initials or image for the avatar
  final bool unread;        // Whether there are unread messages

  ChatPreview({
    required this.username,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    required this.unread,
  });
}

/// A list tile that displays a chat conversation preview.
/// Shows the contact's avatar, name, last message, time, and unread status.
class ChatPreviewTile extends StatelessWidget {
  final ChatPreview chat;

  const ChatPreviewTile({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Navigate to the chat screen when tapped
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              username: chat.username,
              avatar: chat.avatar,
            ),
          ),
        );
      },
      // Avatar with initials
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Text(
          chat.avatar,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      // Contact name
      title: Text(
        chat.username,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      // Preview of the last message
      subtitle: Text(
        chat.lastMessage,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      // Time and unread indicator
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat.time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (chat.unread)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
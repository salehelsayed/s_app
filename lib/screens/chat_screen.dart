import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Represents a single message in the chat.
/// Contains the message content, direction (incoming/outgoing),
/// timestamp, and delivery status.
class Message {
  final String content;    // The text content of the message
  final bool isOutgoing;   // Whether the message was sent by the user
  final DateTime timestamp; // When the message was sent
  final MessageStatus status; // Current delivery status of the message

  Message({
    required this.content,
    required this.isOutgoing,
    required this.timestamp,
    this.status = MessageStatus.sent, // Default status for new messages
  });
}

/// Possible states for message delivery status.
/// Used to display appropriate status indicators (checkmarks).
enum MessageStatus {
  sent,      // Message has been sent but not yet delivered
  delivered, // Message has been delivered to the recipient
  read,      // Message has been read by the recipient
}

/// A screen that displays a chat conversation with a single contact.
/// Shows message history and allows sending new messages.
class ChatScreen extends StatefulWidget {
  final String username; // Name of the contact
  final String avatar;   // Contact's avatar initials

  const ChatScreen({
    super.key,
    required this.username,
    required this.avatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Controller for the message input field
  final TextEditingController _messageController = TextEditingController();
  // Controller for the scrollable message list
  final ScrollController _scrollController = ScrollController();

  // Sample message data - Replace with actual chat history from a backend
  final List<Message> _messages = [
    Message(
      content: "Hi there! How are you?",
      isOutgoing: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Message(
      content: "I'm doing great, thanks! How about you?",
      isOutgoing: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      status: MessageStatus.read,
    ),
    Message(
      content: "Pretty good! Did you see the new Flutter update?",
      isOutgoing: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    Message(
      content: "Yes, the new Material 3 features look amazing!",
      isOutgoing: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      status: MessageStatus.delivered,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom app bar with contact info
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            // Contact's avatar
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                widget.avatar,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(widget.username),
          ],
        ),
      ),
      body: Column(
        children: [
          // Scrollable list of messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(message: message);
              },
            ),
          ),
          // Message input bar at the bottom
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Text input field
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceVariant,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handles sending a new message.
  /// Adds the message to the list and scrolls to the bottom.
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          content: _messageController.text,
          isOutgoing: true,
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
    });

    // Scroll to bottom after message is sent
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

/// A widget that displays a single message bubble.
/// Handles both incoming and outgoing messages with appropriate styling.
class _MessageBubble extends StatelessWidget {
  final Message message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutgoing = message.isOutgoing;

    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isOutgoing ? 64 : 0,
          right: isOutgoing ? 0 : 64,
          bottom: 8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isOutgoing
              ? theme.colorScheme.primary.withOpacity(0.9)
              : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment:
              isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Message content
            Text(
              message.content,
              style: TextStyle(
                color: isOutgoing
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            // Timestamp and status indicators
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timeago.format(message.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: isOutgoing
                        ? theme.colorScheme.onPrimary.withOpacity(0.7)
                        : theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                  ),
                ),
                if (isOutgoing) ...[
                  const SizedBox(width: 4),
                  Icon(
                    _getStatusIcon(message.status),
                    size: 14,
                    color: theme.colorScheme.onPrimary.withOpacity(0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the appropriate icon for the message status.
  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return Icons.check;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.read:
        return Icons.done_all;
    }
  }
}

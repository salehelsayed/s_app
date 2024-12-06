class CommunityPost {
  final User author;
  final String communityName;
  final String content;
  final ReferencedPost referencedPost;
  final PostEngagement engagement;
  final DateTime timestamp;

  CommunityPost({
    required this.author,
    required this.communityName,
    required this.content,
    required this.referencedPost,
    required this.engagement,
    required this.timestamp,
  });
}

class User {
  final String name;
  final String handle;
  final String avatarUrl;
  final bool isAdmin;

  User({
    required this.name,
    required this.handle,
    required this.avatarUrl,
    this.isAdmin = false,
  });
}

class ReferencedPost {
  final User author;
  final String content;
  final List<String> mediaUrls;
  final DateTime timestamp;

  ReferencedPost({
    required this.author,
    required this.content,
    this.mediaUrls = const [],
    required this.timestamp,
  });
}

class PostEngagement {
  final int comments;
  final int reposts;
  final int likes;
  final int views;
  bool isBookmarked;

  PostEngagement({
    required this.comments,
    required this.reposts,
    required this.likes,
    required this.views,
    this.isBookmarked = false,
  });
}

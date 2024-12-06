import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommunityPostCard extends StatelessWidget {
  final CommunityPost post;
  final VoidCallback? onCommentTap;
  final VoidCallback? onRepostTap;
  final VoidCallback? onLikeTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;

  const CommunityPostCard({
    super.key,
    required this.post,
    this.onCommentTap,
    this.onRepostTap,
    this.onLikeTap,
    this.onBookmarkTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post.author.avatarUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (post.author.isAdmin) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Admin',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        post.communityName,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  timeago.format(post.timestamp),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Post content
            Text(
              post.content,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),

            // Referenced post
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          post.referencedPost.author.avatarUrl,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.referencedPost.author.name,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '@${post.referencedPost.author.handle}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.referencedPost.content,
                    style: theme.textTheme.bodyMedium,
                  ),
                  if (post.referencedPost.mediaUrls.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        post.referencedPost.mediaUrls.first,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Engagement bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _EngagementButton(
                  icon: Icons.chat_bubble_outline,
                  count: post.engagement.comments,
                  onTap: onCommentTap,
                ),
                _EngagementButton(
                  icon: Icons.repeat,
                  count: post.engagement.reposts,
                  onTap: onRepostTap,
                ),
                _EngagementButton(
                  icon: Icons.favorite_border,
                  count: post.engagement.likes,
                  onTap: onLikeTap,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.engagement.views}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    post.engagement.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                  onPressed: onBookmarkTap,
                  color: post.engagement.isBookmarked
                      ? theme.colorScheme.primary
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: onShareTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EngagementButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  const _EngagementButton({
    required this.icon,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

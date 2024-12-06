import 'package:flutter/material.dart';
import 'community_search_screen.dart';
import '../models/post.dart';
import '../widgets/community_post_card.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Sports', 'Technology', 'Art', 'Entertainment', 'Development', 'Design'];
  
  final List<CommunityPost> _posts = [
    CommunityPost(
      author: User(
        name: 'Mo',
        handle: 'mo_kdrama',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        isAdmin: true,
      ),
      communityName: 'Kdrama Chingus',
      content: 'This new drama looks amazing! Can\'t wait to watch it 😍',
      referencedPost: ReferencedPost(
        author: User(
          name: 'K-Drama Handle',
          handle: 'kdrama_updates',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
        ),
        content: 'First look at the upcoming drama "Love in the Moonlight" starring Park Min Young! 🌙✨',
        mediaUrls: ['https://picsum.photos/400/300'],
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      engagement: PostEngagement(
        comments: 45,
        reposts: 12,
        likes: 189,
        views: 1542,
      ),
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    CommunityPost(
      author: User(
        name: 'Sarah',
        handle: 'anime_sarah',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      communityName: 'Anime Haven',
      content: 'The animation quality in this scene is just incredible!',
      referencedPost: ReferencedPost(
        author: User(
          name: 'Anime News Network',
          handle: 'anime_news',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
        ),
        content: 'Behind the scenes look at the making of the latest episode of "Attack on Titan" #AOT',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      engagement: PostEngagement(
        comments: 78,
        reposts: 234,
        likes: 892,
        views: 3211,
        isBookmarked: true,
      ),
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    CommunityPost(
      author: User(
        name: 'TechGuru',
        handle: 'tech_guru',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        isAdmin: true,
      ),
      communityName: 'Tech Enthusiasts',
      content: 'This could be a game-changer for mobile development!',
      referencedPost: ReferencedPost(
        author: User(
          name: 'Tech News Daily',
          handle: 'technews',
          avatarUrl: 'https://i.pravatar.cc/150?img=6',
        ),
        content: 'Breaking: Google announces new Flutter features for cross-platform development. Major improvements in performance and developer experience! 🚀',
        mediaUrls: ['https://picsum.photos/400/200'],
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      engagement: PostEngagement(
        comments: 156,
        reposts: 445,
        likes: 1203,
        views: 5678,
      ),
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
  ];

  final List<Community> _communities = [
    Community(
      name: "Flutter Developers",
      description: "A community for Flutter enthusiasts",
      memberCount: "15.2K",
      category: "Development",
      imageUrl: "https://picsum.photos/200",
      members: List.generate(
        5,
        (index) => Member(
          name: "User ${index + 1}",
          avatarUrl: "https://i.pravatar.cc/150?img=${index + 1}",
        ),
      ),
    ),
    Community(
      name: "UI/UX Design",
      description: "Share and discuss UI/UX design ideas",
      memberCount: "8.7K",
      category: "Design",
      imageUrl: "https://picsum.photos/201",
      members: List.generate(
        5,
        (index) => Member(
          name: "Designer ${index + 1}",
          avatarUrl: "https://i.pravatar.cc/150?img=${index + 6}",
        ),
      ),
    ),
    Community(
      name: "Mobile App Development",
      description: "Mobile app development discussions",
      memberCount: "12.4K",
      category: "Development",
      imageUrl: "https://picsum.photos/202",
      members: List.generate(
        5,
        (index) => Member(
          name: "Dev ${index + 1}",
          avatarUrl: "https://i.pravatar.cc/150?img=${index + 11}",
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommunitySearchScreen(
                    filters: _filters,
                    communities: _communities,
                  ),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Explore'),
            Tab(text: 'My Communities'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Explore Tab
          Column(
            children: [
              // Filter Chips Row
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        label: Text(filter),
                        selected: _selectedFilter == filter,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = filter;
                            // TODO: Filter posts based on selected category
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              // Posts List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return CommunityPostCard(
                      post: post,
                      onCommentTap: () {
                        // Handle comment tap
                      },
                      onRepostTap: () {
                        // Handle repost tap
                      },
                      onLikeTap: () {
                        // Handle like tap
                      },
                      onBookmarkTap: () {
                        setState(() {
                          post.engagement.isBookmarked = !post.engagement.isBookmarked;
                        });
                      },
                      onShareTap: () {
                        // Handle share tap
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          // My Communities Tab
          ListView.builder(
            itemCount: _communities.length,
            itemBuilder: (context, index) {
              return CommunityCard(
                community: _communities[index],
                onTap: () {
                  // Handle community selection
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class Community {
  final String name;
  final String description;
  final String memberCount;
  final String category;
  final String imageUrl;
  final List<Member> members;

  Community({
    required this.name,
    required this.description,
    required this.memberCount,
    required this.category,
    required this.imageUrl,
    required this.members,
  });
}

class Member {
  final String name;
  final String avatarUrl;

  Member({
    required this.name,
    required this.avatarUrl,
  });
}

class CommunityCard extends StatelessWidget {
  final Community community;
  final VoidCallback onTap;

  const CommunityCard({
    super.key,
    required this.community,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      community.imageUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 64,
                          height: 64,
                          color: theme.colorScheme.primary,
                          child: Icon(
                            Icons.group,
                            color: theme.colorScheme.onPrimary,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          community.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          community.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${community.memberCount} members • ${community.category}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 32,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: community.members.length,
                  itemBuilder: (context, index) {
                    return Align(
                      widthFactor: 0.7,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          community.members[index].avatarUrl,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
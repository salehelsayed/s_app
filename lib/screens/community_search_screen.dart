import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'community_screen.dart';

class CommunitySearchScreen extends StatefulWidget {
  final List<String> filters;
  final List<Community> communities;

  const CommunitySearchScreen({
    super.key,
    required this.filters,
    required this.communities,
  });

  @override
  State<CommunitySearchScreen> createState() => _CommunitySearchScreenState();
}

class _CommunitySearchScreenState extends State<CommunitySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  List<Community> get _filteredCommunities {
    return widget.communities.where((community) {
      // Apply category filter
      if (_selectedFilter != 'All' && community.category != _selectedFilter) {
        return false;
      }
      
      // Apply search query
      if (_searchQuery.isEmpty) {
        return true;
      }
      
      final query = _searchQuery.toLowerCase();
      return community.name.toLowerCase().contains(query) ||
             community.description.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          controller: _searchController,
          hintText: 'Search communities...',
          leading: const Icon(Icons.search),
          trailing: [
            if (_searchQuery.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                },
              ),
          ],
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            theme.colorScheme.surfaceVariant.withOpacity(0.3),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 80,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips
          SizedBox(
            height: 56,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: widget.filters.length,
              itemBuilder: (context, index) {
                final filter = widget.filters[index];
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(filter),
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Results
          Expanded(
            child: _filteredCommunities.isEmpty
                ? Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? 'No communities found for $_selectedFilter'
                          : 'No communities found for "$_searchQuery"',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCommunities.length,
                    itemBuilder: (context, index) {
                      return CommunityCard(
                        community: _filteredCommunities[index],
                        onTap: () {
                          // Handle community selection
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../core/design_system/still_widgets.dart';
import '../data/static_library_repository.dart';
import '../domain/library_item.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  LibraryCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final filteredItems = _selectedCategory == null
        ? StaticLibraryRepository.items
        : StaticLibraryRepository.getByCategory(_selectedCategory!);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.support,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.onSurfaceVariant),
                      onPressed: () => context.pop(),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(height: 16),
                    const StillSectionHeader(
                      title: 'Sessiz Kütüphane',
                      subtitle: 'Zor anlarda kısa ve sakin okumalar.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Categories Filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _CategoryChip(
                      label: 'Tümü',
                      isSelected: _selectedCategory == null,
                      onTap: () => setState(() => _selectedCategory = null),
                    ),
                    ...LibraryCategory.values.map((cat) => _CategoryChip(
                      label: cat.label,
                      isSelected: _selectedCategory == cat,
                      onTap: () => setState(() => _selectedCategory = cat),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 180),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _LibraryItemCard(item: item),
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

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.outline.withValues(alpha: 0.2),
          ),
        ),
        showCheckmark: false,
      ),
    );
  }
}

class _LibraryItemCard extends StatelessWidget {
  final LibraryItem item;

  const _LibraryItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return StillGlassCard(
      onTap: () => context.push('/library/${item.id}'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.category.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: AppColors.outline),
                  const SizedBox(width: 4),
                  Text(
                    '${item.estimatedMinutes} dk',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.outline),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Literata',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.summary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.type.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.tertiary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.outline),
            ],
          ),
        ],
      ),
    );
  }
}

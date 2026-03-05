import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class PetCard extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final Color backgroundColor;
  final bool isAddNew;
  final bool isEmptyState;
  final VoidCallback? onTap;

  const PetCard({
    super.key,
    this.name,
    this.imageUrl,
    required this.backgroundColor,
    this.isAddNew = false,
    this.isEmptyState = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmptyState) {
      return _buildEmptyState();
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  if (isAddNew)
                    Center(
                      child: Icon(
                        Icons.add,
                        size: 36,
                        color: AppColors.primaryBright.withValues(alpha: 0.8),
                      ),
                    )
                  else if (imageUrl != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.pets,
                            size: 40,
                            color: AppColors.primaryBright.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!isAddNew && name != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star,
                          color: AppColors.warning,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (name != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.pets, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildStatIndicators(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatIndicators() {
    return Row(
      children: [
        _buildDot(AppColors.success),
        _buildDot(AppColors.primary),
        _buildDot(AppColors.secondary),
      ],
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets_outlined,
            size: 48,
            color: AppColors.primaryBright.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'Нет питомцев',
            style: TextStyle(color: AppColors.textGrey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Нажмите + чтобы добавить',
            style: TextStyle(
              color: AppColors.textGrey.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

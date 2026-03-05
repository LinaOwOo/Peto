import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/mini_calendar.dart';
import '../../../../shared/widgets/category_filter.dart';
import '../../../../shared/widgets/pet_card.dart';
import '../../../../shared/widgets/action_buttons_row.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../providers/home_provider.dart';
import '../widgets/add_pet_dialog.dart'; // ← Добавить этот импорт

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              MiniCalendar(),
              const SizedBox(height: 24),
              CategoryFilter(
                selectedCategory: homeState.selectedCategory,
                onCategorySelected: homeNotifier.setCategory,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: homeState.filteredPets.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return PetCard(
                        name: 'Add',
                        imageUrl: '',
                        backgroundColor: AppColors.surface,
                        isAddNew: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AddPetDialog(
                              preselectedCategory:
                                  homeState.selectedCategory != PetCategory.all
                                  ? homeState.selectedCategory
                                  : null,
                            ),
                          );
                        },
                      );
                    }
                    final pet = homeState.filteredPets[index - 1];
                    return PetCard(
                      name: pet.name,
                      imageUrl: pet.imageUrl,
                      backgroundColor: pet.cardColor,
                      onTap: () {
                        // Переход на экран питомца (добавим позже)
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const ActionButtonsRow(),
              const SizedBox(height: 24),
              BottomNavBar(
                selectedIndex: _navIndex,
                onItemSelected: (index) => setState(() => _navIndex = index),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/pet_model.dart';
import '../../../shared/widgets/category_filter.dart';

class HomeState {
  final List<PetModel> allPets;
  final List<PetModel> filteredPets;
  final PetCategory selectedCategory;
  final bool isLoading;

  const HomeState({
    required this.allPets,
    required this.filteredPets,
    required this.selectedCategory,
    this.isLoading = false,
  });

  HomeState copyWith({
    List<PetModel>? allPets,
    List<PetModel>? filteredPets,
    PetCategory? selectedCategory,
    bool? isLoading,
  }) {
    return HomeState(
      allPets: allPets ?? this.allPets,
      filteredPets: filteredPets ?? this.filteredPets,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier()
    : super(
        HomeState(
          allPets: PetModel.mockData,
          filteredPets: PetModel.mockData,
          selectedCategory: PetCategory.all,
        ),
      );

  void setCategory(PetCategory category) {
    if (category == PetCategory.all) {
      state = state.copyWith(
        selectedCategory: category,
        filteredPets: state.allPets,
      );
    } else {
      final typeMap = {
        PetCategory.dog: 'dog',
        PetCategory.cat: 'cat',
        PetCategory.turtle: 'turtle',
        PetCategory.rabbit: 'rabbit',
      };

      final filtered = state.allPets
          .where((pet) => pet.type == typeMap[category])
          .toList();

      state = state.copyWith(
        selectedCategory: category,
        filteredPets: filtered,
      );
    }
  }

  void addPet(PetModel pet) {
    final updatedList = [...state.allPets, pet];
    state = state.copyWith(
      allPets: updatedList,
      filteredPets: state.selectedCategory == PetCategory.all
          ? updatedList
          : updatedList.where((p) => p.type == pet.type).toList(),
    );
  }

  void removePet(String id) {
    final updatedList = state.allPets.where((p) => p.id != id).toList();
    state = state.copyWith(
      allPets: updatedList,
      filteredPets: state.selectedCategory == PetCategory.all
          ? updatedList
          : updatedList
                .where((p) => p.type == state.filteredPets.firstOrNull?.type)
                .toList(),
    );
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

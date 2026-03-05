import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class PetModel extends Equatable {
  final String id;
  final String name;
  final String? breed;
  final DateTime? birthDate;
  final String? imageUrl;
  final Color cardColor;
  final String type;

  const PetModel({
    required this.id,
    required this.name,
    this.breed,
    this.birthDate,
    this.imageUrl,
    required this.cardColor,
    required this.type,
  });

  static List<PetModel> get mockData => [];

  int get age {
    if (birthDate == null) return 0;
    final now = DateTime.now();
    int age = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    breed,
    birthDate,
    imageUrl,
    cardColor,
    type,
  ];
}

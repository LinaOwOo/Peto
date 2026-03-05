import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../shared/widgets/app_icon.dart';
import '../../../../shared/widgets/category_filter.dart';
import '../../data/models/pet_model.dart';
import '../../providers/home_provider.dart';

class AddPetDialog extends ConsumerStatefulWidget {
  final PetCategory? preselectedCategory;

  const AddPetDialog({super.key, this.preselectedCategory});

  @override
  ConsumerState<AddPetDialog> createState() => _AddPetDialogState();
}

class _AddPetDialogState extends ConsumerState<AddPetDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  DateTime? _birthDate;
  PetCategory _selectedType = PetCategory.dog;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.preselectedCategory != null &&
        widget.preselectedCategory != PetCategory.all) {
      _selectedType = widget.preselectedCategory!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Новый питомец',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBright,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textGrey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Фото питомца
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.info,
                      borderRadius: BorderRadius.circular(20),
                      image: _imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(_imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imageUrl == null
                        ? const Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                            color: AppColors.primaryBright,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 24),

                // Тип питомца
                _buildTypeSelector(),
                const SizedBox(height: 16),

                // Поля ввода
                _buildInput(
                  'Кличка',
                  _nameController,
                  Icons.pets,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Введите кличку' : null,
                ),
                const SizedBox(height: 16),
                _buildInput('Порода', _breedController, Icons.info),
                const SizedBox(height: 16),
                _buildDatePicker(),
                const SizedBox(height: 24),

                // Кнопка сохранения
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Тип питомца',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildTypeChip(PetCategory.dog, AppIcons.blueDog),
            const SizedBox(width: 8),
            _buildTypeChip(PetCategory.cat, AppIcons.blueCat),
            const SizedBox(width: 8),
            _buildTypeChip(PetCategory.turtle, AppIcons.blueTurtle),
            const SizedBox(width: 8),
            _buildTypeChip(PetCategory.rabbit, AppIcons.blueRabbit),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeChip(PetCategory type, String iconPath) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBright : Colors.transparent,
            width: 2,
          ),
        ),
        child: AppIcon(
          iconPath: iconPath,
          size: 20,
          color: isSelected ? Colors.white : null,
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller,
    IconData icon, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryBright),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: AppColors.primaryBright),
            const SizedBox(width: 12),
            Text(
              _birthDate == null
                  ? 'Дата рождения'
                  : '${_birthDate!.day}.${_birthDate!.month}.${_birthDate!.year}',
              style: TextStyle(
                color: _birthDate == null
                    ? AppColors.textGrey
                    : AppColors.textDark,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            if (_birthDate != null)
              IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () => setState(() => _birthDate = null),
                color: AppColors.textGrey,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    // Здесь будет логика выбора изображения
    // Для демо используем заглушку
    setState(() {
      _imageUrl = 'https://placehold.co/400x400/E8C885/white?text=Pet';
    });
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBright,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() => _birthDate = date);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final colorMap = {
        PetCategory.dog: const Color(0xFFE8C885),
        PetCategory.cat: const Color(0xFFD8C4C4),
        PetCategory.turtle: const Color(0xFF85E8B0),
        PetCategory.rabbit: const Color(0xFFEEB8B9),
      };

      final newPet = PetModel(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        breed: _breedController.text.trim().isEmpty
            ? null
            : _breedController.text.trim(),
        birthDate: _birthDate,
        imageUrl: _imageUrl,
        cardColor: colorMap[_selectedType]!,
        type: _selectedType.name,
      );

      ref.read(homeProvider.notifier).addPet(newPet);
      Navigator.pop(context);

      // Показываем успешное добавление
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newPet.name} добавлен!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}

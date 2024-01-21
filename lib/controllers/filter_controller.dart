
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionController extends GetxController {
  RxString tempSelectedCategory = 'All'.obs;
  RxString tempSelectedDiet = 'Vegetarian'.obs;
  RxString tempSelectedDifficulty = 'Easy'.obs;
  RxInt tempSelectedRating = 0.obs;
  RxString selectedCategory = 'All'.obs;
  RxInt selectedRating = 0.obs;
  RxString selectedDiet = 'Vegetarian'.obs;
  RxString selectedDifficulty = 'Easy'.obs;
  Rx<RangeValues> tempRangeValues = Rx<RangeValues>(const RangeValues(20, 40));
  Rx<RangeValues> selectedRangeValues =
      Rx<RangeValues>(const RangeValues(20, 40));

  // Методи для оновлення тимчасових змінних

  void setTempSelectedCategory(String category) {
    tempSelectedCategory.value = category;
  }

  void setTempSelectedDiet(String diet) {
    tempSelectedDiet.value = diet;
  }

  void setTempSelectedDifficulty(String difficulty) {
    tempSelectedDifficulty.value = difficulty;
  }

  void setTempSelectedRating(int rating) {
    tempSelectedRating.value = rating;
  }

  void setTempSelectedSlider(RangeValues value) {
    tempRangeValues.value = value;
  }

    // Скидання фільтрів
  void resetFilters() {
    selectedCategory.value = 'All';
    selectedRating.value = 0;
    
selectedDiet.value = 'Vegetarian';
   selectedDifficulty.value = 'Easy';
    tempSelectedCategory.value = 'All';
   tempSelectedDiet.value = 'Vegetarian';
   tempSelectedDifficulty.value = 'Easy';
   tempSelectedRating.value = 0;
    //... скинути до початкових значень
  }

 bool get hasActiveFilters => selectedCategory.value != 'All' || selectedRating.value != 0 || selectedDiet.value != 'Vegetarian' || selectedDifficulty.value != 'Easy';
  void onOpenFilterPage() {
    tempSelectedCategory. value = selectedCategory.value;
    tempSelectedDiet.value = selectedDiet.value;
    tempSelectedDifficulty.value = selectedDifficulty.value;
    tempSelectedRating.value = selectedRating.value;
    tempRangeValues.value = selectedRangeValues.value;
  }

  void saveFilters() {
    selectedCategory.value = tempSelectedCategory.value;
    selectedDiet.value = tempSelectedDiet.value;
    selectedDifficulty.value = tempSelectedDifficulty.value;
    selectedRangeValues.value = tempRangeValues.value;
    Get.back();
  }
}

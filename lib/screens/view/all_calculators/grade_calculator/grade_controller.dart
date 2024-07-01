import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradeController extends GetxController{
  var courseControllers = [].obs;
  var courseControllersLetter = [].obs;
  var weightControllers = [].obs;
  var gradeControllers = [].obs;
  var additionalWeightController = TextEditingController().obs;
  var averageGrade = 0.0.obs;
  var averageLetterGrade = ''.obs;
  var additionalGrade = 0.0.obs;
  var additionalLetterGrade = ''.obs;
  var formKey = GlobalKey<FormState>().obs;
  var selectedButton = true.obs;
  var radioButtonStatus = "1".obs;
  var overallGPA = 0.0.obs;
  var totalCredit = 0.obs;
  var totalCreditWithoutPNP = 0.obs;
  var averageCalculation = ''.obs;

  @override
  void onInit() {
    super.onInit();
    addCourse();
    initialCourse();
  }
  var instructorControllers = [].obs;
  var instructorControllersLetter = [].obs;
  var selectedGrades = [].obs;
  var gradeOptions = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D+',
    'D',
    'D-',
    'F',
    'P',
    'NP'
  ].obs;
  void addCourse() {
      courseControllers.add(TextEditingController());
      weightControllers.add(TextEditingController());
      gradeControllers.add(TextEditingController());
  }

  String gradeToLetter(double grade) {
    if (grade >= 97) return 'A+';
    if (grade >= 93) return 'A';
    if (grade >= 90) return 'A-';
    if (grade >= 87) return 'B+';
    if (grade >= 83) return 'B';
    if (grade >= 80) return 'B-';
    if (grade >= 77) return 'C+';
    if (grade >= 73) return 'C';
    if (grade >= 70) return 'C-';
    if (grade >= 67) return 'D+';
    if (grade >= 63) return 'D';
    if (grade >= 60) return 'D-';
    if (grade >= 0) return 'F';
    return 'F';
  }
  String letter(double grade) {
    if (grade >= 4.165) return 'A+';
    if (grade >= 3.835) return 'A';
    if (grade >= 3.5) return 'A-';
    if (grade >= 3.165) return 'B+';
    if (grade >= 2.835) return 'B';
    if (grade >= 2.5) return 'B-';
    if (grade >= 2.165) return 'C+';
    if (grade >= 1.835) return 'C';
    if (grade >= 1.5) return 'C-';
    if (grade >= 1.165) return 'D+';
    if (grade >= .835) return 'D';
    if (grade >= .335) return 'D-';
    if (grade >= 0) return 'F';
    return 'F';
  }
  void addCourseLetter() {
    courseControllersLetter.add(TextEditingController());
    instructorControllersLetter.add(TextEditingController());
    selectedGrades.add(gradeOptions[0]);
  }
  void initialCourse() {

    courseControllersLetter.add(TextEditingController());
    instructorControllersLetter.add(TextEditingController());
    selectedGrades.add(gradeOptions[0]);
  }
  double returnValue(String grade) {
    // Replace this with your logic to return a value based on the grade
    switch (grade) {
      case 'A+':
        return 4.3;
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D+':
        return 1.3;
      case 'D':
        return 1.0;
      case 'D-':
        return 0.7;
      case 'F':
        return 0.0;
      case 'P':
        return 0.0;
      case 'NP':
        return 0.0;
      default:
        return 0.0;
    }
  }
  void calculateAdditionalGrade() {
    double totalWeightedGrades = 0.0;
    double totalWeight = 0.0;
    String r = "";
    String a = "";
    double t = 0.0;
    double avg = 0.0;
    int additionalWeight = int.parse(additionalWeightController.value.text);
    for (int i = 0; i < courseControllers.length; i++) {
      double gradeValue = double.tryParse(gradeControllers[i].text) ?? 0.0;
      double weight = double.tryParse(weightControllers[i].text) ?? 0.0;
      totalWeightedGrades += gradeValue * weight;
      totalWeight += gradeValue;
      if (i > 0) {
        r += " + ";
        a += " + ";
      }
      r += "$gradeValue×$weight";
      a += "$gradeValue";
      t += gradeValue;
      avg += weight * gradeValue;
    }
    double initialAvg = avg;
    double averageGPA = totalWeight > 0 ? totalWeightedGrades / totalWeight : 0.0;
    var totalGrades = totalWeightedGrades /= totalWeight;
     additionalGrade.value = (100 * additionalWeight - totalWeight * totalGrades) / (100 - totalWeight);
     additionalLetterGrade.value = gradeToLetter(additionalGrade.value);

      averageGrade.value = averageGPA;
      averageLetterGrade.value = gradeToLetter(averageGrade.value);
     averageCalculation.value = "($r) / ($a) = ${roundresult(initialAvg)} / ${roundresult(t)} = ${averageGrade.value.toStringAsFixed(2)}";
    print("averageCalculation ${averageGrade.value} ${averageLetterGrade.value}");
    print("averageCalculation $averageCalculation");

  }

  String roundresult(double value) {
    return value.toStringAsFixed(2);
  }
  void totalGPA() {
    for (var i = 0; i < selectedGrades.length; i++) {
      overallGPA.value = overallGPA.value +
          double.parse((returnValue(selectedGrades[i]) *
              int.parse(instructorControllersLetter[i].text))
              .toStringAsFixed(1));
      if (selectedGrades[i] != "P") {
        if (selectedGrades[i] != "NP") {
          totalCreditWithoutPNP.value = totalCreditWithoutPNP.value +
              int.parse(instructorControllersLetter[i].text);
        }
      }
    }
  }

  void totalGrades() {
    for (var i = 0; i < selectedGrades.length; i++) {
      totalCredit.value =
          totalCredit.value + int.parse(instructorControllersLetter[i].text);
    }
  }
}
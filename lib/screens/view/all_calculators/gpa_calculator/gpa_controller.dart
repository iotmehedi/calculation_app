import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GPAController extends GetxController{
  var courseControllers = [].obs;
  var instructorControllers = [].obs;
  var selectedGrades = [].obs;
  var gradeOptions = ['A+','A','A-','B+','B', 'B-', 'C+','C','C-','D+','D','D-','F','P','NP'].obs;
  var totalCredit = 0.obs;
  var totalCreditWithoutPNP = 0.obs;
  var overallGPA = 0.0.obs;
  var formKey = GlobalKey<FormState>().obs;
  @override
  void onInit() {
    initialCourse();
    super.onInit();
  }

  void initialCourse() {
      courseControllers.add(TextEditingController());
      instructorControllers.add(TextEditingController());
      selectedGrades.add(gradeOptions[0]);
  }
  void addCourse() {
      courseControllers.add(TextEditingController());
      instructorControllers.add(TextEditingController());
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
 void totalGPA(){
    for(var i = 0; i < selectedGrades.length; i++){
      overallGPA.value =  overallGPA.value + double.parse((returnValue(selectedGrades[i]) * int.parse(instructorControllers[i].text)).toStringAsFixed(1));
      if(selectedGrades[i] != "P"){
        if(selectedGrades[i] != "NP"){
          totalCreditWithoutPNP.value = totalCreditWithoutPNP.value + int.parse( instructorControllers[i].text);
        }
      }
    }
 }
 void totalGrades(){
   for(var i = 0; i < selectedGrades.length; i++){
     totalCredit.value = totalCredit.value + int.parse( instructorControllers[i].text);
    }
 }
}
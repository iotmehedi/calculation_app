import 'package:get/get.dart';

class PregnancyCalculatorController extends GetxController{
  List<Map<String, Object>> milestones = [{}];
  List<Map<String, Object>> milestones2 = [{}];
  List<Map<String, Object>> milestones3 = [{}];
  
  int months = 0;
  int remainingDays = 0;
  int weeksDifference = 0;
  int daysDifference = 0;
  String lastPeriod = '';
  String currentTrimester = '';
  String conceviedDate = '';
  String dueDate = '';
  void lastPeriodFunction(DateTime dueDate){
    milestones = [
      {
        "week_name": '1 weeks',
        "weeks": dueDate.add(const Duration(days: -40 * 7 + 1)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '2 weeks',
        "weeks": dueDate.add(const Duration(days: -39 * 7 + 1)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '3 weeks',
        "weeks": dueDate.add(const Duration(days: -38 * 7 + 1)),
        "line1": "Baby",
        "line2": "conceive",
        "line3": "are flickering"
      },
      {
        "week_name": '4 weeks',
        "weeks": dueDate.add(const Duration(days: -37 * 7 + 1)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '5 weeks',
        "weeks": dueDate.add(const Duration(days: -36 * 7 + 1)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '6 weeks',
        "weeks": dueDate.add(const Duration(days: -35 * 7 + 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
      {
        "week_name": '7 weeks',
        "weeks": dueDate.add(const Duration(days: -34 * 7 + 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
      {
        "week_name": '8 weeks',
        "weeks": dueDate.add(const Duration(days: -33 * 7 + 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
      {
        "week_name": '9 weeks',
        "weeks": dueDate.add(const Duration(days: -32 * 7 + 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
      {
        "week_name": '10 weeks',
        "weeks": dueDate.add(const Duration(days: -31 * 7 + 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
      {
        "week_name": '11 weeks',
        "weeks": dueDate.add(const Duration(days: -30 * 7 + 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
      {
        "week_name": '12 weeks',
        "weeks": dueDate.add(const Duration(days: -29 * 7 + 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
      
    ];
    milestones2 = [
{
        "week_name": '13 weeks',
        "weeks": dueDate.add(const Duration(days: -28 * 7 + 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '14 weeks',
        "weeks": dueDate.add(const Duration(days: -27 * 7 + 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '15 weeks',
        "weeks": dueDate.add(const Duration(days: -26 * 7 + 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '16 weeks',
        "weeks": dueDate.add(const Duration(days: -25 * 7 + 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '17 weeks',
        "weeks": dueDate.add(const Duration(days: -24 * 7 + 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '18 weeks',
        "weeks": dueDate.add(const Duration(days: -23 * 7 + 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },
      {
        "week_name": '19 weeks',
        "weeks": dueDate.add(const Duration(days: -22 * 7 + 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },
      {
        "week_name": '20 weeks',
        "weeks": dueDate.add(const Duration(days: -21 * 7 + 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },
      {
        "week_name": '21 weeks',
        "weeks": dueDate.add(const Duration(days: -20 * 7 + 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },
      {
        "week_name": '22 weeks',
        "weeks": dueDate.add(const Duration(days: -19 * 7 + 1)),
        "line1": "",
        "line2": "",
        "line3": ""
      },
      {
        "week_name": '23 weeks',
        "weeks": dueDate.add(const Duration(days: -18 * 7 + 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      }, {
        "week_name": '24 weeks',
        "weeks": dueDate.add(const Duration(days: -17 * 7 + 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      }, {
        "week_name": '25 weeks',
        "weeks": dueDate.add(const Duration(days: -16 * 7 + 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      }, {
        "week_name": '26 weeks',
        "weeks": dueDate.add(const Duration(days: -15 * 7 + 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '27 weeks',
        "weeks": dueDate.add(const Duration(days: -14 * 7 + 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },
    ];
    milestones3 = [
      {
        "week_name": '28 weeks',
        "weeks": dueDate.add(const Duration(days: -13 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },
      {
        "week_name": '29 weeks',
        "weeks": dueDate.add(const Duration(days: -12 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '30 weeks',
        "weeks": dueDate.add(const Duration(days: -11 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '31 weeks',
        "weeks": dueDate.add(const Duration(days: -10 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '32 weeks',
        "weeks": dueDate.add(const Duration(days: -9 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '33 weeks',
        "weeks": dueDate.add(const Duration(days: -8 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '34 weeks',
        "weeks": dueDate.add(const Duration(days: -7 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '35 weeks',
        "weeks": dueDate.add(const Duration(days: -6 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '36 weeks',
        "weeks": dueDate.add(const Duration(days: -5 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '37 weeks',
        "weeks": dueDate.add(const Duration(days: -4 * 7 + 1)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '38 weeks',
        "weeks": dueDate.add(const Duration(days: -3 * 7 + 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '39 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 7 + 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '40 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 7 + 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '41 weeks',
        "weeks": dueDate.add(const Duration(days: 0 + 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '42 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 7 + 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },
    ];
  }

  void dueDateFunction(DateTime dueDate){
    milestones = [
      {
        "week_name": '1 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 280 + 1)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '2 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 275 - 2)),
       "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '3 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 272 - 1)),
        "line1": "Baby",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '4 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 269)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },{
        "week_name": '5 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 265 - 1 )),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '6 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 262)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '7 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 258 - 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '8 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 255)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '9 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 251 - 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '10 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 248)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '11 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 244 - 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '12 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 241)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  


    ];
    milestones2 = [
      {
        "week_name": '13 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 237 - 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
        {
        "week_name": '14 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 234)),
         "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '15 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 230 - 1)),
         "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '16 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 227)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '17 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 223 - 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '18 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 220)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '19 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 216 - 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '20 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 213)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '21 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 209 - 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '22 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 206)),
        "line1": "",
        "line2": "",
        "line3": ""
      },{
        "week_name": '23 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 202 - 1)),
       "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '24 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 199)),
       "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '25 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 195 - 1)),
      "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '26 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 192)),
      "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '27 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 188 - 1)),
      "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },
    ];
    milestones3 = [
      {
        "week_name": '28 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 185)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },
      {
        "week_name": '29 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 181 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '30 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 178)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '31 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 174 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '32 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 171)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '33 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 167 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '34 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 164)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '35 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 160 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '36 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 157)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '37 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 153 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '38 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 150)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '39 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 146 - 1)),
       "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '40 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 143)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '41 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 139 - 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '42 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 136)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },
    ];
  
  }

void ultrasoundFun(DateTime dueDate){
  milestones = [
      {
        "week_name": '1 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 132 - 1)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '2 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 129 )),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '3 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 125 - 1)),
       "line1": "Baby",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '4 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 122)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },{
        "week_name": '5 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 118 - 1)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '6 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 115)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '7 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 111 - 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '8 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 108)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '9 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 104 - 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '10 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 101)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '11 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 97 - 1)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '12 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 94)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },


    ];
    milestones2 = [
        {
        "week_name": '13 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 90 - 1)),
       "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
  {
        "week_name": '14 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 87)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '15 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 83 - 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '16 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 80)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '17 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 76 - 1)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '18 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 73)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '19 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 69 - 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '20 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 66)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '21 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 62 - 1)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '22 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 59)),
        "line1": "Your baby is",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '23 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 55 - 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '24 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 52)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '25 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 48 - 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '26 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 45)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '27 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 41 - 1)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },
    ];
    milestones3 = [
      {
        "week_name": '28 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 38)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },
      {
        "week_name": '29 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 34 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '30 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 31)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '31 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 27 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '32 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 24)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '33 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 20 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '34 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 17)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '35 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 13 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '36 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 10)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '37 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 6 - 1)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '38 weeks',
        "weeks": dueDate.add(const Duration(days: -2 * 3)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '39 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '40 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 8)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '41 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 15)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '42 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 22)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },
    ];
  
}


void conceptionDate(DateTime dueDate){
  milestones = [
      {
        "week_name": '1 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 279)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '2 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 272)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '3 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 265)),
        "line1": "Baby",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '4 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 258)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },{
        "week_name": '5 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 251)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '6 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 244)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '7 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 237)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '8 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 230)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '9 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 223)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '10 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 216)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '11 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 209)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '12 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 202)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
 

    ];
    milestones2 = [
       {
        "week_name": '13 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 195)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
  {
        "week_name": '14 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 188)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '15 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 181)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '16 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 174)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '17 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 167)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '18 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 160)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '19 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 153)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '20 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 146)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '21 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 139)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '22 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 132)),
        "line1": "Your baby is",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '23 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 125)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '24 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 118)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '25 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 111)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '26 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 104)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '27 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 97)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },
    ];
    milestones3 = [
      {
        "week_name": '28 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 90)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },
      {
        "week_name": '29 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 83)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '30 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 76)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '31 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 69)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '32 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 62)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '33 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 55)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '34 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 48)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '35 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 41)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '36 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 34)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '37 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 27)),
       "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '38 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 20)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '39 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 13)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '40 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 6)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '41 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 1)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '42 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 8)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },
    ];
  
}

void ivfFunctionSelectOne(DateTime dueDate){
  milestones = [
      {
        "week_name": '1 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 282)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '2 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 275)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '3 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 268)),
        "line1": "Baby",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '4 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 261)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },{
        "week_name": '5 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 254)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '6 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 247)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '7 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 240)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '8 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 233)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '9 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 226)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '10 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 219)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '11 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 212)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '12 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 205)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  

    ];
    milestones2 = [
      {
        "week_name": '13 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 198)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
  {
        "week_name": '14 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 191)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '15 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 184)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '16 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 177)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '17 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 170)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '18 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 163)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '19 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 156)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '20 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 149)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '21 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 142)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '22 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 135)),
        "line1": "",
        "line2": "",
        "line3": ""
      },{
        "week_name": '23 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 128)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '24 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 121)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '25 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 114)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '26 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 107)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '27 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 100)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },
    ];
    milestones3 = [
      {
        "week_name": '28 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 93)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },
      {
        "week_name": '29 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 86)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '30 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 79)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '31 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 72)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '32 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 65)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '33 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 58)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '34 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 51)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '35 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 44)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '36 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 37)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '37 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 30)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '38 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 23)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '39 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 16)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '40 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 9)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '41 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 2)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '42 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 5)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },
    ];
  
}


void ivfFunctionSelectTwo(DateTime dueDate){
  milestones = [
      {
        "week_name": '1 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 284)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '2 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 277)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '3 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 270)),
        "line1": "Baby",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '4 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 263)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },{
        "week_name": '5 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 256)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '6 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 249)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '7 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 242)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '8 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 235)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '9 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 228)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '10 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 221)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '11 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 214)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '12 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 207)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  

    ];
    milestones2 = [
      {
        "week_name": '13 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 200)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
  {
        "week_name": '14 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 193)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '15 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 186)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '16 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 179)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '17 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 172)),
        "line1": "",
        "line2": "",
        "line3": ""
      },{
        "week_name": '18 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 165)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '19 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 158)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '20 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 151)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '21 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 144)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '22 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 137)),
        "line1": "",
        "line2": "",
        "line3": ""
      },{
        "week_name": '23 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 130)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '24 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 123)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '25 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 116)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '26 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 109)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '27 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 102)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },
    ];
    milestones3 = [
      {
        "week_name": '28 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 95)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },
      {
        "week_name": '29 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 88)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '30 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 81)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '31 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 74)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '32 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 67)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '33 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 60)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '34 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 53)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '35 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 46)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '36 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 39)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '37 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 32)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '38 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 25)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '39 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 18)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '40 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 11)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '41 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 4)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '42 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 3)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },
    ];
  
}


void ivfFunctionSelectThree(DateTime dueDate){
  milestones = [
      {
        "week_name": '1 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 285)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },
      {
        "week_name": '2 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 278)),
        "line1": "Have possibility to",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '3 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 271)),
        "line1": "Baby",
        "line2": "conceive",
        "line3": ""
      },{
        "week_name": '4 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 264)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },{
        "week_name": '5 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 257)),
        "line1": "Pregnancy test ",
        "line2": "positive",
        "line3": ""
      },
      {
        "week_name": '6 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 250)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '7 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 243)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '8 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 236)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '9 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 229)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '10 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 222)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '11 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 215)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
  {
        "week_name": '12 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 208)),
        "line1": "Heartbeat Detectable by ",
        "line2": "ultrasound",
        "line3": ""
      },
 

    ];
    milestones2 = [
       {
        "week_name": '13 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 201)),
       "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
  {
        "week_name": '14 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 194)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },
      {
        "week_name": '15 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 187)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '16 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 180)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '17 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 173)),
        "line1": "Miscarriage Risk ",
        "line2": "decreases",
        "line3": ""
      },{
        "week_name": '18 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 166)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '19 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 159)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '20 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 152)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '21 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 145)),
        "line1": "Baby begins making noticeable movements, can hear sound, ",
        "line2": "and gender can be found out",
        "line3": ""
      },{
        "week_name": '22 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 138)),
        "line1": "",
        "line2": "",
        "line3": ""
      },{
        "week_name": '23 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 131)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '24 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 124)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '25 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 117)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '26 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 110)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },{
        "week_name": '27 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 103)),
        "line1": "Premature baby may ",
        "line2": "survive",
        "line3": ""
      },
    ];
    milestones3 = [
      {
        "week_name": '28 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 96)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },
      {
        "week_name": '29 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 89)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '30 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 82)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '31 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 75)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '32 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 68)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '33 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 61)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '34 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 54)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '35 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 47)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '36 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 40)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '37 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 33)),
        "line1": "Baby can ",
        "line2": "breath",
        "line3": ""
      },{
        "week_name": '38 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 26)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '39 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 19)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '40 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 12)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '41 weeks',
        "weeks": dueDate.add(const Duration(days: -1 * 5)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },{
        "week_name": '42 weeks',
        "weeks": dueDate.add(const Duration(days: 1 * 2)),
        "line1": "Full ",
        "line2": "Term",
        "line3": ""
      },
    ];
  
}


}
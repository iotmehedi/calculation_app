import 'package:calculation_app/core/routes/route_name.dart';
import 'package:calculation_app/screens/view/all_calculators/bmi_calculator/result_page.dart';
import 'package:calculation_app/screens/view/all_calculators/body_fat_calculator/body_fat_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/body_fat_calculator/bodyfata_result_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/brm_calculator/brm_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/brm_calculator/brm_result_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/calorie_calculator/calorie_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/calorie_calculator/calorie_resultpage.dart';
import 'package:calculation_app/screens/view/all_calculators/fd_calculator/fd_result_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/fractio_calculator/fraction_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/mortgage_screen/mortgage_result_page.dart';
import 'package:calculation_app/screens/view/all_calculators/normal_calculator/normal_calculator_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/ovaluation_period/ovaluation_period_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/period_calculator/period_calculator_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/pregnancy_calculator/pregnancy_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/pregnancy_calculator/pregnancy_time_trimester.dart';
import 'package:calculation_app/screens/view/all_calculators/pregnency_due_date_calculator/due_date_result_page.dart';
import 'package:calculation_app/screens/view/all_calculators/pregnency_due_date_calculator/pregnancy_due_date_calculator.dart';
import 'package:calculation_app/screens/view/all_calculators/pregnency_due_date_calculator/pregnancy_trimester.dart';
import 'package:calculation_app/screens/view/all_calculators/retirement_calculator/time_calculator_result_page.dart';
import 'package:calculation_app/screens/view/all_calculators/salary_calculator/salary_result_screen.dart';
import 'package:calculation_app/screens/view/home_screen/homepage_screen.dart';
import 'package:calculation_app/screens/view/all_calculators/mortgage_screen/mortgage_screen.dart';
import 'package:calculation_app/screens/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/view/all_calculators/auto_loan_calculator/auto_loan_calculator.dart';
import '../../screens/view/all_calculators/auto_loan_calculator/auto_loan_calculator_result.dart';
import '../../screens/view/all_calculators/bmi_calculator/bmi_calculator.dart';
import '../../screens/view/all_calculators/cd_calculator/cd-calculator_result.dart';
import '../../screens/view/all_calculators/cd_calculator/cd_calculator.dart';
import '../../screens/view/all_calculators/compound_calculator/compound_calculator.dart';
import '../../screens/view/all_calculators/compound_calculator/compound_result_screen.dart';
import '../../screens/view/all_calculators/discount_calculator/discount_calculator.dart';
import '../../screens/view/all_calculators/discount_calculator/discount_result_screen.dart';
import '../../screens/view/all_calculators/emi_calculator/emi_calculator_screen.dart';
import '../../screens/view/all_calculators/emi_calculator/emi_result_screen.dart';
import '../../screens/view/all_calculators/fd_calculator/fd_calculator.dart';
import '../../screens/view/all_calculators/gpa_calculator/gpa_calculator.dart';
import '../../screens/view/all_calculators/gpa_calculator/gpa_calculator_result_screen.dart';
import '../../screens/view/all_calculators/grade_calculator/grade_calculator.dart';
import '../../screens/view/all_calculators/grade_calculator/grade_result_screen.dart';
import '../../screens/view/all_calculators/gst_calculator/gst_calculator_result.dart';
import '../../screens/view/all_calculators/gst_calculator/gst_calculator_screen.dart';
import '../../screens/view/all_calculators/loan_calculator/loan_calculator_result.dart';
import '../../screens/view/all_calculators/loan_calculator/loan_calculator_screen.dart';
import '../../screens/view/all_calculators/margin_calculator/margin_calculator_result_screen.dart';
import '../../screens/view/all_calculators/margin_calculator/margin_calculator_screen.dart';
import '../../screens/view/all_calculators/percentage_calculator/percentage_calculator.dart';
import '../../screens/view/all_calculators/ppf-calculator/ppf_calculator-screen.dart';
import '../../screens/view/all_calculators/ppf-calculator/ppf_result.dart';
import '../../screens/view/all_calculators/pregnancy_calculator/pregnancy_result_page.dart';
import '../../screens/view/all_calculators/retirement_calculator/time_calculator.dart';
import '../../screens/view/all_calculators/salary_calculator/salary_calculator_screen.dart';
import '../../screens/view/all_calculators/sales_calculator/sales_calculator_screen.dart';
import '../../screens/view/all_calculators/sales_calculator/sales_result.dart';
import '../../screens/view/all_calculators/sip_calculator/sip_calculator.dart';
import '../../screens/view/all_calculators/sip_calculator/sip_result_screen.dart';
import '../../screens/view/all_calculators/stocks_calculator/stocks_calculator_result.dart';
import '../../screens/view/all_calculators/stocks_calculator/stocks_calculator_screen.dart';
import '../../screens/view/all_calculators/tip_calculator/tip_calculator_result_screen.dart';
import '../../screens/view/all_calculators/tip_calculator/tip_calculator_screen.dart';
import '../../screens/view/all_calculators/vat_calculator/vat_calculator_screen.dart';
import '../../screens/view/all_calculators/vat_calculator/vat_result_screen.dart';
import '../../screens/view/more_calculator/more_calculator.dart';
import '../../screens/view/scientific_calculator/scientific_calculator.dart';

class RouteGenerator {
  Future<dynamic> pushNamedSms(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }

  static pushNamed(BuildContext context, String pageName) {
    return Navigator.of(context).pushNamed(pageName);
  }

  static pushReplacementNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushReplacementNamed(context, pageName,
        arguments: arguments);
  }

  static pushNamedAndRemoveAll(String pageName, {List arguments = const []}) {
    Get.offAllNamed(pageName, arguments: arguments);
  }
  // static pushNamedAndRemoveAll(BuildContext context, String pageName,
  //     {List arguments = const []}) {
  //   return Navigator.pushNamedAndRemoveUntil(
  //       context, pageName, (route) => false,
  //       arguments: arguments);
  // }

  static pop(BuildContext context) {
    return Navigator.of(context).pop();
  }

  static popAndPushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.popAndPushNamed(context, pageName, arguments: arguments);
  }

  static popAll(BuildContext context) {
    return Navigator.of(context).popUntil((route) => false);
  }

  static popUntil(BuildContext context, String pageName) {
    return Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  // ================================== Routing =============================================

  static Route<dynamic>? onRouteGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.homepage:
        return MaterialPageRoute(
          builder: (context) => const HomepageScreen(),
        );
      case Routes.mortgagePage:
        return MaterialPageRoute(
          builder: (context) => const MortgageScreen(),
        );
      case Routes.normalCalculatorScreen:
        return MaterialPageRoute(
          builder: (context) => NormalCalculatorScreen(),
        );
      case Routes.fractionCalculator:
        return MaterialPageRoute(
          builder: (context) => FractionCalculatorApp(),
        );
      case Routes.percentageCalculator:
        return MaterialPageRoute(
          builder: (context) => PercentageCalculator(),
        );
      case Routes.bMICalculator:
        return MaterialPageRoute(
          builder: (context) => BMICalculatorScreen(),
        );
      case Routes.resultScreen:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => ResultScrren(
              bmiresult: arguments[0] as double,
              progressValue: arguments[1] as double,
              bmiValueName: arguments[2] as String,
              type: arguments[3] as bool,
            ),
          );
        }
      case Routes.bRMResultScreen:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => BRMResultScreen(
              bmiresult: arguments[0] as double,
            ),
          );
        }
      case Routes.bMRCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => BmrCalculator(),
          );
        }
      case Routes.calorieCalculatorApp:
        {
          return MaterialPageRoute(
            builder: (context) => CalorieCalculatorScreen(),
          );
        }
      case Routes.calorieResultScreen:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => CalorieResultScrren(
              maintainWeight: arguments[0] as int,
              mildWeightLoss: arguments[1] as int,
              weightLoss: arguments[2] as int,
              extremeWeightLoss: arguments[3] as int,
              unitOrMatrics: arguments[4] as bool
            ),
          );
        }
      case Routes.bodyFatCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => BodyFatCalculator(),
          );
        }
      case Routes.bodyfatResultScreen:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => BodyfatResultScreen(
              maintainWeight: arguments[0] as String,
              type: arguments[1] as bool,
              weight: arguments[2] as String,
            ),
          );
        }
      case Routes.ovulationPeriod:
        {
          return MaterialPageRoute(
            builder: (context) => OvulationInputPage(),
          );
        }
      case Routes.periodCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => PeriodInputPage(),
          );
        }
      case Routes.pregnancyDueDate:
        {
          return MaterialPageRoute(
            builder: (context) => PregnancyCalculatorPage(),
          );
        }
      case Routes.pregnancyTimeCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => PregnancyTimeCalculatorPage(),
          );
        }
      case Routes.pregnancyDueDateResult:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => DueDateResultCalculator(
              lastMonthName: arguments[0] as DateTime,
              firstTrimesterDayDifference: arguments[1] as int,
              secondTrimesterDayDifference: arguments[2] as int,
              thirdTrimesterDayDifference: arguments[3] as int,
              mostRecentPastDate: arguments[4] as String,
              associatedWeekName:
                  arguments[5] == null ? "" : arguments[5] as String,
              milestones: arguments[6] as List<Map<String, Object>>,
              selectedMethod: arguments[7] as String,
              selectedOption: arguments[8] as String,
              firstTrimesterEnd: arguments[9] as DateTime,
              thirdTrimesterStart: arguments[10] as DateTime,
              milestones2: arguments[11] as List<Map<String, Object>>,
              milestones3: arguments[12] as List<Map<String, Object>>,
            ),
          );
        }
      case Routes.pregnancyTrimester:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => PregnancyTrimester(
              milestones: arguments[0] as List<Map<String, Object>>,
              selectedMethod: arguments[1] as String,
              selectedOption: arguments[2] as String,
              firstTrimesterEnd: arguments[3] as DateTime,
              thirdTrimesterStart: arguments[4] as DateTime,
              milestones2: arguments[5] as List<Map<String, Object>>,
              milestones3: arguments[6] as List<Map<String, Object>>,
            ),
          );
        }
      case Routes.pregnancyResultCalculator:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => PregnancyResultCalculator(
              weeksDifference: arguments[0] as int,
              daysDifference: arguments[1] as int,
              month: arguments[2] as int,
              remainingDays: arguments[3] as int,
              currentTrimester: arguments[4] as String,
              conceviedDate: arguments[5] as String,
              dueDate: arguments[6] as String,
              milestones: arguments[7] as List<Map<String, Object>>,
              milestones2: arguments[8] as List<Map<String, Object>>,
              milestones3: arguments[9] as List<Map<String, Object>>,
            ),
          );
        }
      case Routes.pregnancyTimeTrimester:
        {
          final arguments = routeSettings.arguments as List;
          return MaterialPageRoute(
            builder: (context) => PregnancyTimeTrimester(
              milestones: arguments[0] as List<Map<String, Object>>,
              milestones2: arguments[1] as List<Map<String, Object>>,
              milestones3: arguments[2] as List<Map<String, Object>>,
            ),
          );
        }
      case Routes.mortgageResultPage:
        {
          return MaterialPageRoute(
            builder: (context) => MortgageResultPage(),
          );
        }
      case Routes.autoLoanCalculatorScreen:
        {
          return MaterialPageRoute(
            builder: (context) => AutoLoanCalculatorScreen(),
          );
        }
      case Routes.autoLoanCalculatorResult:
        {
          return MaterialPageRoute(
            builder: (context) => AutoLoanCalculatorResult(),
          );
        }
      case Routes.stockCalculatorPage:
        {
          return MaterialPageRoute(
            builder: (context) => StockCalculatorPage(),
          );
        }
      case Routes.stocksCalculatorResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => StocksCalculatorResultScreen(),
          );
        }
      case Routes.loanCalculatorScreen:
        {
          return MaterialPageRoute(
            builder: (context) => LoanCalculatorScreen(),
          );
        }
      case Routes.loanCalculatorResult:
        {
          return MaterialPageRoute(
            builder: (context) => LoanCalculatorResult(),
          );
        }
      case Routes.sIPCalculatorPage:
        {
          return MaterialPageRoute(
            builder: (context) => SIPCalculatorPage(),
          );
        }
      case Routes.sIPResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => SIPResultScreen(),
          );
        }
      case Routes.tipCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => TipCalculator(),
          );
        }
      case Routes.emiCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => EmiCalculator(),
          );
        }
      case Routes.eMIResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => EMIResultScreen(),
          );
        }
      case Routes.tipCalculatorResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => TipCalculatorResultScreen(),
          );
        }
      case Routes.vATCalculatorHomePage:
        {
          return MaterialPageRoute(
            builder: (context) => VATCalculatorHomePage(),
          );
        }
      case Routes.vatResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => VatResultScreen(),
          );
        }
        case Routes.discountCalculatorPage:
        {
          return MaterialPageRoute(
            builder: (context) => DiscountCalculatorPage(),
          );
        }
        case Routes.discountResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => DiscountResultScreen(),
          );
        }
        case Routes.moreCalculatorPage:
        {
          return MaterialPageRoute(
            builder: (context) => MoreCalculatorPage(),
          );
        }
        case Routes.marginCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => MarginCalculatorScreen(),
          );
        }
        case Routes.marginCalculatorResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => MarginCalculatorResultScreen(),
          );
        }
        case Routes.salaryCalculatorScreen:
        {
          return MaterialPageRoute(
            builder: (context) => SalaryCalculatorScreen(),
          );
        }
        case Routes.salaryCalculatorResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => SalaryResultCalculator(),
          );
        }
        case Routes.cdCalculatorForm:
        {
          return MaterialPageRoute(
            builder: (context) => CDCalculatorForm(),
          );
        }
        case Routes.cdResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => CDResultScreen(),
          );
        }
        case Routes.fdCalculatorHome:
        {
          return MaterialPageRoute(
            builder: (context) => FDCalculatorHome(),
          );
        }
        case Routes.fdResult:
        {
          return MaterialPageRoute(
            builder: (context) => FDResultScreen(),
          );
        }
        case Routes.taxCalculatorPage:
        {
          return MaterialPageRoute(
            builder: (context) => TaxCalculatorPage(),
          );
        }
        case Routes.salesCalculatorResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => SalesCalculatorResultScreen(),
          );
        }
        case Routes.ppfCalculatorPage:
        {
          return MaterialPageRoute(
            builder: (context) => PPFCalculatorScreen(),
          );
        }
        case Routes.ppfCalculatorResult:
        {
          return MaterialPageRoute(
            builder: (context) => PPFCalculatorResult(),
          );
        }
        case Routes.gstCalculatorScreen:
        {
          return MaterialPageRoute(
            builder: (context) => GSTCalculatorPage(),
          );
        }
        case Routes.gstResult:
        {
          return MaterialPageRoute(
            builder: (context) => GSTCalculatorResultScreen(),
          );
        }
        case Routes.courseForm:
        {
          return MaterialPageRoute(
            builder: (context) => CourseForm(),
          );
        }
        case Routes.gpaCalculatorResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => GPACalculatorResultScreen(),
          );
        }
        case Routes.gPAForm:
        {
          return MaterialPageRoute(
            builder: (context) => GPAForm(),
          );
        }
        case Routes.gradeResultScreen:
        {
          return MaterialPageRoute(
            builder: (context) => GradeResultScreen(),
          );
        }
        case Routes.compoundScreen:
        {
          return MaterialPageRoute(
            builder: (context) => CalculatorForm(),
          );
        }
        case Routes.compoundScreenResult:
        {
          return MaterialPageRoute(
            builder: (context) => CompoundResultScreen(),
          );
        }
        case Routes.timeCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => TimeCalculatorScreen(),
          );
        }
        case Routes.timeCalculatorResultPage:
        {
          return MaterialPageRoute(
            builder: (context) => TimeCalculatorResultPage(),
          );
        }
        case Routes.scientificCalculator:
        {
          return MaterialPageRoute(
            builder: (context) => MyCalculator(),
          );
        }
    }
    return null;
  }
}


//      adjHourlyRate = 84961 / adjustedWorkingHours;
//       adjDailyRate = adjHourlyRate * (hoursPerWeek / daysPerWeek);
//       adjWeeklyRate = adjHourlyRate * hoursPerWeek;
//       adjBiWeeklyRate = adjWeeklyRate * 2;
//       adjSemiMonthlyRate = adjAnnualRate / 24;
//       adjMonthlyRate = adjAnnualRate / 12;
//       adjQuarterlyRate = adjAnnualRate / 4;
//       adjAnnualRate = 94000;
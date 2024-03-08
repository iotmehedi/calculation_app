import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:calculation_app/screens/widgets/textfield/textField_widget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MortgageScreen extends StatefulWidget {
  const MortgageScreen({super.key});

  @override
  State<MortgageScreen> createState() => _MortgageScreenState();
}

class _MortgageScreenState extends State<MortgageScreen> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: CustomText(
            text: "Mortgage Calculator",
            fontWeight: FontWeight.w800,
            textColor: Colors.black,
            fontSize: 20.0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomTextField(hint: "enter Home", obscureText: false, prefixIcon: Icon(Icons.attach_money_sharp),),

              CustomText(
                  text: "Home",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F3F6F9"),
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomSimpleTextField(
                          prefixIcon: Icon(
                            Icons.attach_money_sharp,
                            size: 16,
                          ),
                          prefixIconColor: AppColors.greyForPrefixIcon,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: SizedBox())
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                  text: "Down Payment",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#F3F6F9"),
                          borderRadius: BorderRadius.circular(12)),
                      child: CustomSimpleTextField(
                        prefixIcon: Icon(
                          Icons.attach_money_sharp,
                          size: 16,
                        ),
                        prefixIconColor: AppColors.greyForPrefixIcon,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor("#F3F6F9"),
                          borderRadius: BorderRadius.circular(12)),
                      child: CustomSimpleTextField(
                        prefixIcon: Icon(
                          Icons.percent_outlined,
                          size: 16,
                        ),
                        prefixIconColor: AppColors.greyForPrefixIcon,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              CustomText(
                  text: "Interested Rate",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F3F6F9"),
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomSimpleTextField(
                          prefixIcon: Icon(
                            Icons.percent_outlined,
                            size: 16,
                          ),
                          prefixIconColor: AppColors.greyForPrefixIcon,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: SizedBox())
                ],
              ),

              SizedBox(
                height: 20,
              ),
              CustomText(
                  text: "Long Term Year",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F3F6F9"),
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomSimpleTextField(
                            // prefixIcon: Icon(Icons.attach_money_sharp , size: 16,),
                            // prefixIconColor: AppColors.greyForPrefixIcon,
                            )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: SizedBox()),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() => isChecked = !isChecked);
                      // widget.onChanged?.call(isChecked);
                    },
                    child: Container(
                      width: 23,
                      height: 24,
                      decoration: BoxDecoration(
                        color: HexColor("#0F182E"),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: isChecked
                          ? Icon(
                              Icons.check,
                              size: 17,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                      text: "Include Fee And Texes",
                      fontWeight: FontWeight.bold,
                      textColor: Colors.black,
                      fontSize: 18.0),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                  text: "Property Tax",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F3F6F9"),
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomSimpleTextField(
                          prefixIconColor: AppColors.greyForPrefixIcon,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: SizedBox())
                ],
              ),

              SizedBox(
                height: 10,
              ),
              CustomText(
                  text: "Home Insurance",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F3F6F9"),
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomSimpleTextField(
                          prefixIconColor: AppColors.greyForPrefixIcon,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: SizedBox())
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  text: "PMI Fee",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F3F6F9"),
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomSimpleTextField(
                          prefixIconColor: AppColors.greyForPrefixIcon,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: SizedBox())
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  text: "Hoa fee",
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 18.0),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F3F6F9"),
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomSimpleTextField(
                          prefixIconColor: AppColors.greyForPrefixIcon,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: SizedBox())
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

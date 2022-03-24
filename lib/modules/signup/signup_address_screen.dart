import 'package:flutter/material.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/common_widgets/search_alert_view.dart';
import 'package:user_gym_app/controllers/authentication_controller.dart';
import 'package:user_gym_app/controllers/general_controller.dart';
import 'package:user_gym_app/utility/asset_utility.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/common_methods.dart';
import 'package:user_gym_app/utility/constants.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';

class SignUpAddressScreen extends StatefulWidget {
  final num id;
  const SignUpAddressScreen({Key? key, required this.id}) : super(key: key);

  @override
  _SignUpAddressScreenState createState() => _SignUpAddressScreenState();
}

class _SignUpAddressScreenState extends State<SignUpAddressScreen> {

  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Map<String, dynamic>? selectedCountry;
  Map<String, dynamic>? selectedState;
  Map<String, dynamic>? selectedCity;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AuthenticationController.to.getAllCountryListing();
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          child: SingleChildScrollView(child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonVerticalSpacing10(height: 20),
                Image(image: appLogo,height: getScreenHeight(context)/6),
                commonVerticalSpacing10(height: 40),
                commonHeaderTitle(title: login,
                    fontWeight: 2,
                    fontSize: 1.4,ourFontColor: primaryColor),
                commonVerticalSpacing10(),
                Stack(
                  children: [
                    CommonTextFiled(
                      fieldTitleText: "Country",
                      hintText: "Country",
                      textEditingController: countryController,
                      isBorderEnable: false,
                      isEnabled: true,
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },
                    ),
                    InkWell(
                      onTap: (){
                        // ignore: void_checks
                        return commonDialogStructure(context,child: SearchFilterView(
                            selectionCallback: (val){
                              setState(() {
                                selectedCountry = val;
                                countryController.text = selectedCountry!["name"];
                              });
                            },
                            listOfLocation: AuthenticationController.to.allCountries
                        ));
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 55,
                      ),
                    ),
                  ],
                ),
                // CommonTextFiled(
                //   fieldTitleText: "Country",
                //   hintText: "Country",
                //   isBorderEnable: false,
                //   isChangeFillColor: true,
                //   textEditingController: countryController,
                //   onChangedFunction: (String value){
                //
                //   },
                //   validationFunction: (String value) {
                //     return value.toString().isEmpty
                //         ? notEmptyFieldMessage
                //         : null;
                //   },
                // ),
                Stack(
                  children: [
                    CommonTextFiled(
                      fieldTitleText: "State",
                      hintText: "State",
                      textEditingController: stateController,
                      isBorderEnable: false,
                      isEnabled: true,
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },
                    ),
                    InkWell(
                      onTap: (){
                        if(selectedCountry != null) {
                          // ignore: void_checks
                          return commonDialogStructure(context,
                              child: SearchFilterView(
                                  selectionCallback: (val) {
                                    setState(() {
                                      selectedState = val;
                                      stateController.text = selectedState!["name"];
                                    });
                                  },
                                  listOfLocation: getStateCountryWise(
                                      selectedCountry!)
                              ));
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 55,
                      ),
                    ),
                  ],
                ),
                // CommonTextFiled(
                //   fieldTitleText: "State",
                //   hintText: "State",
                //   isBorderEnable: false,
                //   isChangeFillColor: true,
                //   textEditingController: stateController,
                //   onChangedFunction: (String value){
                //
                //   },
                //   validationFunction: (String value) {
                //     return value.toString().isEmpty
                //         ? notEmptyFieldMessage
                //         : null;
                //   },
                // ),
                Stack(
                  children: [
                    CommonTextFiled(
                      fieldTitleText: "City",
                      hintText: "City",
                      textEditingController: cityController,
                      isBorderEnable: false,
                      isEnabled: true,
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },
                    ),
                    InkWell(
                      onTap: (){
                        if(selectedState != null) {
                          // ignore: void_checks
                          return commonDialogStructure(context,
                              child: SearchFilterView(
                                  selectionCallback: (val) {
                                    setState(() {
                                      selectedCity = val;
                                      cityController.text = selectedCity!["name"];
                                    });
                                  },
                                  listOfLocation: getCityStateWise(selectedState!)
                              ));
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 55,
                      ),
                    ),
                  ],
                ),
                // CommonTextFiled(
                //   fieldTitleText: "City",
                //   hintText: "City",
                //   isBorderEnable: false,
                //   isChangeFillColor: true,
                //   textEditingController: cityController,
                //   onChangedFunction: (String value){
                //
                //   },
                //   validationFunction: (String value) {
                //     return value.toString().isEmpty
                //         ? notEmptyFieldMessage
                //         : null;
                //   },
                // ),
                CommonTextFiled(
                  fieldTitleText: "Address",
                  hintText: "Address",
                  isBorderEnable: false,
                  isChangeFillColor: true,
                  textEditingController: addressController,
                  onChangedFunction: (String value){

                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  },
                ),

                commonFillButtonView(
                    context: context,
                    title: submit,
                    isLoading: false,
                    tapOnButton: (){
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Map<String, dynamic> params = {
                          "country_id": selectedCountry!["id"],
                          "city_id": selectedCity!["id"],
                          "state_id": selectedState!["id"],
                          "address": addressController.text,
                        };
                        GeneralController.to.isLoading.value = true;
                        AuthenticationController.to.signupUserOtherDetail(params,widget.id);
                      }else{
                        showSnackBar(title: "Something went wrong", message: "Please recheck your details");
                      }
                    }),
                commonVerticalSpacing10(),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

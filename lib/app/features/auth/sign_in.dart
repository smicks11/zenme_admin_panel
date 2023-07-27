// ignore_for_file: prefer_const_constructors

import 'package:daily_task/app/shared_components/responsive_builder.dart';
import 'package:daily_task/app/utils/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_textstyle.dart';
import '../../utils/big_primary_button.dart';
import '../dashboard/views/screens/dashboard_screen.dart';

class SignIn extends GetView<DashboardController> {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(mobileBuilder: (context, constraints) {
        return SingleChildScrollView(
          child: _authForm(context),
        );
      }, tabletBuilder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flexible(
            //     flex: constraints.maxWidth > 800 ? 8 : 7,
            //     child: Image.network(
            //       'https://static.wixstatic.com/media/720907_4e588a93a1234b89b5ed3ae1d69395ce~mv2.jpg/v1/crop/x_0,y_22,w_1242,h_1231/fill/w_343,h_340,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/head%20shot%202_JPG.jpg',
            //       height: 200,
            //       width: 200,
            //     )),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   child: const VerticalDivider(),
            // ),
            Flexible(flex: 6, child: _authForm(context)),
          ],
        );
      }, desktopBuilder: (context, constraints) {
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Flexible(
          //   flex: constraints.maxWidth > 1350 ? 3 : 4,
          //   child: SingleChildScrollView(
          //       controller: ScrollController(),
          //       child: Image.network(
          //         'https://static.wixstatic.com/media/720907_4e588a93a1234b89b5ed3ae1d69395ce~mv2.jpg/v1/crop/x_0,y_22,w_1242,h_1231/fill/w_343,h_340,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/head%20shot%202_JPG.jpg',
          //         height: 200,
          //         width: 200,
          //       )),
          // ),
          Flexible(
            flex: constraints.maxWidth > 1350 ? 10 : 9,
            child: SingleChildScrollView(
                controller: ScrollController(), child: _authForm(context)),
          )
        ]);
      }),
    );
  }
  
  

  Form _authForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: controller.authKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2),
        child: StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPad),
                  child: Text("Admin Sign In",
                      style: heading1(context).copyWith(
                        color: kPrimaryColor,
                        fontSize: 30,
                      )),
                ),
                kMediumVerticalSpacing,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: bodySmallText(context),
                        controller: controller.email,
                        validator: (value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern.toString());
                          if (!regex.hasMatch(value!)) {
                            return 'Invalid email address';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Your email",
                          hintStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              fontSize: 12
                              // fontFamily: "Booing",
                              ),
                          errorStyle: TextStyle(
                            fontSize: 10,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kPad - 10),
                              borderSide: BorderSide(color: kTextFieldFillColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kPad - 10),
                              borderSide: BorderSide(color: kTextFieldFillColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kPad - 10),
                              borderSide: BorderSide(color: kPrimaryColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kPad - 10),
                              borderSide: BorderSide(color: kTextFieldFillColor)),
                        ),
                      ),
                      kLargeVerticalSpacing,
                      Obx(() {
                        return TextFormField(
                          controller: controller.password,
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'Password cannot be less than 8 characters';
                            } else {
                              return null;
                            }
                          },
                          obscureText: controller.obserText.value,
                          decoration: InputDecoration(
                            suffix: GestureDetector(
                              onTap: () {
                                controller.togglePasswordIcon();
                              },
                              child: Text(
                                controller.obserText.value == true
                                    ? "Show"
                                    : "Hide",
                              ),
                            ),
                            hintText: "Enter password",
                            hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                                fontSize: 12
                                // fontFamily: "Booing",
                                ),
                            errorStyle: TextStyle(
                              fontSize: 10,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(kPad - 10),
                                borderSide: BorderSide(color: kTextFieldFillColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(kPad - 10),
                                borderSide: BorderSide(color: kTextFieldFillColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(kPad - 10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(kPad - 10),
                                borderSide: BorderSide(color: kTextFieldFillColor)),
                          ),
                        );
                      }),
                      kLargeVerticalSpacing,
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                // Spacer(),
                Center(child: Obx(() {
                  return PrimaryButton(
                    color: controller.authLoad.value == true
                        ? kPrimaryColor.withOpacity(0.4)
                        : kPrimaryColor,
                    text: controller.authLoad.value == true
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(kWhiteColor),
                                strokeWidth: 1,
                              ),
                            ),
                          )
                        : Text(
                            "Sign in",
                            style: labelText(context)
                                .copyWith(color: kWhiteColor, fontSize: 14),
                          ),
                    textColor: kWhiteColor,
                    press: () async {
                      if (controller.authKey.currentState!.validate()) {
                        controller.changeAuthLoad(true, setState);
                        await Future.value(controller.signInWithEmail(
                            controller.email.text,
                            controller.password.text,
                            context));
                        controller.changeAuthLoad(false, setState);
                      }
                    },
                    width: MediaQuery.of(context).size.width * 1.0,
                  );
                }))
              ],
            );
          }
        ),
      ),
    );
  }
}

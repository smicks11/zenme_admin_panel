import 'package:daily_task/app/utils/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../../utils/big_primary_button.dart';
import '../../../../utils/textfield.dart';
import '../screens/dashboard_screen.dart';

class EditContent extends StatelessWidget {
  final String category;
  final String collectedDesc;
  final String collectedTitle;
  final DashboardController controller;
  const EditContent(
      {Key? key,
      required this.category,
      required this.collectedDesc,
      required this.collectedTitle,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Edit Content',
          style: heading1(context),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kLargeVerticalSpacing,
          Form(
              key: controller.editformKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextBox(
                    textInputAction: TextInputAction.next,
                    keyType: TextInputType.text,
                    controller: controller.categoryName,
                    hintText: "Category name",
                    func: () {},
                    minLines: null,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'This field is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kLargeVerticalSpacing,
                  CustomTextBox(
                    textInputAction: TextInputAction.done,
                    keyType: TextInputType.text,
                    controller: controller.categoryDesc,
                    hintText: "Category Description",
                    func: () {},
                    minLines: 6,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'This field is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              )),
          kLargeVerticalSpacing,
          kLargeVerticalSpacing,
          Obx(() {
            return Center(
              child: PrimaryButton(
                color: controller.editLoadingState.value == true
                    ? kPrimaryColor.withOpacity(0.4)
                    : kPrimaryColor,
                text: controller.editLoadingState.value == true
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kWhiteColor),
                            strokeWidth: 1,
                          ),
                        ),
                      )
                    : Text(
                        "Update",
                        style: labelText(context)
                            .copyWith(color: kWhiteColor, fontSize: 14),
                      ),
                textColor: kWhiteColor,
                press: category == 'air'
                    ? () async {
                        if (controller.editformKey.currentState!.validate()) {
                          controller.changeEditLoadingState(true);

                          await Future.value(controller.updateAirContent(
                            context: context,
                            collectedDesc: collectedDesc,
                            collectedTitle: collectedTitle,
                            categoryDesc: controller.categoryDesc.text,
                            categoryName: controller.categoryName.text,
                          ));
                          controller.changeEditLoadingState(false);
                        }
                      }
                    : category == 'fire'
                        ? () async {
                            if (controller.editformKey.currentState!
                                .validate()) {
                              controller.changeEditLoadingState(true);

                              await Future.value(controller.updateFireContent(
                                context: context,
                                collectedDesc: collectedDesc,
                                collectedTitle: collectedTitle,
                                categoryDesc: controller.categoryDesc.text,
                                categoryName: controller.categoryName.text,
                              ));
                              controller.changeEditLoadingState(false);
                            }
                          }
                        : category == 'earth'
                            ? () async {
                                if (controller.editformKey.currentState!
                                    .validate()) {
                                  controller.changeEditLoadingState(true);
                                  await Future.value(
                                      controller.updateEarthContent(
                                    context: context,
                                    collectedDesc: collectedDesc,
                                    collectedTitle: collectedTitle,
                                    categoryDesc: controller.categoryDesc.text,
                                    categoryName: controller.categoryName.text,
                                  ));
                                  controller.changeEditLoadingState(false);
                                }
                              }
                            : category == 'water'
                                ? () async {
                                    if (controller.editformKey.currentState!
                                        .validate()) {
                                      controller.changeEditLoadingState(true);
                                      await Future.value(
                                          controller.updateWaterContent(
                                        context: context,
                                        collectedDesc: collectedDesc,
                                        collectedTitle: collectedTitle,
                                        categoryDesc:
                                            controller.categoryDesc.text,
                                        categoryName:
                                            controller.categoryName.text,
                                      ));
                                      controller.changeEditLoadingState(false);
                                    }
                                  }
                                : category == 'crystal'
                                    ? () async {
                                        if (controller.editformKey.currentState!
                                            .validate()) {
                                          controller
                                              .changeEditLoadingState(true);

                                          // await Future.value(controller
                                          //   ..updateCrystalContent(
                                          //     context: context,
                                          //     collectedDesc: collectedDesc,
                                          //     collectedTitle: collectedTitle,
                                          //     categoryDesc:
                                          //         controller.categoryDesc.text,
                                          //     categoryName:
                                          //         controller.categoryName.text,
                                          //   ));
                                          controller
                                              .changeEditLoadingState(false);
                                        }
                                      }
                                    : null,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            );
          }),
        ],
      ),
    );
  }
}

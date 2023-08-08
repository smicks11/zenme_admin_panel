import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../../utils/big_primary_button.dart';
import '../../../../utils/resources.dart';
import '../../../../utils/textfield.dart';
import '../screens/dashboard_screen.dart';

class EditCrystal extends GetView<DashboardController> {
  final String desc;
  final String subTitle;
  final String title;
  final int index;

  const EditCrystal({
    Key? key,
    required this.desc,
    required this.subTitle,
    required this.title,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: kWhiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: bodySmallText(context)
                            .copyWith(color: kPrimaryColor),
                      ),
                      kSmallVerticalSpacing,
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration:
                            BoxDecoration(color: kErrorColor.withOpacity(0.2)),
                        child: Text(
                          'Title: $title',
                          style: bodySmallText(context)
                              .copyWith(color: kErrorColor),
                        ),
                      )
                    ],
                  )),
                ],
              ),
              kMediumVerticalSpacing,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: $title',
                    style: bodyNormalText(context),
                  ),
                  kSmallVerticalSpacing,
                  Text(
                    'Sub Title: $subTitle',
                    style: bodySmallText(context),
                  ),
                  kSmallVerticalSpacing,
                  Text(
                    'Description: $desc',
                    style: bodySmallText(context),
                  ),
                  kMediumVerticalSpacing,
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (
                            context,
                          ) {
                            return AlertDialog(
                              title: Text(
                                'Are you sure you want to update content?',
                                style: bodySmallText(context),
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              actions: <Widget>[
                                //flatbutton changed
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Go back')),
                                TextButton(
                                  child: const Text('UPDATE'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    index == 0
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return editCrystalOne(context);
                                            })
                                        : index == 1
                                            ? showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return editCrystalTwo(
                                                      context);
                                                })
                                            : index == 2
                                                ? showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return editCrystalThree(
                                                          context);
                                                    })
                                                : const SizedBox.shrink();
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return EditContent(
                                    //         controller: controller,
                                    //         category: category,
                                    //         collectedDesc: secondContent,
                                    //         collectedTitle: firstContent,
                                    //       );
                                    //     });
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Text(
                          'EDIT',
                          style: bodyNormalText(context).copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        // kTinyHorizontalSpacing,
                        const Icon(
                          Icons.edit,
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
              kSmallVerticalSpacing,
            ],
          ),
        ),
      ),
    );
  }

  Widget editCrystalOne(BuildContext context) {
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
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      controller: controller.crystalTitle,
                      hintText: "Crystal Title",
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
                      textInputAction: TextInputAction.next,
                      keyType: TextInputType.text,
                      controller: controller.crystalSub,
                      hintText: "Crystal Sub Title",
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
                      textInputAction: TextInputAction.next,
                      keyType: TextInputType.text,
                      controller: controller.crystalDesc,
                      hintText: "Crystal Description",
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
                  ])),
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
                press: () async {
                  if (controller.editformKey.currentState!.validate()) {
                    controller.changeEditLoadingState(true);

                    await Future.value(controller.updateCrystalOfTheMonth(
                        context: context,
                        collectSub: controller.crystalSub.text,
                        collectDesc: controller.crystalDesc.text,
                        collectTitle: controller.crystalTitle.text,
                        indexToUpdate: 0));
                    controller.changeEditLoadingState(false);
                  }
                },
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            );
          }),
        ]));
  }

  Widget editCrystalTwo(BuildContext context) {
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
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      controller: controller.crystalTitle,
                      hintText: "Crystal Title",
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
                      textInputAction: TextInputAction.next,
                      keyType: TextInputType.text,
                      controller: controller.crystalSub,
                      hintText: "Crystal Sub Title",
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
                  ])),
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
                press: () async {
                  if (controller.editformKey.currentState!.validate()) {
                    controller.changeEditLoadingState(true);

                    await Future.value(controller.updateCrystalOfTheMonth(
                        context: context,
                        collectSub: controller.crystalSub.text,
                        collectDesc: "",
                        collectTitle: controller.crystalTitle.text,
                        indexToUpdate: 1));
                    controller.changeEditLoadingState(false);
                  }
                },
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            );
          }),
        ]));
  }

  Widget editCrystalThree(BuildContext context) {
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
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      controller: controller.crystalTitle,
                      hintText: "Crystal Title",
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
                      textInputAction: TextInputAction.next,
                      keyType: TextInputType.text,
                      controller: controller.crystalDesc,
                      hintText: "Crystal Description",
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
                  ])),
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
                press: () async {
                  if (controller.editformKey.currentState!.validate()) {
                    controller.changeEditLoadingState(true);

                    await Future.value(controller.updateCrystalOfTheMonth(
                        context: context,
                        collectSub: "",
                        collectDesc: controller.crystalDesc.text,
                        collectTitle: controller.crystalTitle.text,
                        indexToUpdate: 2));
                    controller.changeEditLoadingState(false);
                  }
                },
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            );
          }),
        ]));
  }
}

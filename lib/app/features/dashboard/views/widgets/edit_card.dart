import 'package:daily_task/app/features/dashboard/views/widgets/edit_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_textstyle.dart';
import '../../../../utils/big_primary_button.dart';
import '../../../../utils/resources.dart';
import '../../../../utils/textfield.dart';
import '../screens/dashboard_screen.dart';

class EditCard extends GetView<DashboardController> {
  // EditCard({
  //   Key? key,
  //   required TextEditingController secondContent,
  //   required TextEditingController firstContent,
  // })  : _secondContent = secondContent,
  //       _firstContent = firstContent,
  //       super(key: key);
  final String category;
  final String secondContent;
  final String firstContent;

  const EditCard(
      {Key? key,
      required this.category,
      required this.secondContent,
      required this.firstContent})
      : super(key: key);

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
                          firstContent,
                          style: bodySmallText(context)
                              .copyWith(color: kErrorColor),
                        ),
                      )
                    ],
                  )),
                  IconButton(
                      onPressed: () {
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
                                      // controller.showEditScreen(true);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return EditContent(
                                              controller: controller,
                                              category: category,
                                              collectedDesc: secondContent,
                                              collectedTitle: firstContent,
                                            );
                                          });
                                      // try {
                                      //   showLoaderDialog(context: context, loadingText: "Updating...");
                                      //   homeController.updateRequestStatus(id).then((value) {
                                      //     Navigator.pop(context);
                                      //     Navigator.pop(context);

                                      //   });

                                      // } catch (err) {}
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: kPrimaryColor,
                        size: 28,
                      ))
                ],
              ),
              kMediumVerticalSpacing,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstContent,
                    style: bodyNormalText(context),
                  ),
                  kSmallVerticalSpacing,
                  Text(
                    secondContent,
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
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return EditContent(
                                            controller: controller,
                                            category: category,
                                            collectedDesc: secondContent,
                                            collectedTitle: firstContent,
                                          );
                                        });
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
                  // TextBox(
                  //   textInputAction: TextInputAction.next,
                  //   keyType: TextInputType.text,
                  //   controller: _secondContent,
                  //   hintText: "Category name",
                  //   func: () {},
                  //   minLines: null,
                  //   validator: (value) {
                  //     if (value!.length < 10) {
                  //       return 'This field is required';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  // kSmallVerticalSpacing,
                  // TextBox(
                  //   textInputAction: TextInputAction.newline,
                  //   keyType: TextInputType.multiline,
                  //   controller: _firstContent,
                  //   hintText: "Description",
                  //   func: () {},
                  //   minLines: null,
                  //   validator: (value) {
                  //     if (value!.length < 10) {
                  //       return 'This field is required';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // )
                ],
              ),
              kSmallVerticalSpacing,
              // const Divider(
              //   color: Colors.black45,
              // ),
              // kSmallVerticalSpacing,
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Update Status',
              //             style: bodySmallText(context)
              //                 .copyWith(color: Colors.black54),
              //           ),
              //           kTinyVerticalSpacing,
              //           Text(
              //             "UPDATED",
              //             style: bodySmallText(context)
              //                 .copyWith(color: kErrorColor),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Last Update Date",
              //             style: bodySmallText(context)
              //                 .copyWith(color: Colors.black54),
              //           ),
              //           kTinyVerticalSpacing,
              //           // Text(
              //           //  DateTime.parse(endDate),
              //           //   style: bodySmallText(context)
              //           //       .copyWith(color: kPrimaryColor),
              //           // ),
              //           Text(
              //             'Update',
              //             style: bodySmallText(context)
              //                 .copyWith(color: kPrimaryColor),
              //           ),
              //         ],
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _editDialog({
  //   // Function()? onPressedMenu,
  //   required BuildContext context,
  //   required String category,
  //   required String collectedDesc,
  //   required String collectedTitle,
  // }) {

  // }
}

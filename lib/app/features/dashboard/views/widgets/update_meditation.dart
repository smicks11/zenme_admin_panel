import 'package:daily_task/app/utils/resources.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../../utils/big_primary_button.dart';
import '../../../../utils/snackbar.dart';
import '../../../../utils/textfield.dart';
import '../screens/dashboard_screen.dart';

class UpdateMeditation extends StatelessWidget {
  final DashboardController controller;
  const UpdateMeditation({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Update Meditation Of The Month',
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
                key: controller.updateMedformKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextBox(
                      textInputAction: TextInputAction.next,
                      keyType: TextInputType.text,
                      controller: controller.updateMedcategoryName,
                      hintText: "Enter Title",
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
                      controller: controller.updateMedcategoryDesc,
                      hintText: "Enter Description",
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
                    kLargeVerticalSpacing,
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png', 'jpeg'],
                            );

                            if (results == null) {
                              cToast(
                                  msg: "No file selected.",
                                  color: kErrorColor,
                                  context: context);
                            }

                            final PlatformFile file = results!.files.first;

                            controller
                                .getSelectedImageFile(file.bytes!, setState);
                            controller
                                .getDummySelectedImageFile(file, setState);
                            // setState(() {
                            //   _selectedImageFiles = results?.files.first;
                            // });
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: kWhiteColor,
                              size: 40,
                            ),
                          ),
                        ),
                        kMediumHorizontalSpacing,
                        Expanded(
                            child: Text(
                          controller.dummyselectedImageFiles?.value != null && controller.dummyselectedImageFiles?.value.name != ""
                              ? controller.dummyselectedImageFiles!.value.name
                              : "Upload image",
                          style: bodySmallText(context),
                        ))
                      ],
                    ),
                    kLargeVerticalSpacing,
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png', 'jpeg'],
                              // allowedExtensions: ['mp3', 'mp4'],
                            );

                            if (results == null) {
                              cToast(
                                  msg: "No file selected.",
                                  color: kErrorColor,
                                  context: context);
                            }

                            final PlatformFile file = results!.files.first;

                            controller
                                .getSelectedAudioFile(file.bytes!, setState);
                            controller
                                .getDummySelectedAudioFile(file, setState);
                            // setState(() {
                            //   _selectedMusicFiles = results?.files.first;
                            // });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: kWhiteColor,
                              size: 40,
                            ),
                          ),
                        ),
                        kMediumHorizontalSpacing,
                        Expanded(
                            child: Text(
                          controller.dummyselectedAudioFiles?.value != null && controller.dummyselectedAudioFiles?.value.name != ""
                              ? controller.dummyselectedAudioFiles!.value.name
                              : "Upload audio",
                          style: bodySmallText(context),
                        ))
                      ],
                    ),
                  ],
                )),
            kLargeVerticalSpacing,
            kLargeVerticalSpacing,
            Center(
              child: PrimaryButton(
                color: controller.updateMedLoadingState.value == true
                    ? kPrimaryColor.withOpacity(0.4)
                    : kPrimaryColor,
                text: controller.updateMedLoadingState.value == true
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
                  if (controller.updateMedformKey.currentState!.validate() &&
                      controller.selectedImageFiles?.value != null &&
                      controller.selectedMusicFiles?.value != null) {
                    setState(() {
                      controller.updateMedLoadingState.value = true;
                    });
                    await controller
                        .uploadImage(
                            whichFile: controller.selectedImageFiles!.value, fileName: controller.dummyselectedImageFiles!.value.name)
                        .then((image) async {
                      await controller
                          .uploadImage(
                              whichFile: controller.selectedMusicFiles!.value, fileName: controller.dummyselectedAudioFiles!.value.name)
                          .then((audio) async {
                        await Future.value(
                            controller.updateMeditationnOfTheMonth(
                                audioLink: audio,
                                imageLink: image,
                                context: context,
                                collectDesc: controller
                                    .updateMedcategoryDesc.text
                                    .trim(),
                                collectTitle: controller
                                    .updateMedcategoryName.text
                                    .trim()));
                      });
                    });

                    setState(() {
                      controller.updateMedLoadingState.value = false;
                    });
                  } else {
                    cToast(
                        msg: 'Kindly upload all required data',
                        color: kErrorColor,
                        context: context);
                  }
                },
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ],
        ),
      );
    });
  }
}

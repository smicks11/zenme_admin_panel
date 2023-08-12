// ignore_for_file: prefer_const_constructors

library dashboard;

import 'dart:io';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_task/app/config/model/user_model.dart';
import 'package:daily_task/app/config/routes/app_pages.dart';
import 'package:daily_task/app/constans/app_constants.dart';
import 'package:daily_task/app/features/auth/sign_in.dart';
import 'package:daily_task/app/features/dashboard/views/widgets/edit_crystal.dart';
import 'package:daily_task/app/features/dashboard/views/widgets/update_meditation.dart';
import 'package:daily_task/app/shared_components/card_task.dart';
import 'package:daily_task/app/shared_components/header_text.dart';
import 'package:daily_task/app/shared_components/list_task_assigned.dart';
import 'package:daily_task/app/shared_components/list_task_date.dart';
import 'package:daily_task/app/shared_components/responsive_builder.dart';
import 'package:daily_task/app/shared_components/search_field.dart';
import 'package:daily_task/app/shared_components/selection_button.dart';
import 'package:daily_task/app/shared_components/simple_selection_button.dart';
import 'package:daily_task/app/shared_components/simple_user_profile.dart';
import 'package:daily_task/app/shared_components/task_progress.dart';
import 'package:daily_task/app/shared_components/user_profile.dart';
import 'package:daily_task/app/utils/ui/ui_utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/model/admin_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_spacing.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../../utils/snackbar.dart';
import '../widgets/crystal_image.dart';
import '../widgets/edit_card.dart';
import '../widgets/meditation_image.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// model

// component
part '../components/bottom_navbar.dart';
part '../components/header_weekly_task.dart';
part '../components/main_menu.dart';
part '../components/task_menu.dart';
part '../components/member.dart';
part '../components/task_in_progress.dart';
part '../components/weekly_task.dart';
part '../components/task_group.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scafoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: _buildSidebar(context)),
              ),
            ),
      bottomNavigationBar: (ResponsiveBuilder.isDesktop(context) || kIsWeb)
          ? null
          : const _BottomNavbar(),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaskContent(
                    onPressedMenu: () => controller.openDrawer(),
                  ),
                  _buildCalendarContent(context),
                ],
              ),
            );
          },
          tabletBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 800 ? 8 : 7,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildTaskContent(
                      onPressedMenu: () => controller.openDrawer(),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const VerticalDivider(),
                ),
                Flexible(
                  flex: 4,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildCalendarContent(context),
                  ),
                ),
              ],
            );
          },
          desktopBuilder: (context, constraints) {
            return Obx(() {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: constraints.maxWidth > 1350 ? 3 : 4,
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: _buildSidebar(context),
                    ),
                  ),
                  controller.screenControllerIndex.value == 0
                      ? Flexible(
                          flex: constraints.maxWidth > 1350 ? 10 : 9,
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: _buildTaskContent(),
                          ),
                        )
                      : controller.screenControllerIndex.value == 1
                          ? Flexible(
                              flex: constraints.maxWidth > 1350 ? 10 : 9,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: _buildUserContent(context: context),
                              ),
                            )
                          : controller.screenControllerIndex.value == 2
                              ? Flexible(
                                  flex: constraints.maxWidth > 1350 ? 10 : 9,
                                  child: SingleChildScrollView(
                                      controller: ScrollController(),
                                      child: _buildAirContent(
                                          context: context)))
                              : controller.screenControllerIndex.value == 3
                                  ? Flexible(
                                      flex: constraints.maxWidth > 1350
                                          ? 10
                                          : 9,
                                      child: SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: _buildWaterContent(
                                              context: context)))
                                  : controller.screenControllerIndex.value == 4
                                      ? Flexible(
                                          flex: constraints.maxWidth > 1350
                                              ? 10
                                              : 9,
                                          child: SingleChildScrollView(
                                              controller: ScrollController(),
                                              child: _buildEarthContent(
                                                  context: context)))
                                      : controller.screenControllerIndex
                                                  .value ==
                                              5
                                          ? Flexible(
                                              flex: constraints.maxWidth > 1350
                                                  ? 10
                                                  : 9,
                                              child:
                                                  SingleChildScrollView(
                                                      controller:
                                                          ScrollController(),
                                                      child: _buildFireContent(
                                                          context: context)))
                                          : controller.screenControllerIndex
                                                      .value ==
                                                  6
                                              ? Flexible(
                                                  flex:
                                                      constraints
                                                                  .maxWidth >
                                                              1350
                                                          ? 10
                                                          : 9,
                                                  child: SingleChildScrollView(
                                                      controller:
                                                          ScrollController(),
                                                      child: _buildQuoteContent(
                                                          context: context)))
                                              : Flexible(
                                                  flex: constraints.maxWidth >
                                                          1350
                                                      ? 10
                                                      : 9,
                                                  child: SizedBox(
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                kPrimaryColor),
                                                        strokeWidth: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const VerticalDivider(),
                  ),
                  Flexible(
                    flex: 4,
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: _buildCalendarContent(context),
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UserProfile(
            data: controller.dataProfil,
            onPressed: controller.onPressedProfil,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _MainMenu(onSelected: controller.onSelectedMainMenu),
        ),
        const Divider(
          indent: 20,
          thickness: 1,
          endIndent: 20,
          height: 60,
        ),
        // _Member(member: controller.member),
        // const SizedBox(height: kSpacing),
        _TaskMenu(
          onSelected: controller.onSelectedTaskMenu,
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: Text(
            "2023 Taleensofee Zen Me",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  Widget _buildAirContent(
      {Function()? onPressedMenu, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Text('Update categories',
              style: bodyNormalText(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          kTinyVerticalSpacing,
          Text(
            'Update 4 categories of the air section',
            style: bodySmallText(context).copyWith(color: Colors.black38),
          ),
          kLargeVerticalSpacing,
          FutureBuilder<List<AirContentModel>>(
              future: controller.getAirContentsFromDb(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return EditCard(
                            category: "air",
                            secondContent: snapshot.data![index].description,
                            firstContent: snapshot.data![index].name);
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Somethinng went wrong',
                      style: bodySmallText(context),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _buildWaterContent(
      {Function()? onPressedMenu, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Text('Update categories',
              style: bodyNormalText(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          kTinyVerticalSpacing,
          Text(
            'Update 4 categories of the water section',
            style: bodySmallText(context).copyWith(color: Colors.black38),
          ),
          kLargeVerticalSpacing,
          FutureBuilder<List<WaterContentModel>>(
              future: controller.getWaterContentsFromDb(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return EditCard(
                            category: 'water',
                            secondContent: snapshot.data![index].description,
                            firstContent: snapshot.data![index].name);
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  print(snapshot.data);
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: bodySmallText(context),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _buildEarthContent(
      {Function()? onPressedMenu, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Text('Update categories',
              style: bodyNormalText(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          kTinyVerticalSpacing,
          Text(
            'Update 4 categories of the earth section',
            style: bodySmallText(context).copyWith(color: Colors.black38),
          ),
          kLargeVerticalSpacing,
          FutureBuilder<List<EarthContentModel>>(
              future: controller.getEarthContentsFromDb(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return EditCard(
                            category: 'earth',
                            secondContent: snapshot.data![index].description,
                            firstContent: snapshot.data![index].name);
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Somethinng went wrong',
                      style: bodySmallText(context),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _buildFireContent(
      {Function()? onPressedMenu, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Text('Update categories',
              style: bodyNormalText(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          kTinyVerticalSpacing,
          Text(
            'Update 4 categories of the fire section',
            style: bodySmallText(context).copyWith(color: Colors.black38),
          ),
          kLargeVerticalSpacing,
          FutureBuilder<List<FireContentModel>>(
              future: controller.getFireContentsFromDb(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return EditCard(
                            category: 'fire',
                            secondContent: snapshot.data![index].description,
                            firstContent: snapshot.data![index].name);
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Somethinng went wrong',
                      style: bodySmallText(context),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _buildQuoteContent(
      {Function()? onPressedMenu, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Text('Update Quote',
              style: bodyNormalText(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          kTinyVerticalSpacing,
          Text(
            'Kindly note that add new set of quote will override existing quotes on the system',
            style: bodySmallText(context).copyWith(color: Colors.black38),
          ),
          kLargeVerticalSpacing,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.chipItems.map((item) {
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Row(
                      children: [
                        Text(item),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => controller.removeItem(item),
                          child: Icon(Icons.clear, size: 16),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red.withOpacity(0.2),
                  ),
                );
              }).toList(),
            ),
          ),
          kLargeVerticalSpacing,
          TextField(
            controller: controller.textController,
            decoration: InputDecoration(
              hintText: 'Enter a quote',
              suffixIcon: IconButton(
                onPressed: controller.addItem,
                icon: Icon(Icons.send),
              ),
            ),
            onSubmitted: (_) => controller.addItem(),
          ),
          kLargeVerticalSpacing,
          ElevatedButton(
            onPressed: () {
              if (controller.chipItems.isEmpty) {
                AppDialog.showSuccessDialog(
                  lottie: 'oops.json',
                  context: context,
                  header: "You are yet to add a quote",
                  body: "Retry",
                );
              } else {
                showDialog(
                    context: context,
                    builder: (
                      context,
                    ) {
                      return AlertDialog(
                        title: Text(
                          'Are you sure you want to update quote? This will clear all exisiting quote',
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
                              controller.updateQuotesList(
                                  controller.chipItems, context);
                            },
                          )
                        ],
                      );
                    });
              }
            },
            child: Text(controller.editLoadingState.value == true
                ? 'Processing...'
                : 'Update quote'),
          ),
        ],
      ),
    );
  }

  Widget _buildCrystalOfTheMonth(
      {Function()? onPressedMenu, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: ListView(
        children: [
          const SizedBox(height: kSpacing),
          // Text('Update crystal of the month',
          //     style: bodyNormalText(context).copyWith(
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //         color: kPrimaryColor)),
          // kTinyVerticalSpacing,
          // Text(
          //   'Update crystal of the month section',
          //   style: bodySmallText(context).copyWith(color: Colors.black38),
          // ),
          // kLargeVerticalSpacing,
          FutureBuilder<List<CrystalContentModel>>(
              future: controller.getCrystalContentsFromDb(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return EditCrystal(
                            index: index,
                            subTitle: snapshot.data![index].subName,
                            desc: snapshot.data![index].description,
                            title: snapshot.data![index].name);
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Somethinng went wrong',
                      style: bodySmallText(context),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _buildUserContent(
      {Function()? onPressedMenu, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Text('Registered Users',
              style: bodyNormalText(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          kTinyVerticalSpacing,
          Text(
            'Track and maintain user data',
            style: bodySmallText(context).copyWith(color: Colors.black38),
          ),
          kLargeVerticalSpacing,
          FutureBuilder<List<UserModel>>(
              future: controller.getUsersFromDb(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return buildDataTable(snapshot.data!);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Somethinng went wrong',
                      style: bodySmallText(context),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget buildDataTable(List<UserModel> users) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: const [
            DataColumn(
                label: Text(
              'Name of User',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text('Email',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Registration Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
          ],
          rows: users.map((user) {
            return DataRow(
              cells: [
                DataCell(Text('${user.fName} ${user.lName}')),
                DataCell(Text(user.email)),
                DataCell(Text(DateFormat.yMMMMEEEEd().format(user.regTime))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTaskContent({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Row(
            children: [
              if (onPressedMenu != null)
                Padding(
                  padding: const EdgeInsets.only(right: kSpacing / 2),
                  child: IconButton(
                    onPressed: onPressedMenu,
                    icon: const Icon(Icons.menu),
                  ),
                ),
              Expanded(
                child: SearchField(
                  onSearch: controller.searchTask,
                  hintText: "Looking for something .. ",
                ),
              ),
            ],
          ),
          const SizedBox(height: kSpacing),
          Row(
            children: [
              Expanded(
                child: HeaderText(controller.greeting()),
              ),
              const SizedBox(width: kSpacing / 2),
              SizedBox(
                width: 200,
                child: TaskProgress(data: controller.dataTask),
              ),
            ],
          ),
          const SizedBox(height: kSpacing),
          ClipRRect(
            borderRadius: BorderRadius.circular(kBorderRadius * 2),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.taskInProgress.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                  child: InkResponse(
                    onTap: () {
                      if (index == 0) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return UpdateMeditation(controller: controller);
                            });
                      } else if (index == 1) {
                        showDialog(
                            context: context,
                            builder: (
                              context,
                            ) {
                              return _buildCrystalOfTheMonth(context: context);
                            });
                      } else if (index == 2) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return UpdateCrystalImage(controller: controller);
                            });
                        // showDialog(
                        //     context: context,
                        //     builder: (
                        //       context,
                        //     ) {
                        //       return AlertDialog(
                        //         title: Text(
                        //           'Still in development',
                        //           style: bodySmallText(context),
                        //         ),
                        //         shape: const RoundedRectangleBorder(
                        //             borderRadius:
                        //                 BorderRadius.all(Radius.circular(14))),
                        //         actions: <Widget>[
                        //           //flatbutton changed
                        //           TextButton(
                        //               onPressed: () => Navigator.pop(context),
                        //               child: const Text('Go back')),
                        //         ],
                        //       );
                        //     });
                      } else if (index == 3) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return UpdateMeditationImage(
                                  controller: controller);
                            });
                        // showDialog(
                        //     context: context,
                        //     builder: (
                        //       context,
                        //     ) {
                        //       return AlertDialog(
                        //         title: Text(
                        //           'Still in development',
                        //           style: bodySmallText(context),
                        //         ),
                        //         shape: const RoundedRectangleBorder(
                        //             borderRadius:
                        //                 BorderRadius.all(Radius.circular(14))),
                        //         actions: <Widget>[
                        //           //flatbutton changed
                        //           TextButton(
                        //               onPressed: () => Navigator.pop(context),
                        //               child: const Text('Go back')),
                        //         ],
                        //       );
                        //     });
                      }
                      // print('tapped!!');
                      // controller.onSelectedHomeOptions(index);
                    },
                    child: CardTask(
                      data: controller.taskInProgress[index],
                      primary: _getSequenceColor(index),
                      onPrimary: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // _TaskInProgress(
          //   data: controller.taskInProgress,
          // ),
          const SizedBox(height: kSpacing * 2),
          // const _HeaderWeeklyTask(),
          // const SizedBox(height: kSpacing),
          // _WeeklyTask(
          //   data: controller.weeklyTask,
          //   onPressed: controller.onPressedTask,
          //   onPressedAssign: controller.onPressedAssignTask,
          //   onPressedMember: controller.onPressedMemberTask,
          // )
        ],
      ),
    );
  }

  Color _getSequenceColor(int index) {
    int val = index % 4;
    if (val == 3) {
      return Colors.indigo;
    } else if (val == 2) {
      return Colors.grey;
    } else if (val == 1) {
      return Colors.redAccent;
    } else {
      return Colors.lightBlue;
    }
  }

  Widget _buildCalendarContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Row(
            children: [
              const Expanded(child: HeaderText("Users")),
              IconButton(
                onPressed: controller.onPressedCalendar,
                icon: const Icon(EvaIcons.people),
                tooltip: "users",
              )
            ],
          ),
          const SizedBox(height: kSpacing),
          FutureBuilder<List<UserModel>>(
              future: controller.getUsersFromDb(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return _TaskGroup(
                    title: 'Total users: ${snapshot.data!.length}',
                    data: snapshot.data!,
                    onPressed: controller.onPressedTaskGroup,
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      strokeWidth: 1,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Somethinng went wrong',
                      style: bodySmallText(context),
                    ),
                  );
                }
              })
          // ...controller.taskGroup
          //     .map(
          //       (e) => _TaskGroup(
          //         title: DateFormat('d MMMM').format(e[0].date),
          //         data: e,
          //         onPressed: controller.onPressedTaskGroup,
          //       ),
          //     )
          //     .toList()
        ],
      ),
    );
  }
}

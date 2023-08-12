// ignore_for_file: avoid_print

part of dashboard;

class DashboardController extends GetxController {
  final scafoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final editformKey = GlobalKey<FormState>();
  final authKey = GlobalKey<FormState>();
  final updateMedformKey = GlobalKey<FormState>();
  Rx<bool> obserText = true.obs;
  Rx<bool> authLoad = false.obs;
  BuildContext? context;

  Rx<Uint8List>? selectedImageFiles = Uint8List(0).obs;
  Rx<Uint8List>? selectedMusicFiles = Uint8List(0).obs;

  Rx<PlatformFile>? dummyselectedImageFiles =
      PlatformFile(name: '', size: 0).obs;
  Rx<PlatformFile>? dummyselectedAudioFiles =
      PlatformFile(name: '', size: 0).obs;

  TextEditingController textController = TextEditingController();
  RxList<String> chipItems = <String>[].obs;
  // PlatformFile(name: '', size: 0).obs;
  // Rx<PlatformFile>? selectedMusicFiles = PlatformFile(name: '', size: 0).obs;

  addItem() {
    if (textController.text.isNotEmpty) {
      chipItems.insert(0, textController.text);
      textController.clear();
    }
  }

  removeItem(String item) {
    chipItems.remove(item);
  }

  Future<void> updateQuotesList(
      List<String> newQuotes, BuildContext context) async {
    changeEditLoadingState(true);
    try {
      String documentId = "kTOmfndHotK1sCJVRIwr";
      CollectionReference quotesCollection =
          FirebaseFirestore.instance.collection('quotes');

      await quotesCollection.doc(documentId).update({
        'allQuotes': newQuotes,
        'initialTimeOfLaunch': DateTime.now(),
        'quoteOfTheDay': newQuotes[0]
      });

      changeEditLoadingState(false);
      AppDialog.showSuccessDialog(
        lottie: '64787-success.json',
        context: context,
        header: "Quotes updated",
        body: "Ride on",
      );

      print('Document updated successfully');
    } catch (error) {
      changeEditLoadingState(false);
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print('Error updating document: $error');
    }
  }

  changeAuthLoad(bool value, StateSetter setState) {
    setState(() {
      authLoad.value = value;
    });
  }

  togglePasswordIcon() {
    obserText.value = !obserText.value;
  }

  getDummySelectedImageFile(PlatformFile file, StateSetter setState) {
    dummyselectedImageFiles?.value = file;
    setState(() {});
  }

  getDummySelectedAudioFile(PlatformFile file, StateSetter setState) {
    dummyselectedAudioFiles?.value = file;
    setState(() {});
  }

  getSelectedImageFile(Uint8List file, StateSetter setState) {
    selectedImageFiles?.value = file;
    setState(() {});
  }

  getSelectedAudioFile(Uint8List file, StateSetter setState) {
    selectedMusicFiles?.value = file;
    setState(() {});
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController categoryName = TextEditingController();
  final TextEditingController categoryDesc = TextEditingController();

  final TextEditingController updateMedcategoryName = TextEditingController();
  final TextEditingController updateMedcategoryDesc = TextEditingController();

  final TextEditingController crystalTitle = TextEditingController();
  final TextEditingController crystalSub = TextEditingController();
  final TextEditingController crystalDesc = TextEditingController();
  RxBool updateMedLoadingState = false.obs;
  RxBool editLoadingState = false.obs;
  RxBool showEditScreenVariable = false.obs;

  RxInt screenControllerIndex = 0.obs;
  RxInt homeOptionIndex = 0.obs;

  UploadTask? uploadTask;

  Future<String> uploadImage(
      {required Uint8List whichFile, required String fileName}) async {
    final path = 'files/$fileName';
    // final file = File(whichFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putData(whichFile);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Dowload Link: $urlDownload');

    return urlDownload;
  }

  Future updateMeditationnOfTheMonth({
    required BuildContext context,
    required String collectDesc,
    required String collectTitle,
    required String audioLink,
    required String imageLink,
  }) async {
    late List<dynamic> earthContent;

    // late List<dynamic> airContentSecondList;
    try {
      _db.collection("meditation").doc('LbyVeNQ0DPGmEuMB1S9Q').set({
        "meditation": FieldValue.arrayUnion([
          {
            "description": collectDesc,
            "title": collectTitle,
            "image": imageLink,
            "audio": audioLink,
            "date": DateTime.now(),
          }
        ]),
      }, SetOptions(merge: false)).then((value) {
        AppDialog.showSuccessDialog(
          lottie: '64787-success.json',
          context: context,
          header: "Meditation of the month updated",
          body: "Ride on",
        );
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  final dataProfil = const UserProfileData(
    image: NetworkImage(
        "https://static.wixstatic.com/media/720907_4e588a93a1234b89b5ed3ae1d69395ce~mv2.jpg/v1/crop/x_0,y_22,w_1242,h_1231/fill/w_686,h_680,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/head%20shot%202_JPG.jpg"),
    name: "Taleen Sofee",
    jobDesk: "Admin",
  );

  final member = ["Avril Kimberly", "Michael Greg"];

  final dataTask = const TaskProgressData(totalTask: 5, totalCompleted: 1);

  showEditScreen(bool value) {
    showEditScreenVariable.value = value;
  }

  changeEditLoadingState(bool value) {
    editLoadingState.value = value;
  }

  final taskInProgress = [
    CardTaskData(
      label: "Update meditation of the month",
      jobDesk: "Admin",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    ),
    CardTaskData(
      label: "Update crystal of the month",
      jobDesk: "Admin",
      dueDate: DateTime.now().add(const Duration(hours: 4)),
    ),
    CardTaskData(
      label: "Update Crystal of the month image",
      jobDesk: "Admin",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    CardTaskData(
      label: "Update Meditation of the month image",
      jobDesk: "Admin",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    )
  ];

  final weeklyTask = [
    ListTaskAssignedData(
      icon: const Icon(EvaIcons.monitor, color: Colors.blueGrey),
      label: "Slicing UI",
      jobDesk: "Programmer",
      assignTo: "Alex Ferguso",
      editDate: DateTime.now().add(-const Duration(hours: 2)),
    ),
    ListTaskAssignedData(
      icon: const Icon(EvaIcons.star, color: Colors.amber),
      label: "Personal branding",
      jobDesk: "Marketing",
      assignTo: "Justin Beck",
      editDate: DateTime.now().add(-const Duration(days: 50)),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.colorPalette, color: Colors.blue),
      label: "UI UX ",
      jobDesk: "Design",
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.pieChart, color: Colors.redAccent),
      label: "Determine meeting schedule ",
      jobDesk: "System Analyst",
    ),
  ];

  final taskGroup = [
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 2, hours: 10)),
        label: "5 posts on instagram",
        jobdesk: "Marketing",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 2, hours: 11)),
        label: "Platform Concept",
        jobdesk: "Animation",
      ),
    ],
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 4, hours: 5)),
        label: "UI UX Marketplace",
        jobdesk: "Design",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 4, hours: 6)),
        label: "Create Post For App",
        jobdesk: "Marketing",
      ),
    ],
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 5)),
        label: "2 Posts on Facebook",
        jobdesk: "Marketing",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 6)),
        label: "Create Icon App",
        jobdesk: "Design",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 8)),
        label: "Fixing Error Payment",
        jobdesk: "Programmer",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 10)),
        label: "Create Form Interview",
        jobdesk: "System Analyst",
      ),
    ]
  ];

  void onPressedProfil() {}

  void onSelectedMainMenu(int index, SelectionButtonData value) {
    if (index == 7) {
      signOut();
    } else {
      screenControllerIndex.value = index;
    }
  }

  void onSelectedHomeOptions(int index) {
    print(index);
    homeOptionIndex.value = index;
  }

  void onSelectedTaskMenu(int index, String label) {
    if (index == 0) {
      launchUrl(
        Uri.parse('https://www.taleensofee.com/'),
        webOnlyWindowName: '_blank',
      );
    }
    if (index == 1) {
      launchUrl(
        Uri.parse('https://www.taleensofee.com/copy-of-about-me'),
        webOnlyWindowName: '_blank',
      );
    }
    if (index == 2) {
      launchUrl(
        Uri.parse(
            'https://www.amazon.com/SELF-talk-33-levels-provement/dp/B08S2YCJW2/ref=tmm_pap_swatch_0?_encoding=UTF8&qid=1657645577&sr=8-1'),
        webOnlyWindowName: '_blank',
      );
    }
  }

  void searchTask(String value) {}

  void onPressedTask(int index, ListTaskAssignedData data) {}
  void onPressedAssignTask(int index, ListTaskAssignedData data) {}
  void onPressedMemberTask(int index, ListTaskAssignedData data) {}
  void onPressedCalendar() {}
  void onPressedTaskGroup(int index, ListTaskDateData data) {}

  void openDrawer() {
    if (scafoldKey.currentState != null) {
      scafoldKey.currentState!.openDrawer();
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning Admin';
    }
    if (hour < 17) {
      return 'Good afternoon Admin';
    }
    return 'Good Evening Admin';
  }

  //Database Repository
  //Air
  Future<List<AirContentModel>> getAirContentsFromDb(
      {required BuildContext context}) async {
    late List<dynamic> airContent;

    List<AirContentModel> airModelList = [];

    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "tjICTgjPbKos53G0JIjF") {
          airContent = element['elementContent'];
          airContent.forEach((element) {
            AirContentModel airContentModel = AirContentModel(
                name: element['name'], description: element['description']);
            airModelList.add(airContentModel);
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }

    return airModelList;
  }

  //Water
  Future<List<WaterContentModel>> getWaterContentsFromDb(
      {required BuildContext context}) async {
    late List<dynamic> waterContent;

    List<WaterContentModel> waterModelList = [];

    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "yntDFLuVbspzzKIDcpEI") {
          waterContent = element['elementContent'];
          waterContent.forEach((element) {
            WaterContentModel waterContentModel = WaterContentModel(
                name: element['name'], description: element['description']);
            waterModelList.add(waterContentModel);
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }

    return waterModelList;
  }

  //Earth
  //Earth

  Future<List<EarthContentModel>> getEarthContentsFromDb(
      {required BuildContext context}) async {
    late List<dynamic> earthContent;

    List<EarthContentModel> earthModelList = [];
    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "WGdHT2F3qqOKDCayzSPv") {
          earthContent = element['elementContent'];
          earthContent.forEach((element) {
            EarthContentModel earthContentModel = EarthContentModel(
                name: element['name'], description: element['description']);
            earthModelList.add(earthContentModel);
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }

    return earthModelList;
  }

  //Fire

  Future<List<FireContentModel>> getFireContentsFromDb(
      {required BuildContext context}) async {
    late List<dynamic> fireContent;

    List<FireContentModel> fireModelList = [];

    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "dssRhQXKBUbksccN8eTR") {
          fireContent = element['elementContent'];
          fireContent.forEach((element) {
            FireContentModel fireContentModel = FireContentModel(
                name: element['name'], description: element['description']);
            fireModelList.add(fireContentModel);
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }

    return fireModelList;
  }

  Future<List<CrystalContentModel>> getCrystalContentsFromDb(
      {required BuildContext context}) async {
    late List<dynamic> crystalContent;

    List<CrystalContentModel> crystalModelList = [];
    try {
      await _db
          .collection("crystalOfTheMonth")
          .doc('bldWgphVLGIk5cdBGmNv')
          .get()
          .then((value) {
        crystalContent = value['content'];

        crystalContent.forEach((element) {
          CrystalContentModel crystalContentModel = CrystalContentModel(
              name: element['title'],
              subName: element['sub'],
              description: element['desc']);
          crystalModelList.add(crystalContentModel);
        });
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }

    return crystalModelList;
  }

  //Users
  Future<List<UserModel>> getUsersFromDb(
      {required BuildContext context}) async {
    List<UserModel> userList = [];

    try {
      QuerySnapshot snapshot = await _db.collection("UserData").get();
      snapshot.docs.forEach((element) {
        UserModel userModel = UserModel(
            fName: element['fName'],
            lName: element['lName'],
            profilePicture: element['profilePicture'],
            userId: element['userId'],
            email: element['email'],
            regTime: DateTime.parse(
                element['registrationTime'].toDate().toString()));
        userList.add(userModel);
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }

    return userList;
  }

  //UPDATE DB METHODS
  Future updateAirContent({
    required BuildContext context,
    required String collectedDesc,
    required String collectedTitle,
    required String categoryName,
    required String categoryDesc,
  }) async {
    late List<dynamic> airContent;

    // late List<dynamic> airContentSecondList;
    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "tjICTgjPbKos53G0JIjF") {
          airContent = element['elementContent'];
          airContent.forEach((element) {
            if (element['description'] == collectedDesc &&
                element['name'] == collectedTitle) {
              _db.collection("elements").doc('tjICTgjPbKos53G0JIjF').set({
                "elementContent": FieldValue.arrayUnion([
                  {
                    "description": categoryDesc,
                    "name": categoryName,
                  }
                ])
              }, SetOptions(merge: true)).then((value) async {
                QuerySnapshot snapshot = await _db.collection("elements").get();
                snapshot.docs.forEach((element) {
                  if (element['id'] == "tjICTgjPbKos53G0JIjF") {
                    airContent = element['elementContent'];
                    airContent.removeWhere((element) =>
                        element['description'] == collectedDesc &&
                        element['name'] == collectedTitle);
                    _db.collection("elements").doc('tjICTgjPbKos53G0JIjF').set({
                      "categoryName": "air",
                      "elementContent": FieldValue.arrayUnion(airContent),
                      "id": "tjICTgjPbKos53G0JIjF"
                    }).then((value) {
                      AppDialog.showUpdateDialog(
                        context: context,
                        header: "Content has been updated",
                        body: "Go back",
                      );
                    });
                  }
                });
              });
            }
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  Future updateFireContent({
    required BuildContext context,
    required String collectedDesc,
    required String collectedTitle,
    required String categoryName,
    required String categoryDesc,
  }) async {
    late List<dynamic> fireContent;

    // late List<dynamic> airContentSecondList;
    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "dssRhQXKBUbksccN8eTR") {
          fireContent = element['elementContent'];
          fireContent.forEach((element) {
            if (element['description'] == collectedDesc &&
                element['name'] == collectedTitle) {
              _db.collection("elements").doc('dssRhQXKBUbksccN8eTR').set({
                "elementContent": FieldValue.arrayUnion([
                  {
                    "description": categoryDesc,
                    "name": categoryName,
                  }
                ])
              }, SetOptions(merge: true)).then((value) async {
                QuerySnapshot snapshot = await _db.collection("elements").get();
                snapshot.docs.forEach((element) {
                  if (element['id'] == "dssRhQXKBUbksccN8eTR") {
                    fireContent = element['elementContent'];
                    fireContent.removeWhere((element) =>
                        element['description'] == collectedDesc &&
                        element['name'] == collectedTitle);
                    _db.collection("elements").doc('dssRhQXKBUbksccN8eTR').set({
                      "categoryName": "fire",
                      "elementContent": FieldValue.arrayUnion(fireContent),
                      "id": "dssRhQXKBUbksccN8eTR"
                    }).then((value) {
                      AppDialog.showUpdateDialog(
                        context: context,
                        header: "Content has been updated",
                        body: "Go back",
                      );
                    });
                  }
                });
              });
            }
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  Future updateEarthContent({
    required BuildContext context,
    required String collectedDesc,
    required String collectedTitle,
    required String categoryName,
    required String categoryDesc,
  }) async {
    late List<dynamic> earthContent;

    // late List<dynamic> airContentSecondList;
    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "WGdHT2F3qqOKDCayzSPv") {
          earthContent = element['elementContent'];
          earthContent.forEach((element) {
            if (element['description'] == collectedDesc &&
                element['name'] == collectedTitle) {
              _db.collection("elements").doc('WGdHT2F3qqOKDCayzSPv').set({
                "elementContent": FieldValue.arrayUnion([
                  {
                    "description": categoryDesc,
                    "name": categoryName,
                  }
                ])
              }, SetOptions(merge: true)).then((value) async {
                QuerySnapshot snapshot = await _db.collection("elements").get();
                snapshot.docs.forEach((element) {
                  if (element['id'] == "WGdHT2F3qqOKDCayzSPv") {
                    earthContent = element['elementContent'];
                    earthContent.removeWhere((element) =>
                        element['description'] == collectedDesc &&
                        element['name'] == collectedTitle);
                    _db.collection("elements").doc('WGdHT2F3qqOKDCayzSPv').set({
                      "categoryName": "earth",
                      "elementContent": FieldValue.arrayUnion(earthContent),
                      "id": "WGdHT2F3qqOKDCayzSPv"
                    }).then((value) {
                      AppDialog.showUpdateDialog(
                        context: context,
                        header: "Content has been updated",
                        body: "Go back",
                      );
                    });
                  }
                });
              });
            }
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  Future updateWaterContent({
    required BuildContext context,
    required String collectedDesc,
    required String collectedTitle,
    required String categoryName,
    required String categoryDesc,
  }) async {
    late List<dynamic> waterContent;

    // late List<dynamic> airContentSecondList;
    try {
      QuerySnapshot snapshot = await _db.collection("elements").get();
      snapshot.docs.forEach((element) {
        if (element['id'] == "yntDFLuVbspzzKIDcpEI") {
          waterContent = element['elementContent'];
          waterContent.forEach((element) {
            if (element['description'] == collectedDesc &&
                element['name'] == collectedTitle) {
              _db.collection("elements").doc('yntDFLuVbspzzKIDcpEI').set({
                "elementContent": FieldValue.arrayUnion([
                  {
                    "description": categoryDesc,
                    "name": categoryName,
                  }
                ])
              }, SetOptions(merge: true)).then((value) async {
                QuerySnapshot snapshot = await _db.collection("elements").get();
                snapshot.docs.forEach((element) {
                  if (element['id'] == "yntDFLuVbspzzKIDcpEI") {
                    waterContent = element['elementContent'];
                    waterContent.removeWhere((element) =>
                        element['description'] == collectedDesc &&
                        element['name'] == collectedTitle);
                    _db.collection("elements").doc('yntDFLuVbspzzKIDcpEI').set({
                      "categoryName": "water",
                      "elementContent": FieldValue.arrayUnion(waterContent),
                      "id": "yntDFLuVbspzzKIDcpEI"
                    }).then((value) {
                      AppDialog.showUpdateDialog(
                        context: context,
                        header: "Content has been updated",
                        body: "Go back",
                      );
                    });
                  }
                });
              });
            }
          });
        }
      });
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  Future<void> updateCrystalOfTheMonth({
    required BuildContext context,
    required String collectSub,
    required String collectDesc,
    required String collectTitle,
    required int indexToUpdate, // Default index is 0
  }) async {
    try {
      DocumentReference docRef =
          _db.collection("crystalOfTheMonth").doc('bldWgphVLGIk5cdBGmNv');

      DocumentSnapshot snapshot = await docRef.get();
      List<dynamic> contentList = snapshot.get("content");

      if (indexToUpdate >= 0 && indexToUpdate < contentList.length) {
        contentList[indexToUpdate] = {
          "desc": collectDesc,
          "title": collectTitle,
          "sub": collectSub,
        };

        await docRef.update({"content": contentList});

        AppDialog.showSuccessDialog(
          lottie: '64787-success.json',
          context: context,
          header: "Crystal of the month updated",
          body: "Ride on",
        );
      } else {
        AppDialog.showSuccessDialog(
          lottie: 'oops.json',
          context: context,
          header: "Invalid index",
          body: "Retry with a valid index",
        );
      }
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  Future<void> updateCrystalOfTheMonthImage({
    required BuildContext context,
    required String collectImage,
    int indexToUpdate = 1, // Default index is 0
  }) async {
    try {
      DocumentReference docRef =
          _db.collection("homeOptions").doc('dHQkLgdjngdTrUVtN4y1');

      DocumentSnapshot snapshot = await docRef.get();
      List<dynamic> contentList = snapshot.get("options");

      if (indexToUpdate >= 0 && indexToUpdate < contentList.length) {
        contentList[indexToUpdate] = {
          "buttonText": 'CLICK HERE',
          "dummy": "",
          "image": collectImage,
          "title": "Crystal of the month",
        };

        await docRef.update({"options": contentList});

        AppDialog.showSuccessDialog(
          lottie: '64787-success.json',
          context: context,
          header: "Crystal of the month image updated",
          body: "Ride on",
        );
      } else {
        AppDialog.showSuccessDialog(
          lottie: 'oops.json',
          context: context,
          header: "Invalid index",
          body: "Retry with a valid index",
        );
      }
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  Future<void> updateMeditationOfTheMonthImage({
    required BuildContext context,
    required String collectImage,
    int indexToUpdate = 0, // Default index is 0
  }) async {
    try {
      DocumentReference docRef =
          _db.collection("homeOptions").doc('dHQkLgdjngdTrUVtN4y1');

      DocumentSnapshot snapshot = await docRef.get();
      List<dynamic> contentList = snapshot.get("options");

      if (indexToUpdate >= 0 && indexToUpdate < contentList.length) {
        contentList[indexToUpdate] = {
          "buttonText": 'CLICK HERE',
          "dummy": "",
          "image": collectImage,
          "title": "Meditation of the month",
        };

        await docRef.update({"options": contentList});

        AppDialog.showSuccessDialog(
          lottie: '64787-success.json',
          context: context,
          header: "Meditation of the month image updated",
          body: "Ride on",
        );
      } else {
        AppDialog.showSuccessDialog(
          lottie: 'oops.json',
          context: context,
          header: "Invalid index",
          body: "Retry with a valid index",
        );
      }
    } catch (e) {
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "Something went wrong 😞",
        body: "Retry",
      );
      print(e.toString());
    }
  }

  //AUTHENTICATION SERVICE
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      if (email.toLowerCase() == "admin@zenme.com" &&
          password == "admin@1234") {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          Get.toNamed(Routes.dashboard);
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (ctx) => const DashboardScreen()),
          //     (route) => false);
          return value;
        });
      } else {
        await Future.delayed(const Duration(seconds: 3), () {
          AppDialog.showSuccessDialog(
            lottie: 'oops.json',
            context: context,
            header: "Login details not recongized as an admin on the portal 😞",
            body: "Go back",
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header: "${e.message} 😞",
        body: "Go back",
      );
    } catch (e) {
      print(e.toString());
      AppDialog.showSuccessDialog(
        lottie: 'oops.json',
        context: context,
        header:
            "Something went wrong 😞 Kindly contact admin to assist with the issue",
        body: "Go back",
      );
    }
  }

  //Sign out
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut().then((value) {
      Get.offAndToNamed(Routes.signIn);
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (ctx) => const SignIn()),
      //     (route) => false);
      // cToast(msg: "Signed out", color: kPrimaryColor, context: context);
    });
  }
}

part of dashboard;

class DashboardController extends GetxController {
  final scafoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxInt screenControllerIndex = 0.obs;

  final dataProfil = const UserProfileData(
    image: AssetImage(ImageRasterPath.man),
    name: "Firgia",
    jobDesk: "Project Manager",
  );

  final member = ["Avril Kimberly", "Michael Greg"];

  final dataTask = const TaskProgressData(totalTask: 5, totalCompleted: 1);

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
      label: "Crystal of the month",
      jobDesk: "Admin",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    CardTaskData(
      label: "Quote",
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
    screenControllerIndex.value = index;
  }

  void onSelectedTaskMenu(int index, String label) {}

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
}

part of ui_utils;

// contains all dialog templates
class AppDialog {
  // ignore_for_file: prefer_const_constructors

  static void showSuccessDialog(
      {required BuildContext context,
      required String header,
      required String body,
      required String lottie}) {
    showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kWhiteColor,
          content: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Center(
                      child: Container(
                        child: Lottie.asset(
                          'assets/lottie/$lottie',
                          height: 150.0,
                          repeat: true,
                          reverse: true,
                          animate: true,
                        ),
                      ),
                    ),
                    Text(
                      // 'Yay! 🎉 Your wallet has been funded successfully',
                      header,
                      textAlign: TextAlign.center,
                      style:
                          bodyNormalText(context).copyWith(color: Colors.black),
                    ),
                    kLargeVerticalSpacing,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (ctx) => Walllet()));
                        },
                        child: Text(
                          // "Check wallet balance 🤩",
                          body,
                          style: labelText(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 30,
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

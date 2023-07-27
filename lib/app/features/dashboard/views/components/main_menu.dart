part of dashboard;

class _MainMenu extends StatelessWidget {
  const _MainMenu({
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  final Function(int index, SelectionButtonData value) onSelected;

  @override
  Widget build(BuildContext context) {
    return SelectionButton(
      data: [
        SelectionButtonData(
          activeIcon: EvaIcons.home,
          icon: EvaIcons.homeOutline,
          label: "Home",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.people,
          icon: EvaIcons.peopleOutline,
          label: "Manage Users",
          totalNotif: 100,
        ),
        // SelectionButtonData(
        //   activeIcon: EvaIcons.globe2,
        //   icon: EvaIcons.globe2Outline,
        //   label: "Community",
        //   totalNotif: 20,
        // ),
        // SelectionButtonData(
        //   activeIcon: EvaIcons.upload,
        //   icon: EvaIcons.uploadOutline,
        //   label: "Upload Quotes",
        // ),
        SelectionButtonData(
          activeIcon: EvaIcons.sun,
          icon: EvaIcons.sunOutline,
          label: "Air Content",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.droplet,
          icon: EvaIcons.dropletOutline,
          label: "Water Content",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.globe,
          icon: EvaIcons.globe2Outline,
          label: "Earth Content",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.collapse,
          icon: EvaIcons.collapseOutline,
          label: "Fire Content",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.logOut,
          icon: EvaIcons.logOutOutline,
          label: "Log out",
        ),
      ],
      onSelected: onSelected,
    );
  }
}

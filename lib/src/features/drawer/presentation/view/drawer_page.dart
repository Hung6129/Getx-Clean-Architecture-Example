import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_example/src/features/drawer/presentation/controller/drawer_controller.dart';
import 'package:get_example/src/features/drawer/presentation/view/drawer_item.dart';
import 'package:get_example/src/features/posts/presentation/views/post_page.dart';

class MainPage extends GetView<ZoomDrawerCon> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Widget getPages() {
        switch (controller.getCurrentIndex) {
          // case MenuItems.todo:
          //   return const TodoPage();
          case MenuItems.post:
            return const PostPage();
          // case MenuItems.worldTime:
          //   return const WorldTimePage();
          default:
            return const PostPage();
        }
      }

      return ZoomDrawer(
        controller: controller.z,
        borderRadius: 30,
        disableDragGesture: true,
        mainScreenTapClose: true,
        openCurve: Curves.fastOutSlowIn,
        slideWidth: MediaQuery.sizeOf(context).width * 0.65,
        duration: const Duration(milliseconds: 500),
        angle: -5,
        drawerShadowsBackgroundColor: Colors.black,
        menuScreenOverlayColor: Colors.black,
        menuBackgroundColor: Colors.black,
        mainScreen: getPages(),
        menuScreen: Builder(
          builder: (context) {
            return MenuPage(
              currentItem: controller.getCurrentIndex,
              onSelectedItem: (value) {
                controller.changeIndex(value);
                ZoomDrawer.of(context)!.close();
              },
            );
          },
        ),
      );
    });
  }
}

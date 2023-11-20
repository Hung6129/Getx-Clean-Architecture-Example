import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_example/src/features/drawer/presentation/view/drawer_item.dart';

class ZoomDrawerCon extends GetxController {
  var currentItem = MenuItems.post.obs;
  DrawerThings get getCurrentIndex => currentItem.value;

  final ZoomDrawerController z = ZoomDrawerController();

  void changeIndex(DrawerThings index) {
    currentItem.value = index;
  }
}

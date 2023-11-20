import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuItems {
  static const post = DrawerThings('Post', Icons.newspaper);
  static const todo = DrawerThings('Todo', Icons.list);
  static const worldTime = DrawerThings('World Time', Icons.timeline);

  static final listItems = <DrawerThings>[
    post,
    todo,
    worldTime,
  ];
}

class MenuPage extends StatelessWidget {
  final DrawerThings currentItem;
  final ValueChanged<DrawerThings> onSelectedItem;

  const MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildMenuItem(DrawerThings item) => ListTile(
          minLeadingWidth: 20,
          selectedColor: Colors.white,
          selectedTileColor: Colors.white.withOpacity(0.2),
          selected: currentItem == item,
          leading: Icon(
            item.icon,
            color: Colors.white,
          ),
          title: Text(
            item.title,
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            onSelectedItem(item);
          },
        );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ZoomDrawer.of(context)!.close();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Icon(Icons.close, color: Colors.black),
            ),
            const SizedBox(height: 120),
            ...MenuItems.listItems.map(buildMenuItem).toList(),
            const Divider(
              thickness: 1,
              indent: 5,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 30, left: 20),
        child: Text(
          "Version 1.0.0",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class DrawerThings {
  final String title;
  final IconData icon;

  const DrawerThings(this.title, this.icon);
}

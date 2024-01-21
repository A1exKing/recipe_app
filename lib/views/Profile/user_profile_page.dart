import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/controllers/auther_contoroller.dart';
import 'package:food_recipe_app/controllers/user_conreoller.dart';
import 'package:food_recipe_app/views/Profile/sliver_app_bar.dart';

import 'package:get/get.dart';



class UserProfilePage extends StatefulWidget {
  final AutherController autherController = Get.put(AutherController());
  final RecipeController recipeController = Get.put(RecipeController());

  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

final ScrollController scrollSliverController = ScrollController();

class PrifileAvatarController extends GetxController {
  var avatarSize = 1.0.obs; // Початковий розмір CircleAvatar

  void updateSize(double scrollPosition) {
    // Оновлення розміру в залежності від позиції прокрутки
    avatarSize.value = scrollPosition /* Ваша логіка для зміни розміру */;
  }
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    var avatarController = Get.put(PrifileAvatarController());
    scrollSliverController.addListener(() {
      // Отримайте контролер GetX
      double appBarHeight =
          420; // Визначте максимальну висоту вашого SliverAppBar тут;
      double shrinkOffset = scrollSliverController.position.pixels;
      bool isAppBarCollapsed = shrinkOffset > appBarHeight;
      // Оновіть розмір CircleAvatar в залежності від позиції прокрутки
      shrinkOffset < 240
          ? avatarController.updateSize(shrinkOffset * 0.01)
          : null;
      print(avatarController.avatarSize);
    });

    // Вкажіть довжину вкладок
  }

  @override
  Widget build(BuildContext context) {
    widget.autherController.fetchAuthors("1");
    widget.recipeController.fetchRecipesAuthor("1");
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (widget.autherController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            print(widget.autherController.status);

            return widget.autherController.status == "ok".obs
                ? NestedScrollView(
                    controller: scrollSliverController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                       UserSliverAppBar(
                            author: widget.autherController.authorsList[0]),
                             SliverTabBar(),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(),
                        // Ваші віджети для вкладок тут
                        // ListView.builder(
                        //   itemCount: widget.recipeController.recipes.length,
                        //   itemExtent: 220
                        //       .h, // Переконайтеся, що у вас є доступ до цих значень у вашому контексті
                        //   scrollDirection: Axis.vertical,
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 20.w, vertical: 18.h),
                        //   itemBuilder: (context, index) =>
                        //       //itemPopular( widget.recipeController.recipes[index],context),
                        // ),
                        SingleChildScrollView(
                          // Використовуйте SingleChildScrollView для інших вкладок, якщо вони не містять ListView
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 14.h),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text("About",
                                    style: TextStyle(
                                        color: Color(0xff242424),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
// Інший вміст для цієї вкладки
                              ],
                            ),
                          ),
                        ),
                        Text("data"), // Приклад інших вкладок
                        Text("data"),
                      ],
                    ),
                  )
                : Center(
                    child: Text("List is Empty"),
                  );
          }
        }));
  }
    }

  
class SliverTabBar extends StatelessWidget {
  const SliverTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          controller: _tabController,
          labelColor: Color(0xffF4612D),
          indicatorColor: Color(0xffF4612D),
          unselectedLabelColor: Color(0xff797979),
          tabs: [
            Tab(text: 'Recipes'),
            Tab(text: 'About'),
            Tab(text: 'Gallery'),
            Tab(text: 'Reviews'),
          ],
        ),
      ),
      pinned: true,
    );
  }
}
    
//'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE3fHx8ZW58MHx8fHx8',

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Встановіть потрібний колір фону
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

late TabController _tabController;

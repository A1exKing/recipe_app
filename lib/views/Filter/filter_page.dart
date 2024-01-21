import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/controllers/filter_controller.dart';
import 'package:get/get.dart';

class FilterPage extends StatefulWidget {
  FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final SelectionController controller = Get.find<SelectionController>();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
     
  //   });
  // }
  @override
  Widget build(BuildContext context) {
      controller.onOpenFilterPage();
   //controller.onOpenFilterPage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Фільтри"),
        centerTitle: true,
        leadingWidth: 70.w,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.only(left: 20.w),
            width: 20.r,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xfff6f6f6))),
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 20.h, top: 12.h),
                  child: Text(
                    "Категорія",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                    height: 36.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: tagsCategory.length,
                      itemBuilder: (context, index) {
                        var e = tagsCategory[index];
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.setTempSelectedCategory(e);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.h, vertical: 6.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(66),
                                  color:
                                      controller.tempSelectedCategory.value == e
                                          ? Color(0xffF4612D)
                                          : Color(0xfff6f6f6)),
                              child: Center(
                                  child: Text(
                                e,
                                style: TextStyle(
                                    color:
                                        controller.tempSelectedCategory.value ==
                                                e
                                            ? Colors.white
                                            : Color(0xff797979),
                                    fontSize: 16),
                              )),
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 18.h),
                  child: Text(
                    "Час готування (Минути)",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 75, child: RangeSliderWithLabels()),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 0.h, top: 20.h),
                  child: Text(
                    "Відгуки",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                RatingFilterScreen(),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 12.h, top: 20.h),
                  child: Text(
                    "Дієта",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: tagsDiet.length,
                    itemBuilder: (context, index) {
                      var e = tagsDiet[index];
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.setTempSelectedDiet(e);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.h, vertical: 6.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(66),
                                color: controller.tempSelectedDiet.value == e
                                    ? Color(0xffF4612D)
                                    : Color(0xfff6f6f6)),
                            child: Center(
                                child: Text(
                              e,
                              style: TextStyle(
                                  color: controller.tempSelectedDiet.value == e
                                      ? Colors.white
                                      : Color(0xff797979),
                                  fontSize: 16),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 12.h, top: 20.h),
                  child: Text(
                    "Рівень складності",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: tagsDLevel.length,
                    itemBuilder: (context, index) {
                      var e = tagsDLevel[index];
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.setTempSelectedDifficulty(e);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.h, vertical: 6.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(66),
                                color:
                                    controller.tempSelectedDifficulty.value == e
                                        ? Color(0xffF4612D)
                                        : Color(0xfff6f6f6)),
                            child: Center(
                                child: Text(
                              e,
                              style: TextStyle(
                                  color:
                                      controller.tempSelectedDifficulty.value ==
                                              e
                                          ? Colors.white
                                          : Color(0xff797979),
                                  fontSize: 16),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              height: 74.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xfff6f6f6),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                        spreadRadius: 4)
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                           controller.resetFilters();
                           Get.snackbar(
                            "Фільтри скинуто",
                            "",
                            snackStyle :  SnackStyle.GROUNDED,
                             isDismissible: true, // Можливість закрити змахом
                             messageText: null,
  dismissDirection: DismissDirection.horizontal,
                            snackPosition: SnackPosition.BOTTOM,
   // Повідомлення
  
);
                        },
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            overlayColor:
                                MaterialStatePropertyAll(Color(0xfff6f6f6)),
                            //textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xfff6f6f6))),
                        child: Text("Скинути",
                            style: TextStyle(
                                color: Color(0xffF4612D),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.saveFilters();
                          print(controller.selectedCategory );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Фільтри збережено"),
          ));
                        },
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            //textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xffF4612D))),
                        child: Text("Застосувати",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

List tagsCategory = ["Всі", "Сніданок", "Десерт", "Обід"];
List tagsDiet = [
  "Вегетаріанський",
  "Веганський",
  "Всі",
];
List tagsDLevel = [
  "Легкий",
  "Середній",
  "Просунутий",
];

class RangeSliderWithLabels extends StatelessWidget {
  //RangeValues _currentRangeValues = const RangeValues(20, 40);
  final SelectionController controller = Get.put(SelectionController());
  @override
  Widget build(BuildContext context) {
    // Визначаємо поділки для Slider
    const double min = 10;
    const double max = 50;
    const int divisions = 8;

    // Обчислюємо ширину для поділок

    List<Widget> labels = [];
    for (int i = 0; i <= divisions; i++) {
      labels.add(
        // Використовуємо Expanded для рівномірного розподілу простору
        Expanded(
          child: Text(
            '${(min + (max - min) / divisions * i).toInt()}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.orange[700],
              inactiveTrackColor: Color(0xfff6f6f6),
              trackHeight: 4.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Color(0xffF4612D),
              overlayColor: Colors.orange.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.orange[700],
              inactiveTickMarkColor: Colors.orange[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.orangeAccent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: RangeSlider(
              values: controller.tempRangeValues.value,
              min: min,
              max: max,
              divisions: divisions,
              labels: RangeLabels(
                controller.tempRangeValues.value.start.round().toString(),
                controller.tempRangeValues.value.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                controller.setTempSelectedSlider(values);
              },
            ),
          ),
        ),
        // Розміщуємо Row для тексту під поділками
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          child: Transform.translate(
            offset: const Offset(0, -8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: labels,
            ),
          ),
        ),
      ],
    );
  }
}

// class RatingController extends GetxController {
//   var selectedRating = 4.obs;

//   void setSelectedRating(int? value) {
//     // Змініть тип параметра на int?
//     if (value != null) {
//       // Перевірте на null перед зміною значення
//       selectedRating.value = value;
//     }
//   }
// }

class RatingFilterScreen extends StatelessWidget {
//  final RatingController controller = Get.put(RatingController());
  final SelectionController controller = Get.put(SelectionController());
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> ratingOptions = [
      {'rating': 5, 'label': '4.5 та більше'},
      {'rating': 4, 'label': '4.0 - 4.5'},
      {'rating': 3, 'label': '3.5 - 4.0'},
      {'rating': 2, 'label': '3.0 - 3.5'},
      {'rating': 1, 'label': '2.5 - 3.0'},
    ];

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: ratingOptions.length,
        itemBuilder: (context, index) {
          return Obx(() {
            return SizedBox(
              height: 36.h,
              child: RadioListTile<int>(
                dense: true,
                controlAffinity: ListTileControlAffinity.trailing,
                value: ratingOptions[index]['rating'],
                groupValue: controller.tempSelectedRating.toInt(),
                activeColor: Color(0xffF4612D),
                onChanged: (int? value) {
                  // Тип параметра змінено на int?
                  controller.setTempSelectedRating(value!);
                },
                title: Row(
                  children: <Widget>[
                    ...List.generate(ratingOptions[index]['rating'],
                        (index) => Icon(Icons.star, color: Colors.orange)),
                    SizedBox(width: 8),
                    Text(ratingOptions[index]['label']),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

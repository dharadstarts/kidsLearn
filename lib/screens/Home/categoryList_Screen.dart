import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_learn/screens/AppTextStyles.dart';
import 'package:kids_learn/screens/ColorHelper.dart';
import 'Data/category_list_data.dart';
import 'Widgets/category_card.dart';
import 'ViewModels/category_view_model.dart';
import 'package:provider/provider.dart';

class categoryListScreen extends StatefulWidget {
  final String title;
  const categoryListScreen({super.key, required this.title});

  @override
  State<categoryListScreen> createState() => _stateCategoryList();
}

class _stateCategoryList extends State<categoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
        child: Consumer<CategoryViewModel>(
            builder: (context, viewModel, _) {
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: ColorHelper.fromHex('#5d4434')),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  title: Text(
                    'Learn with Fun',
                    style: AppTextStyles.heading1.withSize(20)
                  ),
                  centerTitle: false,
                ),
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/images/categoryList/ic_categoryListBg.png'),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6,left: 16,right: 16),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double gridItemWidth = (constraints.maxWidth - 48) / 2;

                            return SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  GridView.builder(
                                    itemCount: categoriesList.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // ✅ 2 items per row
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 8,
                                      mainAxisExtent: 180, // height of each card
                                    ),
                                    itemBuilder: (context, index) {
                                      final category = categoriesList[index];
                                      return CategoryCard(
                                        index: index,
                                        width: gridItemWidth,
                                        arrCategoryList: category,
                                        onTap: (i) => viewModel.onSubCategoryTapped(context, i),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

              );
            },
        ),
    );
  }
}

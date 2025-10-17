import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                // backgroundColor: const Color(0xFFF7EFE8),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(CupertinoIcons.back, color: Color(0xFF6E4D3F)),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Color(0xFF6E4D3F),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  centerTitle: false,
                ),
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/categoryList/ic_categoryListBg.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16,bottom: 0,left: 16,right: 16),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double gridItemWidth = (constraints.maxWidth - 48) / 2;

                            return SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

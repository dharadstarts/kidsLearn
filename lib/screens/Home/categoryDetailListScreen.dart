import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Data/category_details_list_data.dart';
import 'Models/category_item_model.dart';
import 'Widgets/category_item_card.dart';
import 'categoryItemViewScreen.dart';
import 'ViewModels/category_view_model.dart';

class CategoryDetailListScreen extends StatefulWidget {
  final String title;
  const CategoryDetailListScreen({super.key,required this.title});

  @override
  State<CategoryDetailListScreen> createState() =>  _stateCatergoyDetailListScreen();
}

class _stateCatergoyDetailListScreen extends State<CategoryDetailListScreen> {

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> currentItems =
        categoryItemsMap[widget.title] ?? []; // ✅ Load items dynamically
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
                        'assets/images/categoryDetailList/ic_categoryItembg.png',
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
                                    itemCount: currentItems.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // ✅ 2 items per row
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 8,
                                      mainAxisExtent: 180, // height of each card
                                    ),
                                    itemBuilder: (context, index) {
                                      final CategoryItem category = currentItems[index];
                                      return CategoryItemCard(
                                        index: index,
                                        width: gridItemWidth,
                                        categoriesDetailList: category,
                                        onTap: (i) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => CategoryItemViewScreen(
                                                title: widget.title,
                                                items: currentItems,
                                                initialIndex: i,
                                              ),
                                            ),
                                          );
                                        },
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
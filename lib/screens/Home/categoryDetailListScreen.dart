import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../AppTextStyles.dart';
import '../ColorHelper.dart';
import 'Data/category_details_list_data.dart';
import 'Models/category_item_model.dart';
import 'Widgets/LetterCategoryCard.dart';
import 'LetterDrawingScreen.dart';
import 'Widgets/category_item_card.dart';
import 'categoryItemViewScreen.dart';
import 'ViewModels/category_view_model.dart';

class CategoryDetailListScreen extends StatefulWidget {
  final String title;
  final String screenType;
  final List<CategoryItem>? items;

  const CategoryDetailListScreen({
    super.key,
    required this.title,
    required this.screenType,
    this.items,
  });

  @override
  State<CategoryDetailListScreen> createState() =>
      _stateCatergoyDetailListScreen();
}

class _stateCatergoyDetailListScreen
    extends State<CategoryDetailListScreen> {
  void _navigateToItemScreen(
      int index, List<CategoryItem> currentItems) {
    // Don't navigate if it's the FILL Colors screen
    if (widget.screenType == "FILL Colors" && widget.title == "FILL Colors") {
      return;
    }
    if (widget.screenType == 'drawing' && widget.title == 'Shapes') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => LetterDrawingScreen(
            letter: currentItems[index].label.isNotEmpty
                ? currentItems[index].label[0].toUpperCase()
                : '',
            image: currentItems[index].imageAsset,
          ),
        ),
      );
    } else if (widget.screenType == "drawing") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => LetterDrawingScreen(
            letter: currentItems[index].label.isNotEmpty
                ? currentItems[index].label[0].toUpperCase()
                : '',
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryItemViewScreen(
            title: widget.title,
            items: currentItems,
            initialIndex: index,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> currentItems =
    widget.screenType == "drawing"
        ? (widget.items ?? [])
        : (categoryItemsMap[widget.title] ?? []);

    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
      child: Consumer<CategoryViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/ic_back.svg',
                  width: 35,
                  height: 35,
                ),
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  HapticFeedback.vibrate();// 👈 haptic feedback
                  Navigator.of(context).maybePop();
                },
              ),
              title: Text(
                widget.title,
                  style: AppTextStyles.heading1.withSize(20),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // Background
                    Positioned.fill(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/images/categoryDetailList/ic_categoryItembg.png'),
                      ),
                    ),

                    // Main content scroll
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              children: [
                                GridView.builder(
                                  itemCount: currentItems.length,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 14,
                                    mainAxisExtent: 180,
                                  ),
                                  itemBuilder: (context, index) {
                                    final category = currentItems[index];

                                    return widget.screenType == "drawing"
                                        ? LetterCategoryCard(
                                      index: index,
                                      size: (constraints.maxWidth - 48) / 2,
                                      categoriesDetailList: category,
                                      onTap: (i) {
                                        _navigateToItemScreen(
                                            i, currentItems);
                                      },
                                    )
                                        : CategoryItemCard(
                                      index: index,
                                      width: (constraints.maxWidth -
                                          48) /
                                          2,
                                      categoriesDetailList: category,
                                      onTap: (i) {
                                        _navigateToItemScreen(
                                            i, currentItems);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // -------------------------------------------------------
                    //  COMING SOON OVERLAY (ONLY FOR FILL COLORS)
                    // -------------------------------------------------------
                    if (widget.screenType == "drawing" &&
                        widget.title == "FILL Colors")
                      Positioned.fill(
                        child: Container(
                          color: Colors.white70.withOpacity(0.5), // Slightly more opaque
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/drawing/ic_comingsoon.png',
                                  fit: BoxFit.contain,
                                  width: constraints.maxWidth * 0.8,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
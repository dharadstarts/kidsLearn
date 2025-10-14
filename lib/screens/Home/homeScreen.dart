import 'package:flutter/material.dart';
import '../Home/Models/category_model.dart';
import '../Home//ViewModels/category_view_model.dart';
import 'categoryList_Screen.dart';
import '../Home//Widgets/category_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
      child: Consumer<CategoryViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            drawer: const Drawer(),
            body: Stack(
              children: [
                // ✅ Keep full-screen background
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Home/ic_home_bg.png',
                    fit: BoxFit.fill,
                  ),
                ),

                // ✅ Main scrollable content
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double boxWidth = (constraints.maxWidth - 48) / 2;

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- Header ---
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.menu,
                                        size: 28,
                                        color: Colors.brown,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "Good afternoon!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        fontSize: 22,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 60),

                              // --- Categories ---
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  spacing: 16,
                                  runSpacing: 20,
                                  children: List.generate(
                                    viewModel.categoryList.length,
                                        (index) {
                                      final category = viewModel
                                          .categoryList[index];
                                      return CategoryWidget(
                                        index: index,
                                        category: category,
                                        width: boxWidth,
                                        onTap: (i) => viewModel.onCategoryTapped(context, i),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // --- Spelling Banner ---
                              buildBanner(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFCA2631),
                                      Color(0xFFd43d48),
                                      Color(0xFFe85567),
                                      Color(0xFFfc6d89),
                                      Color(0xFFff7c99),
                                      Color(0xFFfe85a1),
                                    ]
                                ),
                                title: "Spelling",
                                subtitle: "Step-By-Step Spelling Adventure",
                                leadingImagePath: 'assets/images/Home/ic_spelling.png',
                              ),

                              const SizedBox(height: 10),

                              // --- Quiz Banner ---
                              buildBanner(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF44631D),
                                      Color(0xFF497c04),
                                      Color(0xFF85a424),
                                      Color(0xFFa8b73d),
                                      Color(0xFFc0c44d),
                                      Color(0xFFd6d157)
                                    ]),
                                title: "Quiz",
                                subtitle: "Fun Quizzes For Young Learners",
                                trailingImagePath: 'assets/images/Home/ic_quiz.png',
                              ),

                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- Banner UI ---
  Widget buildBanner({
    required Gradient gradient,
    required String title,
    required String subtitle,
    String? leadingImagePath, // image on left
    String? trailingImagePath, // image on right
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          // --- Leading Image ---
          if (leadingImagePath != null)
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Image.asset(
                leadingImagePath,
                height: 55,
                fit: BoxFit.contain,
              ),
            ),

          // --- Text Column ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Column(
                crossAxisAlignment: leadingImagePath != null
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign:  TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      color: leadingImagePath != null ? Color(0xFF5e3001) : Colors.white ,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    textAlign: leadingImagePath != null ? TextAlign.right : TextAlign.left,
                    style:  TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: leadingImagePath != null ? Color(0xFF5e3001) : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Trailing Image ---
          if (trailingImagePath != null)
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Image.asset(
                trailingImagePath,
                height: 55,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }
}


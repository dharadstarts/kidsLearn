import 'package:flutter/material.dart';
import 'package:kids_learn/screens/AppTextStyles.dart';
import 'package:kids_learn/screens/Home/QuizScreen.dart';
import '../Home/ViewModels/category_view_model.dart';
import '../Home/Widgets/category_widget.dart';
import 'package:provider/provider.dart';
import 'SpellingsScreen.dart';
import '../SoundManager/SoundProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSoundOn = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final soundProvider = Provider.of<SoundProvider>(context, listen: false);
      if (soundProvider.isSoundOn && !soundProvider.isBackgroundPlaying) {
        soundProvider.playBackgroundMusic();
      }
    });
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning!";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final soundProvider = Provider.of<SoundProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
      child: Consumer<CategoryViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            drawer: const Drawer(),
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Home/ic_home_bg.png',
                    fit: BoxFit.fill,
                  ),
                ),
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
                              // --- Top Row with Greeting & Sound Button ---
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 22.0),
                                    child: Text(
                                      getGreetingMessage(),
                                      style: AppTextStyles.heading1,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      soundProvider.isSoundOn // Use soundProvider's state
                                          ? 'assets/images/Home/ic_sound.png'
                                          : 'assets/images/Home/ic_sound_off.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    onPressed: () {
                                      soundProvider.toggleSound(); // This will now work
                                    },
                                  ),

                                ],
                              ),

                              const SizedBox(height: 20),

                              // --- Categories ---
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  spacing: 16,
                                  runSpacing: 20,
                                  children: List.generate(
                                    viewModel.categoryList.length,
                                        (index) {
                                      final category = viewModel.categoryList[index];
                                      return CategoryWidget(
                                        index: index,
                                        category: category,
                                        width: boxWidth,
                                        onTap: (i) =>
                                            viewModel.onCategoryTapped(context, i),
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
                                  ],
                                ),
                                title: "Fun With Spellings",
                                subtitle: "Simple spelling practice for smart kids!",
                                leadingImagePath:
                                'assets/images/Home/ic_spelling.png',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SpellingsScreen()),
                                  );
                                },
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
                                  ],
                                ),
                                title: "Fun Brain Quiz",
                                subtitle: "Catch the clues and boost your brain power!",
                                trailingImagePath:
                                'assets/images/Home/ic_quiz.png',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => QuizScreen()),
                                  );
                                },
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

  // --- UI Banner---
  Widget buildBanner({
    required Gradient gradient,
    required String title,
    required String subtitle,
    String? leadingImagePath,
    String? trailingImagePath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            if (leadingImagePath != null)
              Image.asset(
                leadingImagePath,
                height: 55,
                fit: BoxFit.contain,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: leadingImagePath != null
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: leadingImagePath != null
                          ? AppTextStyles.heading1.withColor(Colors.white)
                          .withSize(17)
                          .withWeight(FontWeight.bold)
                          : AppTextStyles.heading1
                          .withColor(Colors.white)
                          .withSize(17)
                          .withWeight(FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      textAlign:
                      leadingImagePath != null ? TextAlign.right : TextAlign.left,
                      style: leadingImagePath != null
                          ? AppTextStyles.custom(fontSize: 13).withWeight(FontWeight.w500).withColor(Colors.white)
                          : AppTextStyles.custom(fontSize: 13).withWeight(FontWeight.w500)
                          .withColor(Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            if (trailingImagePath != null)
              Image.asset(
                trailingImagePath,
                height: 55,
                fit: BoxFit.contain,
              ),
          ],
        ),
      ),
    );
  }
}

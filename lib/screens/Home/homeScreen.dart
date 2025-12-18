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

  // -------- RESPONSIVE HELPERS --------
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  double scale(BuildContext context, double size) =>
      isTablet(context) ? size * 1.2 : size;
  // -----------------------------------

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

                // ---------- FULL SCREEN BACKGROUND ----------
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Home/ic_home_bg.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // ---------- CONTENT ----------
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {

                      final double boxWidth = isTablet(context)
                          ? (constraints.maxWidth - scale(context, 80)) / 3
                          : (constraints.maxWidth - scale(context, 48)) / 2;

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),

                        // 🔑 THIS IS THE KEY FIX
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // ---------- TOP BAR ----------
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scale(context, 22),
                                  vertical: scale(context, 10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getGreetingMessage(),
                                      style: AppTextStyles.heading1
                                          .withSize(scale(context, 22)),
                                    ),
                                    IconButton(
                                      icon: Image.asset(
                                        soundProvider.isSoundOn
                                            ? 'assets/images/Home/ic_sound.png'
                                            : 'assets/images/Home/ic_sound_off.png',
                                        width: scale(context, 40),
                                        height: scale(context, 40),
                                      ),
                                      onPressed: soundProvider.toggleSound,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: scale(context, 16)),

                              // ---------- CATEGORIES ----------
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scale(context, 16),
                                ),
                                child: Wrap(
                                  spacing: scale(context, 16),
                                  runSpacing: scale(context, 20),
                                  children: List.generate(
                                    viewModel.categoryList.length,
                                        (index) {
                                      return CategoryWidget(
                                        index: index,
                                        category:
                                        viewModel.categoryList[index],
                                        width: boxWidth,
                                        onTap: (i) => viewModel
                                            .onCategoryTapped(context, i),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(height: scale(context, 22)),

                              // ---------- SPELLING BANNER ----------
                              buildBanner(
                                context: context,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFCA2631),
                                    Color(0xFFd43d48),
                                    Color(0xFFe85567),
                                    Color(0xFFfc6d89),
                                  ],
                                ),
                                title: "Fun With Spellings",
                                subtitle:
                                "Simple spelling practice for smart kids!",
                                leadingImagePath:
                                'assets/images/Home/ic_spelling.png',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SpellingsScreen(),
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: scale(context, 14)),

                              // ---------- QUIZ BANNER ----------
                              buildBanner(
                                context: context,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF44631D),
                                    Color(0xFF497c04),
                                    Color(0xFF85a424),
                                    Color(0xFFa8b73d),
                                  ],
                                ),
                                title: "Fun Brain Quiz",
                                subtitle:
                                "Catch the clues and boost your brain power!",
                                trailingImagePath:
                                'assets/images/Home/ic_quiz.png',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                      const QuizScreen(),
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: scale(context, 24)),
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

  // ---------- BANNER ----------
  Widget buildBanner({
    required BuildContext context,
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
        margin: EdgeInsets.symmetric(
          horizontal: scale(context, 22),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: scale(context, 18),
          vertical: scale(context, 12),
        ),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(scale(context, 40)),
        ),
        child: Row(
          children: [
            if (leadingImagePath != null)
              Image.asset(
                leadingImagePath,
                height: scale(context, 55),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: scale(context, 10),
                ),
                child: Column(
                  crossAxisAlignment: leadingImagePath != null
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading1
                          .withColor(Colors.white)
                          .withSize(scale(context, 18))
                          .withWeight(FontWeight.bold),
                    ),
                    SizedBox(height: scale(context, 4)),
                    Text(
                      subtitle,
                      style: AppTextStyles.custom(
                        fontSize: scale(context, 13),
                      ).withColor(Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            if (trailingImagePath != null)
              Image.asset(
                trailingImagePath,
                height: scale(context, 55),
              ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'Data/sleep_data.dart';

class BabySleepScreen extends StatefulWidget {
  const BabySleepScreen({super.key});

  @override
  State<BabySleepScreen> createState() => _BabySleepScreenState();
}

class _BabySleepScreenState extends State<BabySleepScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  SleepItemModel? currentlyPlayingItem;
  PlayerState playerState = PlayerState.stopped;
  bool isPlaying = false;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio(SleepItemModel item) async {
    try {
      // Stop current audio if playing
      if (currentlyPlayingItem != null && currentlyPlayingItem != item) {
        await audioPlayer.stop();
      }

      // Update state
      setState(() {
        currentlyPlayingItem = item;
        isPlaying = true;
        playerState = PlayerState.playing;
      });

      // Play the audio
      await audioPlayer.play(AssetSource('audios/${item.audioFile}'));

      // Listen for completion
      audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          isPlaying = false;
          playerState = PlayerState.stopped;
        });
      });

    } catch (e) {
      print('Error playing audio: $e');
      setState(() {
        isPlaying = false;
        playerState = PlayerState.stopped;
      });
    }
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      currentlyPlayingItem = null;
      isPlaying = false;
      playerState = PlayerState.stopped;
    });
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
      playerState = PlayerState.paused;
    });
  }

  Future<void> resumeAudio() async {
    await audioPlayer.resume();
    setState(() {
      isPlaying = true;
      playerState = PlayerState.playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sleep/ic_sleep_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // ---------- HEADER ----------
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.brown),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Text(
                        'Baby Sleep',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown,
                        ),
                      ),
                      const Spacer(),

                    ],
                  ),

                  const SizedBox(height: 10),

                  // ---------- CATEGORY SECTIONS ----------
                  ...categories.map(
                        (category) => CategorySection(
                      category: category,
                      currentlyPlayingItem: currentlyPlayingItem,
                      isPlaying: isPlaying,
                      onItemTap: (item) {
                        if (currentlyPlayingItem == item && isPlaying) {
                          pauseAudio();
                        } else if (currentlyPlayingItem == item && !isPlaying) {
                          resumeAudio();
                        } else {
                          playAudio(item);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------
// CATEGORY SECTION WIDGET
// ------------------------------------------------------
class CategorySection extends StatelessWidget {
  final SleepCategory category;
  final SleepItemModel? currentlyPlayingItem;
  final bool isPlaying;
  final Function(SleepItemModel) onItemTap;

  const CategorySection({
    super.key,
    required this.category,
    required this.currentlyPlayingItem,
    required this.isPlaying,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 10),

        GridView.builder(
          itemCount: category.items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 22,
            crossAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final item = category.items[index];
            final isCurrentlyPlaying = currentlyPlayingItem == item && isPlaying;

            return SleepItemWidget(
              model: item,
              isPlaying: isCurrentlyPlaying,
              onTap: () => onItemTap(item),
            );
          },
        ),

        const SizedBox(height: 25),
      ],
    );
  }
}

// ------------------------------------------------------
// SLEEP ITEM WIDGET
// ------------------------------------------------------
class SleepItemWidget extends StatelessWidget {
  final SleepItemModel model;
  final bool isPlaying;
  final VoidCallback onTap;

  const SleepItemWidget({
    super.key,
    required this.model,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(model.bgImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              // Play/Pause Overlay
              if (isPlaying)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: AnimatedWaveform(),
                  ),
                ),

              // // Mini Waveform at top when playing
              // if (isPlaying)
              //   Positioned(
              //     top: 45,
              //     child: Container(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: List.generate(7, (index) {
              //           return Container(
              //             width: 3,
              //             height: 5 + (index % 3) * 8.5,
              //             margin: const EdgeInsets.symmetric(horizontal: 2),
              //             decoration: BoxDecoration(
              //               color: Colors.brown,
              //               borderRadius: BorderRadius.circular(1),
              //             ),
              //           );
              //         }),
              //       ),
              //     ),
              //   ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.brown,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------
// ANIMATED WAVEFORM WIDGET
// ------------------------------------------------------
class AnimatedWaveform extends StatefulWidget {
  const AnimatedWaveform({super.key});

  @override
  State<AnimatedWaveform> createState() => _AnimatedWaveformState();
}

class _AnimatedWaveformState extends State<AnimatedWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 80,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(7, (index) {
              // Create a wavy pattern with sine wave
              final delay = index * 0.2;
              final animatedValue = (_animation.value + delay) % 1.0;

              // Use sine wave for smooth animation
              final waveHeight = 5 + (sin(animatedValue * 2 * pi) + 1) * 10;

              return Container(
                width: 3,
                height: waveHeight,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
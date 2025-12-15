import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ic_quiz.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ---------- HEADER ----------
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/ic_back.svg',
                        width: 35,
                        height: 35,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Quiz Challenge',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Balance the back button
                  ],
                ),
              ),

              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         // ---------- QUESTION CARD ----------
              //         Container(
              //           margin: const EdgeInsets.all(20),
              //           padding: const EdgeInsets.all(25),
              //           decoration: BoxDecoration(
              //             color: Colors.white.withOpacity(0.95),
              //             borderRadius: BorderRadius.circular(25),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.black.withOpacity(0.2),
              //                 blurRadius: 20,
              //                 spreadRadius: 2,
              //               ),
              //             ],
              //           ),
              //           child: Column(
              //             children: [
              //               // Question
              //               const Text(
              //                 'What is Stay Tuned?',
              //                 style: TextStyle(
              //                   fontSize: 26,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.blue,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //
              //               const SizedBox(height: 30),
              //
              //               // Full-screen Image
              //               Container(
              //                 height: 250,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(15),
              //                   image: const DecorationImage(
              //                     image: AssetImage('assets/images/fruits/apple.png'),
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //               ),
              //
              //               const SizedBox(height: 30),
              //
              //               // Options
              //               Column(
              //                 children: [
              //                   _buildOption('A. Grape', false, false),
              //                   const SizedBox(height: 12),
              //                   _buildOption('B. Cherry', false, false),
              //                   const SizedBox(height: 12),
              //                   _buildOption('C. Apple', true, true), // Correct answer
              //                   const SizedBox(height: 12),
              //                   _buildOption('D. Banana', false, false),
              //                 ],
              //               ),
              //
              //               const SizedBox(height: 30),
              //
              //               // Progress
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     '1/10',
              //                     style: TextStyle(
              //                       fontSize: 18,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.grey.shade700,
              //                     ),
              //                   ),
              //                   Container(
              //                     width: 200,
              //                     height: 8,
              //                     decoration: BoxDecoration(
              //                       color: Colors.grey.shade300,
              //                       borderRadius: BorderRadius.circular(4),
              //                     ),
              //                     child: FractionallySizedBox(
              //                       alignment: Alignment.centerLeft,
              //                       widthFactor: 0.1,
              //                       child: Container(
              //                         decoration: BoxDecoration(
              //                           color: Colors.green,
              //                           borderRadius: BorderRadius.circular(4),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //
              //         // ---------- ACTION BUTTONS ----------
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: ElevatedButton(
              //                   onPressed: () {},
              //                   style: ElevatedButton.styleFrom(
              //                     backgroundColor: Colors.red.shade400,
              //                     foregroundColor: Colors.white,
              //                     padding: const EdgeInsets.symmetric(vertical: 16),
              //                     shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(15),
              //                     ),
              //                     elevation: 5,
              //                   ),
              //                   child: const Text(
              //                     'Wrong',
              //                     style: TextStyle(
              //                       fontSize: 18,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(width: 15),
              //               Expanded(
              //                 child: ElevatedButton(
              //                   onPressed: () {},
              //                   style: ElevatedButton.styleFrom(
              //                     backgroundColor: Colors.green.shade500,
              //                     foregroundColor: Colors.white,
              //                     padding: const EdgeInsets.symmetric(vertical: 16),
              //                     shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(15),
              //                     ),
              //                     elevation: 5,
              //                   ),
              //                   child: const Text(
              //                     'Correct',
              //                     style: TextStyle(
              //                       fontSize: 18,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String text, bool isSelected, bool isCorrect) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? (isCorrect ? Colors.green.shade100 : Colors.red.shade100)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? (isCorrect ? Colors.green : Colors.red)
              : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? (isCorrect ? Colors.green.shade800 : Colors.red.shade800)
                    : Colors.black,
              ),
            ),
          ),
          if (isSelected)
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? Colors.green : Colors.red,
              size: 24,
            ),
        ],
      ),
    );
  }
}
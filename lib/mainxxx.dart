// import 'package:flutter/material.dart';

// void main() {
//   runApp(const SnookerScoreboardApp());
// }

// class SnookerScoreboardApp extends StatelessWidget {
//   const SnookerScoreboardApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Snooker Scoreboard',
//       theme: ThemeData.dark(),
//       home: const ScoreboardScreen(),
//     );
//   }
// }

// class ScoreboardScreen extends StatefulWidget {
//   const ScoreboardScreen({Key? key}) : super(key: key);

//   @override
//   State<ScoreboardScreen> createState() => _ScoreboardScreenState();
// }

// class _ScoreboardScreenState extends State<ScoreboardScreen> {
//   int player1Score = 18;
//   int player2Score = 22;
//   int currentBreak = 0;
//   int highestBreak = 17;
//   bool isPlayer1Turn = true;

//   @override
//   Widget build(BuildContext context) {
//     // Get screen size
//     final size = MediaQuery.of(context).size;
//     final isLandscape = size.width > size.height;
//     final smallScreen = size.width < 600;

//     // Calculate responsive sizes
//     final buttonSize = size.width * (smallScreen ? 0.08 : 0.06);
//     final fontSize = size.width * (smallScreen ? 0.04 : 0.03);
//     final scoreFontSize = size.width * (smallScreen ? 0.05 : 0.04);
//     final headerHeight = size.height * 0.1;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return Column(
//               children: [
//                 // Top score bar
//                 Container(
//                   height: headerHeight,
//                   color: Colors.black,
//                   child: Row(
//                     children: [
//                       // Play arrow indicator
//                       Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                         child: Icon(Icons.play_arrow,
//                             color: Colors.yellow, size: fontSize * 1.2),
//                       ),
//                       // Player 1
//                       Expanded(
//                         child: Row(
//                           children: [
//                             Text('Player 1 ',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: fontSize)),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: size.width * 0.02,
//                                   vertical: size.height * 0.01),
//                               color: Colors.yellow,
//                               child: Text('18',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: scoreFontSize,
//                                       fontWeight: FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Frame score
//                       Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: size.width * 0.03),
//                         child: Text('0 (1) 0',
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: fontSize)),
//                       ),
//                       // Player 2
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: size.width * 0.02,
//                                   vertical: size.height * 0.01),
//                               color: Colors.yellow,
//                               child: Text('22',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: scoreFontSize,
//                                       fontWeight: FontWeight.bold)),
//                             ),
//                             Text(' Player 2',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: fontSize)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Stats display
//                 Container(
//                   color: const Color(0xFF1A1A1A),
//                   padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//                   child: Column(
//                     children: [
//                       ResponsiveStatsRow(
//                         leftText: '17',
//                         centerText: 'Highest Break',
//                         rightText: '16',
//                         fontSize: fontSize * 0.8,
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       ResponsiveStatsRow(
//                         leftText: '18',
//                         centerText: 'Total Points',
//                         rightText: '22',
//                         fontSize: fontSize * 0.8,
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       Wrap(
//                         alignment: WrapAlignment.center,
//                         spacing: size.width * 0.05,
//                         children: [
//                           Text('Current Break: 0',
//                               style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: fontSize * 0.8)),
//                           Text('Current Highest Break: 17',
//                               style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: fontSize * 0.8)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Spacer(),

//                 // Bottom buttons
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: size.height * 0.02,
//                       horizontal: size.width * 0.02),
//                   child: Column(
//                     children: [
//                       // Control buttons
//                       ResponsiveButtonRow(
//                         buttons: [
//                           ButtonData(Icons.refresh, Colors.lightBlue),
//                           ButtonData(Icons.play_arrow, Colors.green),
//                           ButtonData(Icons.build, Colors.grey),
//                           ButtonData(Icons.description, Colors.orange),
//                         ],
//                         buttonSize: buttonSize,
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       // Ball buttons
//                       ResponsiveBallRow(
//                         balls: [
//                           BallData(1, Colors.red),
//                           BallData(2, Colors.yellow),
//                           BallData(3, Colors.green),
//                           BallData(4, Colors.brown),
//                           BallData(5, Colors.blue),
//                           BallData(6, Colors.pink),
//                           BallData(7, Colors.black),
//                           BallData(0, Colors.white),
//                         ],
//                         buttonSize: buttonSize,
//                         fontSize: fontSize * 0.8,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.02),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // Responsive Components
// class ResponsiveStatsRow extends StatelessWidget {
//   final String leftText;
//   final String centerText;
//   final String rightText;
//   final double fontSize;

//   const ResponsiveStatsRow({
//     Key? key,
//     required this.leftText,
//     required this.centerText,
//     required this.rightText,
//     required this.fontSize,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Text(leftText,
//             style: TextStyle(color: Colors.white70, fontSize: fontSize)),
//         Text(centerText,
//             style: TextStyle(color: Colors.white70, fontSize: fontSize)),
//         Text(rightText,
//             style: TextStyle(color: Colors.white70, fontSize: fontSize)),
//       ],
//     );
//   }
// }

// class ResponsiveButtonRow extends StatelessWidget {
//   final List<ButtonData> buttons;
//   final double buttonSize;

//   const ResponsiveButtonRow({
//     Key? key,
//     required this.buttons,
//     required this.buttonSize,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: buttons
//           .map((button) => ResponsiveButton(
//                 icon: button.icon,
//                 color: button.color,
//                 size: buttonSize,
//               ))
//           .toList(),
//     );
//   }
// }

// class ResponsiveBallRow extends StatelessWidget {
//   final List<BallData> balls;
//   final double buttonSize;
//   final double fontSize;

//   const ResponsiveBallRow({
//     Key? key,
//     required this.balls,
//     required this.buttonSize,
//     required this.fontSize,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       alignment: WrapAlignment.spaceEvenly,
//       spacing: buttonSize * 0.2,
//       runSpacing: buttonSize * 0.2,
//       children: balls
//           .map((ball) => ResponsiveBall(
//                 value: ball.value,
//                 color: ball.color,
//                 size: buttonSize,
//                 fontSize: fontSize,
//               ))
//           .toList(),
//     );
//   }
// }

// class ResponsiveButton extends StatelessWidget {
//   final IconData icon;
//   final Color color;
//   final double size;

//   const ResponsiveButton({
//     Key? key,
//     required this.icon,
//     required this.color,
//     required this.size,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Icon(icon, color: Colors.white, size: size * 0.6),
//     );
//   }
// }

// class ResponsiveBall extends StatelessWidget {
//   final int value;
//   final Color color;
//   final double size;
//   final double fontSize;

//   const ResponsiveBall({
//     Key? key,
//     required this.value,
//     required this.color,
//     required this.size,
//     required this.fontSize,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Center(
//         child: value > 0
//             ? Text(
//                 value.toString(),
//                 style: TextStyle(
//                   color: (color == Colors.yellow || color == Colors.white)
//                       ? Colors.black
//                       : Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: fontSize,
//                 ),
//               )
//             : null,
//       ),
//     );
//   }
// }

// // Data Classes
// class ButtonData {
//   final IconData icon;
//   final Color color;

//   ButtonData(this.icon, this.color);
// }

// class BallData {
//   final int value;
//   final Color color;

//   BallData(this.value, this.color);
// }

import 'package:flutter/material.dart';

void main() {
  runApp(const SnookerScoreboardApp());
}

class SnookerScoreboardApp extends StatelessWidget {
  const SnookerScoreboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snooker Scoreboard',
      theme: ThemeData.dark(),
      home: const ScoreboardScreen(),
    );
  }
}

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({Key? key}) : super(key: key);

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  // Game state
  int player1Score = 0;
  int player2Score = 0;
  int currentBreak = 0;
  int highestBreak = 0;
  bool isPlayer1Turn = true;
  bool isGameStarted = false;
  int remainingReds = 15;
  int frameNumber = 1;

  // Game functions
  void startGame() {
    setState(() {
      isGameStarted = true;
    });
    showMessage('เกมเริ่มต้นแล้ว!');
  }

  void resetGame() {
    setState(() {
      player1Score = 0;
      player2Score = 0;
      currentBreak = 0;
      highestBreak = 0;
      isPlayer1Turn = true;
      isGameStarted = false;
      remainingReds = 15;
    });
    showMessage('รีเซ็ตเกมแล้ว');
  }

  void switchPlayer() {
    if (!isGameStarted) {
      showMessage('กรุณากดปุ่ม Start เพื่อเริ่มเกม');
      return;
    }
    setState(() {
      isPlayer1Turn = !isPlayer1Turn;
      currentBreak = 0;
    });
    showMessage(
        'เปลี่ยนผู้เล่นเป็น ' + (isPlayer1Turn ? 'Player 1' : 'Player 2'));
  }

  void addPoints(int points, {bool isFoul = false}) {
    if (!isGameStarted) {
      showMessage('กรุณากดปุ่ม Start เพื่อเริ่มเกม');
      return;
    }

    setState(() {
      if (isFoul) {
        if (isPlayer1Turn) {
          player2Score += points;
        } else {
          player1Score += points;
        }
      } else {
        if (isPlayer1Turn) {
          player1Score += points;
        } else {
          player2Score += points;
        }
        currentBreak += points;

        if (currentBreak > highestBreak) {
          highestBreak = currentBreak;
        }

        // ถ้าเป็นลูกแดง ลดจำนวนลูกแดงที่เหลือ
        if (points == 1 && remainingReds > 0) {
          remainingReds--;
        }
      }
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallScreen = size.width < 600;
    final buttonSize = size.width * (smallScreen ? 0.08 : 0.06);
    final fontSize = size.width * (smallScreen ? 0.04 : 0.03);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Score display
            buildScoreBoard(fontSize),

            // Stats display
            buildStatsDisplay(fontSize),

            const Spacer(),

            // Control buttons
            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Column(
                children: [
                  // Main control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildControlButton(Icons.refresh, Colors.lightBlue,
                          buttonSize, resetGame, 'Reset'),
                      buildControlButton(
                          isGameStarted ? Icons.pause : Icons.play_arrow,
                          Colors.green,
                          buttonSize,
                          startGame,
                          'Start'),
                      buildControlButton(Icons.swap_horiz, Colors.grey,
                          buttonSize, switchPlayer, 'Switch'),
                      buildControlButton(Icons.article, Colors.orange,
                          buttonSize, () {}, 'Score'),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Ball buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: buttonSize * 0.3,
                    runSpacing: buttonSize * 0.3,
                    children: [
                      buildBallButton(1, Colors.red, buttonSize, fontSize),
                      buildBallButton(2, Colors.yellow, buttonSize, fontSize),
                      buildBallButton(3, Colors.green, buttonSize, fontSize),
                      buildBallButton(4, Colors.brown, buttonSize, fontSize),
                      buildBallButton(5, Colors.blue, buttonSize, fontSize),
                      buildBallButton(6, Colors.pink, buttonSize, fontSize),
                      buildBallButton(7, Colors.black, buttonSize, fontSize),
                      // Foul button
                      buildBallButton(4, Colors.white, buttonSize, fontSize,
                          isFoul: true),
                      // Confirm button
                      buildControlButton(Icons.check, Colors.green, buttonSize,
                          switchPlayer, 'Confirm'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget buildScoreBoard(double fontSize) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Row(
        children: [
          Icon(Icons.play_arrow, color: Colors.yellow, size: fontSize * 1.2),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildPlayerScore(
                    'Player 1', player1Score, isPlayer1Turn, fontSize),
                Text('0 ($frameNumber) 0',
                    style: TextStyle(color: Colors.white, fontSize: fontSize)),
                buildPlayerScore(
                    'Player 2', player2Score, !isPlayer1Turn, fontSize),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlayerScore(
      String player, int score, bool isActive, double fontSize) {
    return Row(
      children: [
        Text(player, style: TextStyle(color: Colors.white, fontSize: fontSize)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          color: isActive ? Colors.yellow : Colors.grey[800],
          child: Text(
            score.toString(),
            style: TextStyle(
              color: isActive ? Colors.black : Colors.white,
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStatsDisplay(double fontSize) {
    return Container(
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          buildStatsRow(highestBreak.toString(), 'Highest Break',
              highestBreak.toString(), fontSize),
          const SizedBox(height: 8),
          buildStatsRow(player1Score.toString(), 'Total Points',
              player2Score.toString(), fontSize),
          const SizedBox(height: 8),
          Text(
            'Current Break: $currentBreak    Current Highest Break: $highestBreak',
            style: TextStyle(color: Colors.white70, fontSize: fontSize * 0.8),
          ),
        ],
      ),
    );
  }

  Widget buildStatsRow(
      String left, String center, String right, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(left,
            style: TextStyle(color: Colors.white70, fontSize: fontSize * 0.8)),
        Text(center,
            style: TextStyle(color: Colors.white70, fontSize: fontSize * 0.8)),
        Text(right,
            style: TextStyle(color: Colors.white70, fontSize: fontSize * 0.8)),
      ],
    );
  }

  Widget buildControlButton(IconData icon, Color color, double size,
      VoidCallback onPressed, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: size * 0.6),
        ),
      ),
    );
  }

  Widget buildBallButton(int value, Color color, double size, double fontSize,
      {bool isFoul = false}) {
    return GestureDetector(
      onTap: () => addPoints(value, isFoul: isFoul),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: value > 0
              ? Text(
                  value.toString(),
                  style: TextStyle(
                    color: (color == Colors.yellow || color == Colors.white)
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize * 0.8,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

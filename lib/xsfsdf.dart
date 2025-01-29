import 'package:flutter/material.dart';
import 'dart:async';

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
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(
          child: SnookerScoreboard(),
        ),
      ),
    );
  }
}

class SnookerScoreboard extends StatefulWidget {
  const SnookerScoreboard({Key? key}) : super(key: key);

  @override
  _SnookerScoreboardState createState() => _SnookerScoreboardState();
}

class _SnookerScoreboardState extends State<SnookerScoreboard> {
  int player1Score = 0;
  int player2Score = 0;
  int player1Frames = 0;
  int player2Frames = 0;
  int player1Break = 0;
  int player2Break = 0;
  int currentPlayer = 1;
  bool isTimerRunning = false;
  int secondsElapsed = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
      });
    });
    setState(() {
      isTimerRunning = true;
    });
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void addPoints(int points) {
    setState(() {
      if (currentPlayer == 1) {
        player1Score += points;
        player1Break += points;
      } else {
        player2Score += points;
        player2Break += points;
      }
    });
  }

  void switchPlayer() {
    setState(() {
      if (currentPlayer == 1) {
        player1Break = 0;
        currentPlayer = 2;
      } else {
        player2Break = 0;
        currentPlayer = 1;
      }
    });
  }

  void endFrame() {
    setState(() {
      if (player1Score > player2Score) {
        player1Frames++;
      } else if (player2Score > player1Score) {
        player2Frames++;
      }
      player1Score = 0;
      player2Score = 0;
      player1Break = 0;
      player2Break = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fontSize = constraints.maxWidth * 0.02;
        final ballSize = constraints.maxHeight * 0.08;

        return Container(
          color: Colors.black,
          child: Row(
            children: [
              // Left section (Player 1)
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPlayer = 1;
                    });
                  },
                  child: _buildPlayerSection(
                    'THA',
                    'YUTTAPOP',
                    'PAKPOJ',
                    player1Score,
                    player1Break,
                    fontSize,
                    currentPlayer == 1,
                  ),
                ),
              ),
              // Center section (Timer and Controls)
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: _buildCenterInfo(fontSize),
                    ),
                    _buildSharedControls(fontSize, ballSize),
                  ],
                ),
              ),
              // Right section (Player 2)
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPlayer = 2;
                    });
                  },
                  child: _buildPlayerSection(
                    'THA',
                    'VORAWIT',
                    'THONGWEANG',
                    player2Score,
                    player2Break,
                    fontSize,
                    currentPlayer == 2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayerSection(
    String country,
    String firstName,
    String lastName,
    int score,
    int breakScore,
    double fontSize,
    bool isCurrentPlayer,
  ) {
    return Container(
      margin: EdgeInsets.all(fontSize),
      padding: EdgeInsets.all(fontSize),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border.all(
          color: isCurrentPlayer ? Colors.yellow : Colors.grey[800]!,
          width: isCurrentPlayer ? 3 : 1,
        ),
        borderRadius: BorderRadius.circular(fontSize),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                country,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: fontSize),
              _buildThaiFlag(fontSize),
            ],
          ),
          SizedBox(height: fontSize),
          Text(
            firstName,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize * 1.4,
            ),
          ),
          Text(
            lastName,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize * 1.4,
            ),
          ),
          SizedBox(height: fontSize * 2),
          Text(
            score.toString(),
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: fontSize * 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: fontSize),
          Text(
            'Break: $breakScore',
            style: TextStyle(
              color: Colors.orange,
              fontSize: fontSize * 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterInfo(double fontSize) {
    return Container(
      padding: EdgeInsets.all(fontSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatTime(secondsElapsed),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: fontSize * 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                iconSize: fontSize * 2,
                icon: Icon(
                  isTimerRunning ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: isTimerRunning ? pauseTimer : startTimer,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: fontSize * 2),
          _buildInfoRow('FRAMES', player1Frames, player2Frames, fontSize * 2),
          SizedBox(height: fontSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: switchPlayer,
                icon: Icon(Icons.swap_horiz, size: fontSize * 1.5),
                label:
                    Text('Switch', style: TextStyle(fontSize: fontSize * 1.2)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(
                    horizontal: fontSize * 1,
                    vertical: fontSize,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: endFrame,
                icon: Icon(Icons.done_all, size: fontSize * 1.5),
                label:
                    Text('End Frame', style: TextStyle(fontSize: fontSize * 1)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  padding: EdgeInsets.symmetric(
                    horizontal: fontSize * 1,
                    vertical: fontSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, int value1, int value2, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: fontSize * 0.5),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.yellow,
              fontSize: fontSize * 0.8,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                value1.toString(),
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value2.toString(),
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSharedControls(double fontSize, double ballSize) {
    List<Map<String, dynamic>> balls = [
      {'label': 'RED', 'points': 1, 'color': Colors.red},
      {'label': 'YELLOW', 'points': 2, 'color': Colors.yellow},
      {'label': 'GREEN', 'points': 3, 'color': Colors.green},
      {'label': 'BROWN', 'points': 4, 'color': Colors.brown},
      {'label': 'BLUE', 'points': 5, 'color': Colors.blue},
      {'label': 'PINK', 'points': 6, 'color': Colors.pink},
      {'label': 'BLACK', 'points': 7, 'color': Colors.black},
    ];

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: balls.length,
        itemBuilder: (context, index) {
          final ball = balls[index];
          return GestureDetector(
            onTap: () {
              addPoints(ball['points']);
            },
            child: Container(
              margin: EdgeInsets.all(fontSize * 0.2),
              width: ballSize,
              height: ballSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ball['color'],
              ),
              child: Center(
                child: Text(
                  ball['label'],
                  style: TextStyle(
                    color: ball['color'] == Colors.yellow ||
                            ball['color'] == Colors.white
                        ? Colors.black
                        : Colors.white,
                    fontSize: fontSize * 0.6,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildThaiFlag(double fontSize) {
    return Container(
      width: fontSize * 1.2,
      height: fontSize * 0.8,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Container(color: Colors.blue, height: fontSize * 0.27),
          Container(color: Colors.white, height: fontSize * 0.27),
          Container(color: Colors.red, height: fontSize * 0.27),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';

void main() {
  runApp(const SnookerScoreboardApp());
}

class SnookerScoreboardApp extends StatelessWidget {
  const SnookerScoreboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B.P. Snooker Score',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(
          child: PlayerNameInputScreen(),
        ),
      ),
    );
  }
}

class PlayerNameInputScreen extends StatefulWidget {
  const PlayerNameInputScreen({Key? key}) : super(key: key);

  @override
  _PlayerNameInputScreenState createState() => _PlayerNameInputScreenState();
}

class _PlayerNameInputScreenState extends State<PlayerNameInputScreen> {
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();
  final TextEditingController _framesController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // เพิ่มตัวแปรสำหรับเก็บจำนวนลูกแดงที่เลือก
  int selectedReds = 6;

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบว่าเป็น web หรือมือถือ
    final bool isWeb = MediaQuery.of(context).size.width > 800;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = isWeb ? 16.0 : screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        elevation: 0,
        toolbarHeight: isWeb ? 50.0 : 35.0,
        title: Text(
          "B.P. Snooker Score",
          style: TextStyle(
            fontFamily: 'OpenSans-Regular',
            fontWeight: FontWeight.w600,
            fontSize: isWeb ? 24 : 17,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[850]!,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isWeb ? 800 : 600, // ปรับความกว้างตามอุปกรณ์
              ),
              padding: EdgeInsets.all(isWeb ? 40.0 : 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      width: isWeb ? 120 : fontSize * 4,
                      height: isWeb ? 120 : fontSize * 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.red[700]!,
                            Colors.red[900]!,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 12,
                            offset: Offset(-2, -2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Highlight effect
                          Positioned(
                            top: isWeb ? 25 : fontSize * 0.8,
                            left: isWeb ? 25 : fontSize * 0.8,
                            child: Container(
                              width: isWeb ? 40 : fontSize * 1.2,
                              height: isWeb ? 40 : fontSize * 1.2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                          // Text
                          Center(
                            child: Text(
                              'B.P.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isWeb ? 40 : fontSize * 1.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isWeb ? 40 : 20),

                    // Input Fields แบบ Responsive
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > (isWeb ? 600 : 500)) {
                          // Layout แบบ 2 คอลัมน์
                          return Column(
                            children: [
                              _buildInputField(
                                controller: _framesController,
                                label: "Number of Frames",
                                icon: Icons.sports_score,
                                fontSize: fontSize,
                                keyboardType: TextInputType.number,
                                isWeb: isWeb,
                              ),
                              SizedBox(height: isWeb ? 30 : 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInputField(
                                      controller: _player1Controller,
                                      label: "Player 1 Name",
                                      icon: Icons.person,
                                      fontSize: fontSize,
                                      isWeb: isWeb,
                                    ),
                                  ),
                                  SizedBox(width: isWeb ? 30 : 20),
                                  Expanded(
                                    child: _buildInputField(
                                      controller: _player2Controller,
                                      label: "Player 2 Name",
                                      icon: Icons.person_outline,
                                      fontSize: fontSize,
                                      isWeb: isWeb,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          // Layout แบบ 1 คอลัมน์
                          return Column(
                            children: [
                              _buildInputField(
                                controller: _framesController,
                                label: "Number of Frames",
                                icon: Icons.sports_score,
                                fontSize: fontSize,
                                keyboardType: TextInputType.number,
                                isWeb: isWeb,
                              ),
                              SizedBox(height: isWeb ? 30 : 20),
                              _buildInputField(
                                controller: _player1Controller,
                                label: "Player 1 Name",
                                icon: Icons.person,
                                fontSize: fontSize,
                                isWeb: isWeb,
                              ),
                              SizedBox(height: isWeb ? 30 : 20),
                              _buildInputField(
                                controller: _player2Controller,
                                label: "Player 2 Name",
                                icon: Icons.person_outline,
                                fontSize: fontSize,
                                isWeb: isWeb,
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    SizedBox(height: isWeb ? 40 : 30),

                    // Red Balls Selector
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: isWeb ? 600 : 400,
                      ),
                      padding: EdgeInsets.all(isWeb ? 25 : 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Red Balls",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: fontSize,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [6, 10, 15].map((number) {
                              final isSelected = selectedReds == number;
                              return Container(
                                width: fontSize * 2.5,
                                height: fontSize * 2.5,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedReds = number;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shape: CircleBorder(),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: isSelected
                                            ? [
                                                Color(0xFFD32F2F),
                                                Color(0xFFB71C1C),
                                              ]
                                            : [
                                                Colors.grey[700]!,
                                                Colors.grey[800]!,
                                              ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$number',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isWeb ? 50 : 40),

                    // Start Game Button
                    Container(
                      width: isWeb ? 300 : double.infinity,
                      height: isWeb ? 60 : 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFD32F2F),
                            Color(0xFFB71C1C),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SnookerScoreboard(
                                  player1Name: _player1Controller.text,
                                  player2Name: _player2Controller.text,
                                  freames: _framesController.text,
                                  numberOfReds: selectedReds,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Start Game",
                          style: TextStyle(
                            fontSize: fontSize * 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required double fontSize,
    required bool isWeb,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: isWeb ? 60 : null,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(isWeb ? 15 : 12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: isWeb ? 12 : 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required!';
          }
          return null;
        },
      ),
    );
  }
}

class SnookerScoreboard extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final String freames;
  final int numberOfReds; // เพิ่ม property

  const SnookerScoreboard({
    Key? key,
    required this.player1Name,
    required this.player2Name,
    required this.freames,
    required this.numberOfReds, // เพิ่ม parameter
  }) : super(key: key);

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

  String player1Name = '';
  String player1LastName = '';
  String player2Name = '';
  String player2LastName = '';
  int freams = 0;

  // Track last points added for undo functionality
  int lastPoints = 0;
  int lastPlayer = 0;
  List<Map<String, dynamic>> scoreHistory =
      []; // Stack สำหรับเก็บการเปลี่ยนแปลงคะแนน

  List<int> currentBreakHistory = [];
  List<int> player1BreakHistory = [];
  List<int> player2BreakHistory = [];

  int remainingReds = 6; // เพิ่มตัวแปรเก็บจำนวนลูกแดงที่เหลือ

  // เพิ่มตัวแปรเก็บสถานะลูกสี
  Map<int, bool> colorBallsAvailable = {
    2: true, // เหลือง
    3: true, // เขียว
    4: true, // น้ำตาล
    5: true, // น้ำเงิน
    6: true, // ชมพู
    7: true, // ดำ
  };

  // เพิ่มตัวแปรเพื่อติดตามว่าได้เริ่มยิงลูกสีตามลำดับแล้วหรือยัง
  bool hasStartedColorSequence = false;

  // เพิ่มตัวแปรเก็บรูปภาพ
  ImageProvider? player1ImageProvider;
  ImageProvider? player2ImageProvider;

  @override
  void initState() {
    super.initState();

    freams = int.parse(widget.freames);

    // แยกชื่อและนามสกุลอย่างปลอดภัย
    final player1Names = widget.player1Name.split(' ');
    player1Name = player1Names[0];
    player1LastName = player1Names.length > 1 ? player1Names[1] : '';

    final player2Names = widget.player2Name.split(' ');
    player2Name = player2Names[0];
    player2LastName = player2Names.length > 1 ? player2Names[1] : '';

    remainingReds = widget.numberOfReds;

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

  bool canPotColor(int points) {
    // ถ้าลูกสีถูกเก็บไปแล้ว จะไม่สามารถยิงได้
    if (points >= 2 && !colorBallsAvailable[points]!) {
      return false;
    }

    // ถ้ายังมีลูกแดงเหลือ
    if (remainingReds > 0) {
      // สามารถยิงลูกแดง หรือ ยิงลูกสีหลังจากยิงลูกแดงลง
      return points == 1 ||
          (currentBreakHistory.isNotEmpty && currentBreakHistory.last == 1);
    }

    // เมื่อลูกแดงหมด
    if (currentBreakHistory.isNotEmpty && currentBreakHistory.last == 1) {
      // ถ้าเพิ่งยิงลูกแดงลูกสุดท้ายลง สามารถยิงลูกสีใดก็ได้
      return points >= 2;
    } else {
      // ต้องยิงตามลำดับจากเหลืองไปดำ
      for (int i = 2; i <= 7; i++) {
        if (colorBallsAvailable[i]!) {
          return points == i;
        }
      }
    }
    return false;
  }

  void addPoints(int points) {
    if (points == 1) {
      if (remainingReds <= 0) return;
      remainingReds--;
    }

    setState(() {
      // บันทึกประวัติ
      scoreHistory.add({
        'player': currentPlayer,
        'points': points,
        'break': currentPlayer == 1 ? player1Break : player2Break,
        'remainingReds': remainingReds,
        'colorBallsAvailable': Map<int, bool>.from(colorBallsAvailable),
        'lastRedBall':
            currentBreakHistory.isNotEmpty && currentBreakHistory.last == 1,
      });

      // เพิ่มคะแนน
      if (currentPlayer == 1) {
        player1Score += points;
        player1Break += points;
        player1BreakHistory.add(points);
      } else {
        player2Score += points;
        player2Break += points;
        player2BreakHistory.add(points);
      }

      currentBreakHistory.add(points);

      // เมื่อลูกแดงหมดและยิงลูกสี
      if (remainingReds == 0 && points >= 2) {
        // ถ้าเป็นการยิงลูกสีหลังจากลูกแดงลูกสุดท้าย ไม่ต้องเก็บลูกสี
        if (currentBreakHistory.length >= 2 &&
            currentBreakHistory[currentBreakHistory.length - 2] == 1) {
          // ไม่ต้องเก็บลูกสี (ต้องนำกลับมาวางที่จุดเดิม)
        } else {
          // เก็บลูกสี (ไม่ต้องนำกลับมาวาง)
          colorBallsAvailable[points] = false;
        }
      }
    });
  }

  void undoLastAction() {
    setState(() {
      if (scoreHistory.isNotEmpty) {
        final lastAction = scoreHistory.removeLast();

        if (lastAction['type'] == 'remove_red') {
          // คืนค่าจำนวนลูกแดงและสถานะอื่นๆ
          remainingReds = lastAction['remainingReds'];
          colorBallsAvailable =
              Map<int, bool>.from(lastAction['colorBallsAvailable']);
          hasStartedColorSequence = lastAction['hasStartedColorSequence'];
        } else if (lastAction['type'] == 'foul') {
          int lastPoints = lastAction['points'];
          int lastPlayer = lastAction['player'];
          if (lastPlayer == 1) {
            player1Score -= lastPoints;
          } else {
            player2Score -= lastPoints;
          }
        } else {
          int lastPoints = lastAction['points'];
          int lastPlayer = lastAction['player'];
          int lastBreak = lastAction['break'];

          // คืนค่าสถานะลูกสี
          if (lastAction.containsKey('colorBallsAvailable')) {
            colorBallsAvailable =
                Map<int, bool>.from(lastAction['colorBallsAvailable']);
          }

          if (lastPoints == 1) {
            remainingReds++;
          }

          if (lastPlayer == 1) {
            player1Score -= lastPoints;
            player1Break = lastBreak;
            if (player1BreakHistory.isNotEmpty) {
              player1BreakHistory.removeLast();
            }
          } else if (lastPlayer == 2) {
            player2Score -= lastPoints;
            player2Break = lastBreak;
            if (player2BreakHistory.isNotEmpty) {
              player2BreakHistory.removeLast();
            }
          }

          if (currentBreakHistory.isNotEmpty) {
            currentBreakHistory.removeLast();
          }
        }

        // คืนค่าสถานะการยิงลูกสีตามลำดับ
        if (lastAction.containsKey('hasStartedColorSequence')) {
          hasStartedColorSequence = lastAction['hasStartedColorSequence'];
        }
      }
    });
  }

  // Helper function to get ball color
  Color getBallColor(int points) {
    switch (points) {
      case 1: // ลูกแดง
        return Color(0xFFD32F2F); // สีแดงเข้ม
      case 2: // ลูกเหลือง
        return Color(0xFFFFD700); // สีเหลืองทอง
      case 3: // ลูกเขียว
        return Color(0xFF2E7D32); // สีเขียวเข้ม
      case 4: // ลูกน้ำตาล
        return Color(0xFF8B4513); // สีน้ำตาลไม้
      case 5: // ลูกน้ำเงิน
        return Color(0xFF1565C0); // สีน้ำเงินเข้ม
      case 6: // ลูกชมพู
        return Color(0xFFE91E63); // สีชมพูเข้ม
      case 7: // ลูกดำ
        return Color(0xFF212121); // สีดำเข้ม
      default:
        return Colors.grey;
    }
  }

  // เพิ่มฟังก์ชันเลือกรูปภาพ1
  Future<void> pickImage1() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        // สำหรับ Web
        final Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          player1ImageProvider = MemoryImage(imageBytes);
        });
      } else {
        // สำหรับ Mobile
        setState(() {
          player1ImageProvider = FileImage(File(image.path));
        });
      }
    }
  }

  // เพิ่มฟังก์ชันเลือกรูปภาพ2
  Future<void> pickImage2() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        // สำหรับ Web
        final Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          player2ImageProvider = MemoryImage(imageBytes);
        });
      } else {
        // สำหรับ Mobile
        setState(() {
          player2ImageProvider = FileImage(File(image.path));
        });
      }
    }
  }

  // เพิ่มฟังก์ชันสำหรับสร้าง gradient effect
  List<BoxShadow> getBallShadow(int points) {
    Color baseColor = getBallColor(points);
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        offset: Offset(2, 2),
        blurRadius: 4,
      ),
      BoxShadow(
        color: baseColor.withOpacity(0.5),
        offset: Offset(-1, -1),
        blurRadius: 4,
      ),
    ];
  }

  // แก้ไขส่วนที่สร้างลูกบอลใน buildBreakHistory
  Widget buildBreakHistory(List<int> breakHistory, double fontSize) {
    Map<int, int> ballCount = {};
    for (int points in breakHistory) {
      ballCount[points] = (ballCount[points] ?? 0) + 1;
    }

    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: ballCount.entries.map((entry) {
        return Container(
          width: fontSize * 1.7,
          height: fontSize * 1.7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                getBallColor(entry.key).withOpacity(1),
                getBallColor(entry.key).withOpacity(0.8),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: getBallShadow(entry.key),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // เพิ่ม highlight effect
              Positioned(
                top: fontSize * 0.2,
                left: fontSize * 0.2,
                child: Container(
                  width: fontSize * 0.4,
                  height: fontSize * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              // แสดงจำนวนลูก (ถ้ามีมากกว่า 1)
              if (entry.value > 1)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${entry.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize * 0.6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void foul(int points) {
    setState(() {
      scoreHistory.add({
        'type': 'foul',
        'points': points,
        'player': currentPlayer == 1 ? 2 : 1, // Opponent gets the points
      });

      if (currentPlayer == 1) {
        player2Score += points;
      } else {
        player1Score += points;
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
      currentBreakHistory.clear();
      // ไม่ต้องเคลียร์ประวัติการยิงของผู้เล่น
    });
  }

  void reset() {
    setState(() {
      player1Frames = 0;
      player2Frames = 0;
      player1Score = 0;
      player2Score = 0;
      player1Break = 0;
      player2Break = 0;
      currentPlayer = 1; // หรือผู้เล่นที่คุณต้องการให้เริ่มต้นในรอบใหม่
      scoreHistory.clear(); // เคลียร์ประวัติการเปลี่ยนแปลงคะแนน
      currentBreakHistory.clear(); // เคลียร์ประวัติการเบรคปัจจุบัน
      secondsElapsed = 0;
      remainingReds = widget.numberOfReds; // ใช้ค่าที่ส่งมาจาก constructor
      hasStartedColorSequence = false;
      player1BreakHistory.clear();
      player2BreakHistory.clear();
      // รีเซ็ตสถานะลูกสี
      colorBallsAvailable = {
        2: true,
        3: true,
        4: true,
        5: true,
        6: true,
        7: true,
      };
    });
  }

  void endFrame() {
    setState(() {
      if (player1Score > player2Score) {
        player1Frames++;
      } else if (player2Score > player1Score) {
        player2Frames++;
      }

      // ตรวจสอบว่ามีผู้ชนะหรือไม่
      bool hasWinner = false;
      int framesNeededToWin =
          (freams / 2).ceil(); // จำนวน frames ที่ต้องชนะเพื่อชนะเกม

      // ถ้าผู้เล่นคนใดชนะเกินครึ่งของจำนวน frames ทั้งหมด หรือ frames ที่เหลือไม่เพียงพอที่จะตามทัน
      if (player1Frames >= framesNeededToWin ||
          player2Frames >= framesNeededToWin ||
          (freams - (player1Frames + player2Frames) + player2Frames) <
              player1Frames ||
          (freams - (player1Frames + player2Frames) + player1Frames) <
              player2Frames) {
        hasWinner = true;
      }

      if (hasWinner) {
        // แสดง Dialog ประกาศผู้ชนะ
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            String winner;
            String score;
            if (player1Frames > player2Frames) {
              winner =
                  "${player1Name.toUpperCase()} ${player1LastName.toUpperCase()}";
              score = "$player1Frames - $player2Frames";
            } else {
              winner =
                  "${player2Name.toUpperCase()} ${player2LastName.toUpperCase()}";
              score = "$player2Frames - $player1Frames";
            }

            return Dialog(
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey[900]!,
                      Colors.grey[850]!,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Trophy Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildImgPlayerName1(60),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber.withOpacity(0.1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.2),
                                blurRadius: 12,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(Icons.emoji_events,
                              color: Colors.amber, size: 28),
                        ),
                        _buildImgPlayerName2(60),
                      ],
                    ),
                    SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Player 1
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${player1Name.toUpperCase()}\n${player1LastName.toUpperCase()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: player1Frames > player2Frames
                                      ? Colors.amber
                                      : Colors.grey[400],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                "$player1Frames",
                                style: TextStyle(
                                  color: player1Frames > player2Frames
                                      ? Colors.amber
                                      : Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // VS with Frames
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "FRAME $freams",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "VS",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Player 2
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${player2Name.toUpperCase()}\n${player2LastName.toUpperCase()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: player2Frames > player1Frames
                                      ? Colors.amber
                                      : Colors.grey[400],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                "$player2Frames",
                                style: TextStyle(
                                  color: player2Frames > player1Frames
                                      ? Colors.amber
                                      : Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            reset();
                          },
                          icon: Icon(Icons.refresh, size: 20),
                          label: Text('New Game'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[400],
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.grey[700]!),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.home, size: 20),
                          label: Text('Main Menu'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      // รีเซ็ตค่าต่างๆ สำหรับเฟรมใหม่
      player1Score = 0;
      player2Score = 0;
      player1Break = 0;
      player2Break = 0;
      currentPlayer = 1;
      scoreHistory.clear();
      currentBreakHistory.clear();
      secondsElapsed = 0;
      player1BreakHistory.clear();
      player2BreakHistory.clear();
      remainingReds = widget.numberOfReds;
      hasStartedColorSequence = false;
      colorBallsAvailable = {
        2: true,
        3: true,
        4: true,
        5: true,
        6: true,
        7: true,
      };
    });
  }

  void showRemoveRedConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[900]!,
                  Colors.grey[850]!,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.red[700]!,
                        Colors.red[900]!,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(-2, -2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Highlight effect
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Remove Red Ball',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Are you sure you want to remove a red ball?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, size: 20),
                      label: Text('Cancel'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          remainingReds--;
                          scoreHistory.add({
                            'type': 'remove_red',
                            'remainingReds': remainingReds + 1,
                            'colorBallsAvailable':
                                Map<int, bool>.from(colorBallsAvailable),
                            'hasStartedColorSequence': hasStartedColorSequence,
                          });
                        });
                      },
                      icon: Icon(Icons.check, size: 20),
                      label: Text('Remove'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color getFoulBallColor(int points) {
    switch (points) {
      case 4:
        return Colors.white; // 4 แต้ม = ลูกขาว
      case 5:
        return Color(0xFF1565C0); // 5 แต้ม = น้ำเงิน
      case 6:
        return Color(0xFFE91E63); // 6 แต้ม = ชมพู
      case 7:
        return Color(0xFF212121); // 7 แต้ม = ดำ
      default:
        return Colors.grey;
    }
  }

  // แก้ไขส่วนแสดงรูปผู้เล่น 1
  Widget _buildImgPlayerName1(double fontSize) {
    return GestureDetector(
      onTap: () => pickImage1(),
      child: CircleAvatar(
        radius: fontSize * 0.7,
        backgroundColor: Colors.grey[800],
        backgroundImage: player1ImageProvider,
        child: player1ImageProvider == null
            ? Icon(
                Icons.person,
                color: Colors.grey[600],
                size: fontSize,
              )
            : null,
      ),
    );
  }

  // แก้ไขส่วนแสดงรูปผู้เล่น 2
  Widget _buildImgPlayerName2(double fontSize) {
    return GestureDetector(
      onTap: () => pickImage2(),
      child: CircleAvatar(
        radius: fontSize * 0.7,
        backgroundColor: Colors.grey[800],
        backgroundImage: player2ImageProvider,
        child: player2ImageProvider == null
            ? Icon(
                Icons.person,
                color: Colors.grey[600],
                size: fontSize,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // คำนวณขนาด font ตามความกว้างของหน้าจอ
            final fontSize = constraints.maxWidth * 0.02;
            final ballSize = constraints.maxHeight * 0.10;

            return Container(
              color: Colors.black,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // ส่วนซ้าย (ผู้เล่น 1)
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              switchPlayer(); // เรียกฟังก์ชัน switchPlayer เพื่อเปลี่ยนผู้เล่น
                            },
                            child: _buildPlayerSection(
                              player1Name.toUpperCase(),
                              player1LastName.toUpperCase(),
                              player1Score,
                              player1Break,
                              fontSize,
                              currentPlayer == 1,
                            ),
                          ),
                        ),
                        // ส่วนกลาง (Timer และ Controls)
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: _buildCenterInfo(fontSize),
                              ),
                              // _buildSharedControls(fontSize, ballSize),
                            ],
                          ),
                        ),
                        // ส่วนขวา (ผู้เล่น 2)
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              switchPlayer(); // เรียกฟังก์ชัน switchPlayer เพื่อเปลี่ยนผู้เล่น
                            },
                            child: _buildPlayerSection(
                              player2Name.toUpperCase(),
                              player2LastName.toUpperCase(),
                              player2Score,
                              player2Break,
                              fontSize,
                              currentPlayer == 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSharedControls(fontSize, ballSize),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayerSection(
    String firstName,
    String lastName,
    int score,
    int breakScore,
    double fontSize,
    bool isCurrentPlayer,
  ) {
    // เลือกประวัติตามผู้เล่น
    List<int> playerHistory = firstName == player1Name.toUpperCase()
        ? player1BreakHistory
        : player2BreakHistory;

    // คำนวณแต้มที่ตามอยู่
    bool isPlayer1 = firstName == player1Name.toUpperCase();
    int pointsBehind = isPlayer1
        ? (player2Score > player1Score ? player2Score - player1Score : 0)
        : (player1Score > player2Score ? player1Score - player2Score : 0);

    return Container(
      padding: EdgeInsets.all(fontSize),
      color: isCurrentPlayer ? Colors.grey[900] : Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                firstName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 1.3,
                ),
              ),
              Text(
                lastName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 1.3,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                score.toString(),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 253, 228),
                  fontSize: fontSize * 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // แสดงแต้มที่ตามอยู่ถ้ามีแต้มน้อยกว่า
              if (pointsBehind > 0)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // decoration: BoxDecoration(
                    //   color: Colors.red[900]!.withOpacity(0.9),
                    //   borderRadius: BorderRadius.circular(12),
                    // ),
                    child: Text(
                      '(-${pointsBehind})',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize * 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            'Break : $breakScore',
            style: TextStyle(
              color: Colors.orange,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          buildBreakHistory(playerHistory, fontSize * 0.8),
        ],
      ),
    );
  }

  Widget _buildCenterInfo(double fontSize) {
    return Container(
      padding: EdgeInsets.all(fontSize),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TIME',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize * 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          // IconButton(
          //   iconSize: fontSize * 2,
          //   icon: Icon(
          //     isTimerRunning ? Icons.pause : Icons.play_arrow,
          //   ),
          //   onPressed: isTimerRunning ? pauseTimer : startTimer,
          //   color: Colors.white,
          // ),
          GestureDetector(
            onDoubleTap: isTimerRunning ? pauseTimer : startTimer,
            child: Text(
              formatTime(secondsElapsed),
              style: TextStyle(
                color: Colors.red,
                fontSize: fontSize * 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // SizedBox(height: fontSize * 2),
          _buildInfoRow('FRAMES', player1Frames, player2Frames, fontSize * 3),

          // _buildInfoRow('POINTS REMAINING', 147 - player1Score,
          //     147 - player2Score, fontSize * 1.5),
          SizedBox(height: fontSize),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     ElevatedButton.icon(
          //       onPressed: undoLastAction,
          //       icon: Icon(Icons.undo, size: fontSize * 1),
          //       label: Text('Undo', style: TextStyle(fontSize: fontSize * 0.8)),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.grey[800],
          //       ),
          //     ),
          //     ElevatedButton.icon(
          //       onPressed: foul,
          //       icon: Icon(Icons.warning, size: fontSize * 1),
          //       label: Text('Foul', style: TextStyle(fontSize: fontSize * 0.8)),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.red[800],
          //       ),
          //     ),
          //     ElevatedButton.icon(
          //       onPressed: endFrame,
          //       icon: Icon(Icons.done_all, size: fontSize * 1),
          //       label: Text('End Frame',
          //           style: TextStyle(fontSize: fontSize * 0.8)),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.green[800],
          //         // padding: EdgeInsets.symmetric(
          //         //   horizontal: fontSize * 1,
          //         //   vertical: fontSize,
          //         // ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, int value1, int value2, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: fontSize * 0.3),
      child: Column(
        children: [
          // Text(
          //   label,
          //   style: TextStyle(
          //     color: Colors.yellow,
          //     fontSize: fontSize * 0.8,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImgPlayerName1(fontSize),
              Text(
                '($freams)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 0.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildImgPlayerName2(fontSize),
            ],
          ),
          SizedBox(height: fontSize * 0.3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                value1.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: fontSize * 0.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value2.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize * 1.3,
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
    final ballColors = {
      1: Color(0xFFD32F2F), // สีแดงเข้ม
      2: Color(0xFFFFD700), // สีเหลืองทอง
      3: Color(0xFF2E7D32), // สีเขียวเข้ม
      4: Color(0xFF8B4513), // สีน้ำตาลไม้
      5: Color(0xFF1565C0), // สีน้ำเงินเข้ม
      6: Color(0xFFE91E63), // สีชมพูเข้ม
      7: Color(0xFF212121), // สีดำเข้ม
    };

    bool canPotColor(int points) {
      // ถ้าลูกสีถูกเก็บไปแล้ว จะไม่สามารถยิงได้
      if (points >= 2 && !colorBallsAvailable[points]!) {
        return false;
      }

      // ถ้ายังมีลูกแดงเหลือ
      if (remainingReds > 0) {
        // สามารถยิงลูกแดง หรือ ยิงลูกสีหลังจากยิงลูกแดงลง
        return points == 1 ||
            (currentBreakHistory.isNotEmpty && currentBreakHistory.last == 1);
      }

      // เมื่อลูกแดงหมด
      if (currentBreakHistory.isNotEmpty && currentBreakHistory.last == 1) {
        // ถ้าเพิ่งยิงลูกแดงลูกสุดท้ายลง สามารถยิงลูกสีใดก็ได้
        return points >= 2;
      } else {
        // ต้องยิงตามลำดับจากเหลืองไปดำ
        for (int i = 2; i <= 7; i++) {
          if (colorBallsAvailable[i]!) {
            return points == i;
          }
        }
      }
      return false;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(top: BorderSide(color: Colors.grey[800]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Undo button
          Container(
            width: fontSize * 2.2,
            height: fontSize * 2.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[700]!,
                  Colors.grey[800]!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(-2, -2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: undoLastAction,
                customBorder: CircleBorder(),
                child: Icon(
                  Icons.undo,
                  color: Colors.white,
                  size: fontSize * 1.2,
                ),
              ),
            ),
          ),
          SizedBox(width: fontSize * 0.5),

          SizedBox(width: fontSize),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: fontSize,
            runSpacing: fontSize,
            children: ballColors.entries.map((entry) {
              bool isEnabled = canPotColor(entry.key);
              return GestureDetector(
                onTap: isEnabled ? () => addPoints(entry.key) : null,
                child: Container(
                  width: ballSize,
                  height: ballSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        entry.value.withOpacity(isEnabled ? 1 : 0.3),
                        entry.value.withOpacity(isEnabled ? 0.7 : 0.2),
                      ],
                      stops: const [0.2, 0.9],
                    ),
                    boxShadow: isEnabled
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(3, 3),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: entry.value.withOpacity(0.5),
                              offset: Offset(-2, -2),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                  child: Stack(
                    children: [
                      // Highlight effect
                      if (isEnabled)
                        Positioned(
                          top: ballSize * 0.15,
                          left: ballSize * 0.15,
                          child: Container(
                            width: ballSize * 0.4,
                            height: ballSize * 0.4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withOpacity(0.4),
                                  Colors.white.withOpacity(0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      // Ball number
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: isEnabled
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.1),
                                )
                              : null,
                          child: Text(
                            entry.key == 1
                                ? '${entry.key}\n($remainingReds)'
                                : '${entry.key}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: entry.value.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: fontSize * (entry.key == 1 ? 0.7 : 1),
                              fontWeight: FontWeight.bold,
                              shadows: isEnabled
                                  ? [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(width: fontSize),
          Row(
            children: [
              _buildFoulButton(fontSize),
              SizedBox(width: fontSize),
              Container(
                width: fontSize * 2.2,
                height: fontSize * 2.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green[600]!,
                      Colors.green[800]!,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(-2, -2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.grey[900]!,
                                    Colors.grey[850]!,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey[800]!,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: Colors.orange[400],
                                    size: 32,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'End Frame',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Are you sure you want to end this frame?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          reset();
                                        },
                                        icon: Icon(Icons.refresh, size: 20),
                                        label: Text('Reset'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.grey[400],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon: Icon(Icons.close, size: 20),
                                            label: Text('No'),
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.grey[400],
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              endFrame();
                                            },
                                            icon: Icon(Icons.check, size: 20),
                                            label: Text('Yes'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green[700],
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    customBorder: CircleBorder(),
                    child: Icon(
                      Icons.done_all,
                      color: Colors.white,
                      size: fontSize * 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoulButton(double fontSize) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: fontSize * 2.2,
        height: fontSize * 2.2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey[300]!,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(-2, -2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController customFoulController =
                      TextEditingController();

                  return Dialog(
                    backgroundColor: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Foul Points Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning_amber,
                                    color: Colors.red[800]),
                                SizedBox(width: 10),
                                Text(
                                  'Foul Points',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize * 1.2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            // แถวของปุ่มคะแนน Foul และช่องใส่คะแนนเอง
                            Row(
                              children: [
                                // ปุ่มคะแนน Foul ที่ใช้บ่อย
                                Expanded(
                                  flex: 3,
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: [4, 5, 6, 7].map((points) {
                                      return SizedBox(
                                        width: fontSize * 3.2,
                                        height: fontSize * 3.2,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            foul(points);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            shape: CircleBorder(),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  getFoulBallColor(points)
                                                      .withOpacity(0.9),
                                                  getFoulBallColor(points)
                                                      .withOpacity(0.7),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: Offset(2, 2),
                                                ),
                                                BoxShadow(
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  blurRadius: 8,
                                                  offset: Offset(-2, -2),
                                                ),
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                // Highlight effect
                                                Positioned(
                                                  top: fontSize * 0.6,
                                                  left: fontSize * 0.6,
                                                  child: Container(
                                                    width: fontSize * 0.8,
                                                    height: fontSize * 0.8,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white
                                                          .withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                                // Points text
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '$points',
                                                        style: TextStyle(
                                                          fontSize:
                                                              fontSize * 1.4,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          shadows: [
                                                            Shadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              offset:
                                                                  Offset(1, 1),
                                                              blurRadius: 2,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        'Points',
                                                        style: TextStyle(
                                                          fontSize:
                                                              fontSize * 0.6,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(width: 8),

                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: remainingReds > 0
                                        ? () {
                                            Navigator.pop(context);
                                            showRemoveRedConfirmDialog();
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      shape: CircleBorder(),
                                    ),
                                    child: Container(
                                      height: fontSize * 3.2,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: remainingReds > 0
                                              ? [
                                                  Color(0xFFD32F2F)
                                                      .withOpacity(0.9),
                                                  Color(0xFFB71C1C)
                                                      .withOpacity(0.7),
                                                ]
                                              : [
                                                  Colors.grey[700]!
                                                      .withOpacity(0.9),
                                                  Colors.grey[900]!
                                                      .withOpacity(0.7),
                                                ],
                                        ),
                                        boxShadow: remainingReds > 0
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: Offset(2, 2),
                                                ),
                                                BoxShadow(
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  blurRadius: 8,
                                                  offset: Offset(-2, -2),
                                                ),
                                              ]
                                            : null,
                                      ),
                                      child: Stack(
                                        children: [
                                          if (remainingReds > 0)
                                            // Positioned(
                                            //   top: fontSize * 0.6,
                                            //   left: fontSize * 2.6,
                                            //   child: Container(
                                            //     width: fontSize * 0.8,
                                            //     height: fontSize * 0.8,
                                            //     decoration: BoxDecoration(
                                            //       shape: BoxShape.circle,
                                            //       color: Colors.white
                                            //           .withOpacity(0.2),
                                            //     ),
                                            //   ),
                                            // ),
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: fontSize * 1.5,
                                                  ),
                                                  Text(
                                                    '(${remainingReds})',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: fontSize * 0.8,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // ช่องใส่คะแนน Foul เอง
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: fontSize * 3.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: customFoulController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Custom',
                                        labelStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        hintText: 'Points',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[600]),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ),
                                // Bottom buttons
                                SizedBox(width: 8),

                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (customFoulController.text.isNotEmpty) {
                                      int? points = int.tryParse(
                                          customFoulController.text);
                                      if (points != null && points > 0) {
                                        Navigator.pop(context);
                                        foul(points);
                                      }
                                    }
                                  },
                                  icon: Icon(Icons.check, size: fontSize * 0.8),
                                  label: Text(
                                    'OK',
                                    style: TextStyle(fontSize: fontSize * 0.8),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: 8),
                            // Divider(color: Colors.grey[800], height: 24),

                            // // Remove Red Section
                            // Row(
                            //   children: [
                            //     Icon(Icons.remove_circle,
                            //         color: Colors.red[700]),
                            //     SizedBox(width: 10),
                            //     Text(
                            //       'Remove Red Ball',
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: fontSize * 1.2,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 12),

                            // ElevatedButton(
                            //   onPressed: remainingReds > 0
                            //       ? () {
                            //           Navigator.pop(context);
                            //           showRemoveRedConfirmDialog();
                            //         }
                            //       : null,
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: remainingReds > 0
                            //         ? Colors.red[700]
                            //         : Colors.grey[700],
                            //     padding: EdgeInsets.symmetric(vertical: 12),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Icon(Icons.remove, color: Colors.white),
                            //       SizedBox(width: 8),
                            //       Text(
                            //         'Remove Red Ball (${remainingReds} remaining)',
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: fontSize * 0.8,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Bottom buttons
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     TextButton.icon(
                            //       onPressed: () => Navigator.pop(context),
                            //       icon: Icon(Icons.close, size: fontSize * 0.8),
                            //       label: Text(
                            //         'Cancel',
                            //         style: TextStyle(fontSize: fontSize * 1.0),
                            //       ),
                            //       style: TextButton.styleFrom(
                            //         foregroundColor: Colors.grey[400],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            customBorder: CircleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.black,
                  size: fontSize * 0.8,
                ),
                Text(
                  'Foul',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

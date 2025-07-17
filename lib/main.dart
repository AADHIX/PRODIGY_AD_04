// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_navbar.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const EntryScreen(),
    );
  }
}

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ProfileNavBar(
                userName: 'John Doe',
                userEmail: 'john.doe@example.com',
                profileImageUrl: '', // Add a URL or leave blank for placeholder
              ),
              const SizedBox(height: 16),
              const Spacer(flex: 2),
              Text(
                'TIC TAC TOE',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Modern Edition',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/tictactoe.png', // Add your own asset or remove this line
                height: 200,
                width: 200,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'START GAME',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Add instructions dialog if needed
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('How to Play'),
                      content: const Text(
                        'The classic Tic Tac Toe game:\n\n'
                        '1. Players alternate placing X and O marks\n'
                        '2. First to get 3 in a row wins\n'
                        '3. Can be horizontal, vertical or diagonal',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Got it!'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'HOW TO PLAY',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> board;
  String currentPlayer = 'X';
  String winner = '';
  bool gameOver = false;
  int xWins = 0;
  int oWins = 0;
  int draws = 0;
  late ConfettiController _confettiController;
  final List<Map<String, dynamic>> _gameHistory = [];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    resetGame();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
      winner = '';
      gameOver = false;
      _confettiController.stop();
    });
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && !gameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        
        if (checkWin(row, col)) {
          winner = currentPlayer;
          gameOver = true;
          if (winner == 'X') {
            xWins++;
          } else {
            oWins++;
          }
          _confettiController.play();
          _addToHistory(winner);
        } else if (isBoardFull()) {
          gameOver = true;
          draws++;
          _addToHistory('Draw');
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  void _addToHistory(String result) {
    _gameHistory.insert(0, {
      'date': DateTime.now(),
      'result': result,
      'board': List.generate(3, (i) => List.from(board[i])),
    });
    if (_gameHistory.length > 5) {
      _gameHistory.removeLast();
    }
  }

  bool checkWin(int row, int col) {
    // Check row
    if (board[row][0] == currentPlayer &&
        board[row][1] == currentPlayer &&
        board[row][2] == currentPlayer) {
      return true;
    }

    // Check column
    if (board[0][col] == currentPlayer &&
        board[1][col] == currentPlayer &&
        board[2][col] == currentPlayer) {
      return true;
    }

    // Check diagonals
    if (row == col &&
        board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      return true;
    }

    if (row + col == 2 &&
        board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      for (var cell in row) {
        if (cell.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Modern Tic Tac Toe'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () => _showGameHistory(context),
                tooltip: 'Game History',
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: resetGame,
                tooltip: 'Reset Game',
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Scoreboard
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildScoreCard('X Wins', xWins, Colors.blue),
                        _buildScoreCard('Draws', draws, const Color.fromARGB(255, 37, 37, 37)),
                        _buildScoreCard('O Wins', oWins, Colors.pink),
                      ],
                    ),
                  ),
                  
                  // Current player indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        key: ValueKey(gameOver ? 'gameOver' : 'playing'),
                        gameOver
                            ? winner.isNotEmpty
                                ? 'Player $winner wins! 🎉'
                                : 'It\'s a draw! 🤝'
                            : 'Current Player: $currentPlayer',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                              color: Colors.green, // or any color you prefer
                              ),
                      ),
                    ),
                  ),

                  
                  
                  // Game board
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: List.generate(3, (row) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (col) {
                            return GestureDetector(
                              onTap: () => makeMove(row, col),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                        board[row][col].isEmpty ? 0.1 : 0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      board[row][col],
                                      key: ValueKey('$row$col${board[row][col]}'),
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: board[row][col] == 'X'
                                            ? Colors.blue
                                            : Colors.pink,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  ),
                  
                  // Reset button
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                    child: ElevatedButton.icon(
                      onPressed: resetGame,
                      icon: const Icon(Icons.refresh),
                      label: const Text('New Game'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Confetti effect
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
      ],
    );
  }

  void _showGameHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recent Games'),
        content: SizedBox(
          width: double.maxFinite,
          child: _gameHistory.isEmpty
              ? const Text('No games played yet')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _gameHistory.length,
                  itemBuilder: (context, index) {
                    final game = _gameHistory[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${game['result']} - ${_formatDate(game['date'])}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            ...List.generate(3, (row) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (col) => Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    game['board'][row][col],
                                    style: TextStyle(
                                      color: game['board'][row][col] == 'X'
                                          ? Colors.blue
                                          : Colors.pink,
                                    ),
                                  ),
                                ),
                              )),
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildScoreCard(String title, int score, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 253, 251, 251),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
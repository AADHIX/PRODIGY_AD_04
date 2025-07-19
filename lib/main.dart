// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.pacificoTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _showManualButton = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward().then((_) {
        if (mounted) {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EntryScreen()),
        );
        }
      });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _controller.isAnimating) {
        setState(() => _showManualButton = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/game_splash.json',
              controller: _controller,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'Tic Tac Toe',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            if (_showManualButton) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const EntryScreen()),
                ),
                child: const Text('Enter Game'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              _buildTitle(),
              const SizedBox(height: 20),
              _buildSubtitle(),
              const Spacer(),
              _buildGameLogo(),
              const Spacer(),
              _buildStartButton(context),
              const SizedBox(height: 20),
              _buildHowToPlayButton(context),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.deepPurple.shade900,
          Colors.indigo.shade900,
          Colors.black,
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.purpleAccent, Colors.blueAccent],
        stops: [0.3, 0.7],
      ).createShader(bounds),
      child: Text(
        ' TIC TAC TOE',
        style: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'version ad.01',
      style: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.white70,
      ),
    );
  }

  Widget _buildGameLogo() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/tictactoe.png',
        height: 200,
        width: 200,
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateToGameScreen(context),
      style: _buildButtonStyle(),
      child: Text(
        'START GAME',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.purpleAccent, width: 2),
      ),
      shadowColor: Colors.purpleAccent.withOpacity(0.5),
      elevation: 10,
    );
  }

  void _navigateToGameScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  Widget _buildHowToPlayButton(BuildContext context) {
    return TextButton(
      onPressed: () => _showHowToPlayDialog(context),
      child: Text(
        'HOW TO PLAY',
        style: GoogleFonts.rubik(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
    );
  }

  void _showHowToPlayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade900,
        title: const Text('How to Play', style: TextStyle(color: Colors.white)),
        content: const Text(
          'The classic Tic Tac Toe game with a attractive twist:\n\n'
          '1. Players alternate placing X and O marks\n'
          '2. First to get 3 in a row wins\n'
          '3. Can be horizontal, vertical or diagonal\n'
          '4. Tap any square to place your mark\n'
          '5. Press New Game to reset',
          style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!', style: TextStyle(color: Color.fromARGB(255, 59, 103, 245))),
          ),
        ],
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
  bool isXTurnFirst = true;

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
      currentPlayer = isXTurnFirst ? 'X' : 'O';
      winner = '';
      gameOver = false;
      isXTurnFirst = !isXTurnFirst;
      _confettiController.stop();
    });
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && !gameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        
        if (checkWin(row, col)) {
          _handleWin();
        } else if (isBoardFull()) {
          _handleDraw();
        } else {
          _switchPlayer();
        }
      });
    }
  }

  void _handleWin() {
    winner = currentPlayer;
    gameOver = true;
    if (winner == 'X') {
      xWins++;
    } else {
      oWins++;
    }
    _confettiController.play();
    _addToHistory(winner);
  }

  void _handleDraw() {
    gameOver = true;
    draws++;
    _addToHistory('Draw');
  }

  void _switchPlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
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
    return _checkRow(row) || _checkColumn(col) || _checkDiagonals(row, col);
  }

  bool _checkRow(int row) {
    return board[row][0] == currentPlayer && 
           board[row][1] == currentPlayer && 
           board[row][2] == currentPlayer;
  }

  bool _checkColumn(int col) {
    return board[0][col] == currentPlayer && 
           board[1][col] == currentPlayer && 
           board[2][col] == currentPlayer;
  }

  bool _checkDiagonals(int row, int col) {
    return (row == col && _checkMainDiagonal()) || 
           (row + col == 2 && _checkAntiDiagonal());
  }

  bool _checkMainDiagonal() {
    return board[0][0] == currentPlayer && 
           board[1][1] == currentPlayer && 
           board[2][2] == currentPlayer;
  }

  bool _checkAntiDiagonal() {
    return board[0][2] == currentPlayer && 
           board[1][1] == currentPlayer && 
           board[2][0] == currentPlayer;
  }

  bool isBoardFull() {
    for (var row in board) {
      for (var cell in row) {
        if (cell.isEmpty) return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(context),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: _buildBackgroundDecoration(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildScoreBoard(),
                    _buildGameStatus(),
                    _buildGameBoard(),
                    _buildResetButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildConfetti(),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: _buildAppBarTitle(),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildAppBarTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.purpleAccent, Colors.blueAccent],
      ).createShader(bounds),
      child: const Text(
        ' Tic Tac Toe',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.deepPurple.shade900.withOpacity(0.8),
          Colors.black,
        ],
      ),
    );
  }

  Widget _buildScoreBoard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildScoreCard('X WINS', xWins, Colors.purpleAccent),
          _buildScoreCard('DRAWS', draws, Colors.white70),
          _buildScoreCard('O WINS', oWins, Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildGameStatus() {
    return Padding(
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
          style: _getStatusTextStyle(),
        ),
      ),
    );
  }

  TextStyle _getStatusTextStyle() {
    final color = gameOver
        ? winner.isNotEmpty
            ? winner == 'X'
                ? Colors.purpleAccent
                : Colors.blueAccent
            : Colors.white70
        : currentPlayer == 'X'
            ? Colors.purpleAccent
            : Colors.blueAccent;

    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
      shadows: [
        if (!gameOver || winner.isNotEmpty)
          BoxShadow(
            color: (currentPlayer == 'X' 
                ? Colors.purpleAccent 
                : Colors.blueAccent).withOpacity(0.7),
            blurRadius: 10,
            spreadRadius: 2,
          ),
      ],
    );
  }

  Widget _buildGameBoard() {
    return Container(
      decoration: _buildBoardDecoration(),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: List.generate(3, (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (col) {
              return _buildBoardCell(row, col);
            }),
          );
        }),
      ),
    );
  }

  BoxDecoration _buildBoardDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.deepPurple.shade800,
          Colors.blue.shade800,
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 1,
      ),
    );
  }

  Widget _buildBoardCell(int row, int col) {
    return GestureDetector(
      onTap: () => makeMove(row, col),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        height: 80,
        margin: const EdgeInsets.all(4),
        decoration: _buildCellDecoration(row, col),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              board[row][col],
              key: ValueKey('$row$col${board[row][col]}'),
              style: _getCellTextStyle(row, col),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCellDecoration(int row, int col) {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 1,
      ),
      boxShadow: [
        if (board[row][col].isNotEmpty)
          BoxShadow(
            color: (board[row][col] == 'X'
                ? Colors.purpleAccent
                : Colors.blueAccent)
                .withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
      ],
    );
  }

  TextStyle _getCellTextStyle(int row, int col) {
    return TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: board[row][col] == 'X'
          ? Colors.purpleAccent
          : Colors.blueAccent,
      shadows: [
        if (board[row][col].isNotEmpty)
          BoxShadow(
            color: (board[row][col] == 'X'
                ? Colors.purpleAccent
                : Colors.blueAccent)
                .withOpacity(0.7),
            blurRadius: 10,
            spreadRadius: 2,
          ),
      ],
    );
  }

 Widget _buildResetButton() {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 10),
    child: ElevatedButton.icon(
      onPressed: resetGame,
      icon: const Icon(Icons.refresh),
      label: const Text(
        'New Game',
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      style: _buildResetButtonStyle(),
    ),
  );
}

  ButtonStyle _buildResetButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Color.fromARGB(255, 226, 91, 250),
          width: 2,
        ),
      ),
      shadowColor: const Color.fromARGB(255, 149, 28, 170).withOpacity(0.5),
      elevation: 10,
    );
  }

  Widget _buildConfetti() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [
          Colors.purpleAccent,
          Colors.blueAccent,
          Colors.white,
          Colors.pinkAccent,
          Colors.cyanAccent
        ],
        createParticlePath: (size) {
          final path = Path();
          path.addOval(Rect.fromCircle(
            center: Offset.zero,
            radius: size.width / 2,
          ));
          return path;
        },
      ),
    );
  }

  void _showGameHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade900.withOpacity(0.9),
        title: const Text('Recent Games', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: double.maxFinite,
          child: _gameHistory.isEmpty
              ? const Text('No games played yet', style: TextStyle(color: Colors.white70))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _gameHistory.length,
                  itemBuilder: (context, index) {
                    final game = _gameHistory[index];
                    return _buildHistoryItem(game);
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.purpleAccent)),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> game) {
    return Card(
      color: Colors.black.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${game['result']} - ${_formatDate(game['date'])}',
              style: _getHistoryItemTextStyle(game['result']),
            ),
            const SizedBox(height: 8),
            ...List.generate(3, (row) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (col) => _buildHistoryCell(game, row, col)),
            )),
          ],
        ),
      ),
    );
  }

  TextStyle _getHistoryItemTextStyle(String result) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: result == 'X'
          ? Colors.purpleAccent
          : result == 'O'
              ? Colors.blueAccent
              : Colors.white70,
    );
  }

  Widget _buildHistoryCell(Map<String, dynamic> game, int row, int col) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          game['board'][row][col],
          style: _getHistoryCellTextStyle(game['board'][row][col]),
        ),
      ),
    );
  }

  TextStyle _getHistoryCellTextStyle(String cellValue) {
    return TextStyle(
      color: cellValue == 'X'
          ? Colors.purpleAccent
          : Colors.blueAccent,
      shadows: [
        if (cellValue.isNotEmpty)
          BoxShadow(
            color: (cellValue == 'X'
                ? Colors.purpleAccent
                : Colors.blueAccent)
                .withOpacity(0.5),
            blurRadius: 5,
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildScoreCard(String title, int score, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
              shadows: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
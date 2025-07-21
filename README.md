# Neon Tic Tac Toe 🎮✨

A modern Flutter implementation of the classic Tic Tac Toe game with neon aesthetics, animations, and confetti celebrations.

## Overview
A visually stunning Tic Tac Toe game featuring smooth animations, responsive design, and game history tracking, built with Flutter using clean architecture principles.

## Features
- 🌈 Neon-themed UI with glowing effects
- 🎉 Confetti celebration on winning
- 📊 Score tracking (Wins/Draws)
- ⏳ Game history with board snapshots
- 🔄 Alternating starting player
- 📱 Responsive design for all screen sizes
- 🎬 Splash screen with Lottie animation

## Architecture
lib/
├── main.dart # App entry point
├── splash_screen.dart # Animated loading screen
├── entry_screen.dart # Game introduction screen
└── game_screen.dart # Core game logic and UI

text

### Widget Tree Hierarchy
MaterialApp
├── SplashScreen (Stateful)
│ └── Lottie Animation
├── EntryScreen (Stateless)
│ ├── Gradient Background
│ ├── Title/Subtitle
│ ├── Game Logo
│ └── Action Buttons
└── GameScreen (Stateful)
├── AppBar
├── Score Board
├── Game Board (3x3 Grid)
└── Control Buttons

text


## Game Logic
- **State Management**: Uses `setState` for local state
- **Win Detection**: Checks rows, columns, and diagonals
- **Turn Management**: Alternates between X and O
- **History**: Stores last 5 game states

## Installation
1. Ensure Flutter is installed
2. Clone this repository
3. Run:
bash
   ###flutter pub get
   ###flutter run

## SCreenshot 
###	Entry Screen	Gameplay

<img width="221" height="463" alt="Screenshot 2025-07-21 112414" src="https://github.com/user-attachments/assets/d0a7efdb-0045-4920-80c0-08b11fa7fc0a" />

###   Game Play Screen

<img width="215" height="463" alt="Screenshot 2025-07-21 112434" src="https://github.com/user-attachments/assets/80223ff1-207e-49d4-aa47-794829c60032" />

### Game Play Screen & cconfetti celebrations.

<img width="217" height="465" alt="Screenshot 2025-07-21 112504" src="https://github.com/user-attachments/assets/bde4f50f-3877-44e0-8b88-00afa903bf14" />


Contribution
Feel free to submit issues or PRs for:

Additional animations

Enhanced AI opponent

Multiplayer support

New themes

License
MIT License - See LICENSE for details

text

Key points about this README:
1. **Concise Overview**: Captures essence in minimal words
2. **Visual Hierarchy**: Clear section organization
3. **Technical Details**: Includes architecture and widget tree
4. **Practical Info**: Installation and dependencies
5. **Visual Aids**: Placeholders for screenshots
6. **Future Scope**: Suggests improvement areas



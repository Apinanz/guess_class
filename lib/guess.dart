import 'dart:io';
import 'dart:math';

void main() {
  var game;
  var maxRandom;
  print("╔═════════════════════════════════════════════════════");
  print("║                  GUESS THE NUMBER");
  print("║─────────────────────────────────────────────────────");
  do {
    stdout.write('║ Enter max number you want to guess: ');
    maxRandom = stdin.readLineSync();
    game = Game(maxRandom: maxRandom);
    print("║─────────────────────────────────────────────────────");
  } while (!game.status);
  var isCorrect = false;
  do {
    stdout.write('║ Guess the number between 1 and $maxRandom: ');
    var input = stdin.readLineSync();
    int? guess = int.tryParse(input!);
    if (guess != null) {
      Map resultMap = game.doGuess(guess);
      isCorrect = resultMap['isCorrect'];
      var message = resultMap['text'];
      print('║ ➜ $guess' + message);
      print("║─────────────────────────────────────────────────────");
    }
  } while (!isCorrect);
  var total = game.getTotalGuesses();
  print('║ Total guesses: $total ✨ ');
  print("║─────────────────────────────────────────────────────");
  print("║                 ♣️THE END  ♣️");
  print("╚═════════════════════════════════════════════════════");
}

class Game {
  late int answer;
  bool status = false;
  int total = 0;
  static const List feedbackList = [
    {
      'text': ' : TOO HIGH! ▲',
      'isCorrect': false,
    },
    {
      'text': ' : TOO LOW! ▼',
      'isCorrect': false,
    },
    {
      'text': ' : CORRECT ✔',
      'isCorrect': true,
    },
  ];

  Game({var maxRandom}) {
    int? maxValue = int.tryParse(maxRandom!);
    if (maxValue != null) {
      this.answer = Random().nextInt(maxValue) + 1;
      status = true;
    }
  }

  Map doGuess(int num) {
    if (num > this.answer) {
      total++;
      return feedbackList[0];
    } else if (num < this.answer) {
      total++;
      return feedbackList[1];
    } else {
      total++;
      return feedbackList[2];
    }
  }

  int getTotalGuesses() {
    return this.total;
  }
}

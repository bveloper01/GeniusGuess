// Let's play Bulls and Cows!

class BullsAndCows {
  String secretNumber;
  int maxGuesses;
  List<Guess> pastGuesses;

  BullsAndCows(this.secretNumber, this.maxGuesses);

  Guess tryAGuess(String guessedNumber) {
    if (guessedNumber.length != 4 || !allDigitsDifferent(guessedNumber)) {
      throw InvalidGuessException();
    }

    int bullsCount = 0;
    int cowsCount = 0;

    for (int i = 0; i < 4; i++) {
      if (guessedNumber[i] == secretNumber[i]) {
        bullsCount++;
      } else if (secretNumber.contains(guessedNumber[i])) {
        cowsCount++;
      }
    }

    Guess guess = Guess(guessedNumber, bullsCount, cowsCount);
    pastGuesses.add(guess);
    return guess;
  }

  bool allDigitsDifferent(String number) {
    return number.split('').toSet().length == 4;
  }

  bool isGameFinished() {
    return pastGuesses.length >= maxGuesses || pastGuesses.last.bullsCount == 4;
  }

  bool didPlayerWin() {
    return pastGuesses.isNotEmpty && pastGuesses.last.bullsCount == 4;
  }
}

class Guess {
  String guessedNumber;
  int bullsCount;
  int cowsCount;

  Guess(this.guessedNumber, this.bullsCount, this.cowsCount);
}

// Let's play!
void startTheGame() {
  String player1SecretNumber = askForValidNumber("Player 1, enter your secret number");
  String player2SecretNumber = askForValidNumber("Player 2, enter your secret number");

  BullsAndCows game1 = BullsAndCows(player1SecretNumber, 10);
  BullsAndCows game2 = BullsAndCows(player2SecretNumber, 10);

  while (!game1.isGameFinished() && !game2.isGameFinished()) {
    String player1Guess = askForValidNumber("Player 1, make your guess");
    Guess result1 = game2.tryAGuess(player1Guess);
    showGuessResult(result1);

    if (game2.isGameFinished()) break;

    String player2Guess = askForValidNumber("Player 2, make your guess");
    Guess result2 = game1.tryAGuess(player2Guess);
    showGuessResult(result2);
  }

  announceWinner(game1, game2);
}

// Helper functions
String askForValidNumber(String prompt) {
  // Ask for input and make sure it's valid
}

void showGuessResult(Guess guess) {
  // Tell the player how many bulls and cows they got
}

void announceWinner(BullsAndCows game1, BullsAndCows game2) {
  // Declare the winner or a draw
}
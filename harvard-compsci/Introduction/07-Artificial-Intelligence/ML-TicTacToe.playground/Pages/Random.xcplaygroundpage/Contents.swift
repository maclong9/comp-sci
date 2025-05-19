import GameplayKit

/*:
  # Random AI
 
 This defines a simple machine learning model that plays the game randomly.
*/
public class RandomAI: TicTacToeAI {
  public func makeMove(board: [Player?]) -> Int? {
    let emptyIndices = board.enumerated().compactMap { index, player in
      return player == nil ? index : nil
    }
    return emptyIndices.randomElement()
  }
}

let game = TicTacToe(
  aiOne: RandomAI(),
  aiTwo: RandomAI()
).simulateGame()

//: [Next](@next)

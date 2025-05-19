/*:
 # Tic Tac Toe Machine Learning
 
 This is a very basic machine learning model that plays randomly, therefore it is not an optimised machine learning model. However it 
*/

import Foundation
import GameplayKit

enum Player {
  case x
  case o
}

enum GameState {
  case inProgress
  case draw
  case won(Player)
}

class TicTacToe {
  private(set) var board: [Player?] = Array(repeating: nil, count: 9)
  
  func makeMove(at index: Int, player: Player) -> Bool {
    guard index >= 0 && index < 9 && board[index] == nil else {
      return false
    }
    board[index] = player
    return true
  }
  
  func checkGameState() -> GameState {
    let winningCombinations: [[Int]] = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],  // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8],  // columns
      [0, 4, 8], [2, 4, 6],  // diagonals
    ]
    
    for combination in winningCombinations {
      if let player = board[combination[0]],
         board[combination[1]] == player,
         board[combination[2]] == player
      {
        return .won(player)
      }
    }
    
    if board.contains(nil) {
      return .inProgress
    } else {
      return .draw
    }
  }
  
  func printBoard() {
    for i in 0..<9 {
      if let player = board[i] {
        print(player == .x ? "X" : "O", terminator: "")
      } else {
        print(".", terminator: "")
      }
      if i % 3 == 2 { print() }
    }
  }
  
  func printBoardArray() {
    print(board.map { player in
      if let player = player {
        return player == .x ? "X" : "O"
      } else {
        return "."
      }
    })
  }
}

class RandomAI {
  func makeMove(board: [Player?]) -> Int? {
    let emptyIndices = board.enumerated().compactMap { index, player in
      return player == nil ? index : nil
    }
    return emptyIndices.randomElement()
  }
}

let game = TicTacToe()
let ai1 = RandomAI()
let ai2 = RandomAI()

var currentPlayer: Player = .x

while true {
  let move: Int?
  if currentPlayer == .x {
    move = ai1.makeMove(board: game.board)
  } else {
    move = ai2.makeMove(board: game.board)
  }
  
  if let move = move {
    game.makeMove(at: move, player: currentPlayer)
    game.printBoard()
    print()
    
    let state = game.checkGameState()
    switch state {
      case .won(let player):
        print("\(player == .x ? "X" : "O") wins!")
        break
      case .draw:
        print("It's a draw!")
        break
      case .inProgress:
        currentPlayer = (currentPlayer == .x) ? .o : .x
    }
  } else {
    print("No more moves available!")
    break
  }
  
  if case .inProgress = game.checkGameState() {
    continue
  } else {
    break
  }
}

print(game.printBoardArray())

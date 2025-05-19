import Foundation

public enum Player {
  case x
  case o
}

public enum GameState {
  case inProgress
  case draw
  case won(Player)
}

public protocol TicTacToeAI {
  func makeMove(board: [Player?]) -> Int?
}

public class TicTacToe {
  private(set) var board: [Player?] = Array(repeating: nil, count: 9)
  private var currentPlayer: Player = .x
  private var aiOne: TicTacToeAI
  private var aiTwo: TicTacToeAI
  
  public init(aiOne: TicTacToeAI, aiTwo: TicTacToeAI) {
    self.aiOne = aiOne
    self.aiTwo = aiTwo
  }
  
  public func simulateGame() -> (winner: Player?, array: [String]) {
    while true {
      let move: Int?
      if currentPlayer == .x {
        move = aiOne.makeMove(board: board)
      } else {
        move = aiTwo.makeMove(board: board)
      }
      
      if let move = move {
        makeMove(at: move, player: currentPlayer)
        printBoard()
        print()
        
        let state = checkGameState()
        switch state {
          case .won(let player):
            print("\(player == .x ? "X" : "O") wins!")
            return (player, boardArray())
          case .draw:
            print("It's a draw!")
            return (nil, boardArray())
          case .inProgress:
            currentPlayer = (currentPlayer == .x) ? .o : .x
        }
      } else {
        print("No more moves available!")
        return (nil, boardArray())
      }
    }
  }
  
  public func makeMove(at index: Int, player: Player) {
    guard index >= 0 && index < 9 && board[index] == nil else {
      return
    }
    board[index] = player
  }
  
  public func checkGameState() -> GameState {
    let winningCombinations: [[Int]] = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6]             // diagonals
    ]
    
    for combination in winningCombinations {
      if let player = board[combination[0]],
         player == board[combination[1]],
         player == board[combination[2]] {
        return .won(player)
      }
    }
    
    return board.contains(nil) ? .inProgress : .draw
  }
  
  public func printBoard() {
    for i in 0..<9 {
      if let player = board[i] {
        print(player == .x ? "X" : "O", terminator: "")
      } else {
        print(".", terminator: "")
      }
      if i % 3 == 2 { print() }
    }
  }
  
  public func boardArray() -> [String] {
    return board.map { $0.map { $0 == .x ? "X" : $0 == .o ? "O" : "." } ?? "." }
  }
}

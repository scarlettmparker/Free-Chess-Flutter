import 'package:free_chess_flutter/game/chess_piece.dart';
import 'package:collection/collection.dart';

class ChessGame {
  final List<ChessPiece> whitePieces;
  final List<ChessPiece> blackPieces;
  List<ChessPiece> get pieces => [...whitePieces, ...blackPieces].toList();

  PieceColor turn = PieceColor.white;

  ChessGame(this.whitePieces, this.blackPieces);

  ChessPiece? pieceOfTile(int x, int y) => pieces.firstWhereOrNull((p) => p.square.x == x && p.square.y == y);

  factory ChessGame.newGame() {
    return ChessGame(
      [
        ChessPiece(PieceColor.white, Square(2, 0), PieceType.bishop),
        ChessPiece(PieceColor.white, Square(5, 0), PieceType.bishop),

        ChessPiece(PieceColor.white, Square(0, 0), PieceType.rook),
        ChessPiece(PieceColor.white, Square(7, 0), PieceType.rook),

        ChessPiece(PieceColor.white, Square(4, 0), PieceType.king),
        ChessPiece(PieceColor.white, Square(3, 0), PieceType.queen),

        ChessPiece(PieceColor.white, Square(6, 0), PieceType.knight),
        ChessPiece(PieceColor.white, Square(1, 0), PieceType.knight),

        ChessPiece(PieceColor.white, Square(0, 1), PieceType.pawn),
        ChessPiece(PieceColor.white, Square(1, 1), PieceType.pawn),
        ChessPiece(PieceColor.white, Square(2, 1), PieceType.pawn),
        ChessPiece(PieceColor.white, Square(3, 1), PieceType.pawn),
        ChessPiece(PieceColor.white, Square(4, 1), PieceType.pawn),
        ChessPiece(PieceColor.white, Square(5, 1), PieceType.pawn),
        ChessPiece(PieceColor.white, Square(6, 1), PieceType.pawn),
        ChessPiece(PieceColor.white, Square(7, 1), PieceType.pawn),
      ],
      [
        ChessPiece(PieceColor.black, Square(2, 7), PieceType.bishop),
        ChessPiece(PieceColor.black, Square(5, 7), PieceType.bishop),

        ChessPiece(PieceColor.black, Square(0, 7), PieceType.rook),
        ChessPiece(PieceColor.black, Square(7, 7), PieceType.rook),

        ChessPiece(PieceColor.black, Square(4, 7), PieceType.king),
        ChessPiece(PieceColor.black, Square(3, 7), PieceType.queen),

        ChessPiece(PieceColor.black, Square(6, 7), PieceType.knight),
        ChessPiece(PieceColor.black, Square(1, 7), PieceType.knight),

        ChessPiece(PieceColor.black, Square(0, 6), PieceType.pawn),
        ChessPiece(PieceColor.black, Square(1, 6), PieceType.pawn),
        ChessPiece(PieceColor.black, Square(2, 6), PieceType.pawn),
        ChessPiece(PieceColor.black, Square(3, 6), PieceType.pawn),
        ChessPiece(PieceColor.black, Square(4, 6), PieceType.pawn),
        ChessPiece(PieceColor.black, Square(5, 6), PieceType.pawn),
        ChessPiece(PieceColor.black, Square(6, 6), PieceType.pawn),
        ChessPiece(PieceColor.black, Square(7, 6), PieceType.pawn),
      ],
    );
  }

  PieceColor getTurn() {
    return turn;
  }

  void setTurn(PieceColor turn) {
    this.turn = turn;
  }
}
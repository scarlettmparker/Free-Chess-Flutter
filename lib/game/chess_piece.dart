import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

enum PieceColor{
  black,
  white
}

enum PieceType{
  pawn,
  knight,
  bishop,
  rook,
  queen,
  king
}

class Square {
  final int x, y;
  Square(this.x, this.y);

  @override
  String toString() => "(${x.toString()}, ${y.toString()})";
}

class ChessPiece {
  final PieceColor pieceColor;
  final PieceType type;
  Square square;

  // generates file string based on piece color & type
  String get fileName => "images/${pieceColor.toString().split(".").last}_${type.name}.png";

  ChessPiece(
      this.pieceColor,
      this.square,
      this.type);

  // useful debugging stuff
  @override
  String toString() => "${type.name}(${square.x}, ${square.y})";

  // more useful debugging stuff
  String coordinates(Square square) {
    String xCord = String.fromCharCode(square.x+65);
    String yCord = (square.y + 1).toString();
    return "$xCord$yCord";
  }

  _readFile() async {
    try {
      String response = await rootBundle.loadString(
          'piece-maps/${type.name}.txt');
      return response;
    } catch(e) {
      return "File failed to read!";
    }
  }

  // check if piece can move
  bool canMove(Square from, Square to) {
    print(type.name);
    _readFile().then((value){
      print(value);
    });

    if (type == PieceType.pawn) {
      return true;
    }
    return false;
  }

  PieceColor getColor() {
    return pieceColor;
  }

  Square getSquare() {
    return square;
  }

  void setSquare(Square square) {
    this.square = square;
  }
}
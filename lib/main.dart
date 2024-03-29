import 'package:flutter/material.dart';
import 'package:free_chess_flutter/game/chess_game.dart';
import 'package:free_chess_flutter/game/chess_piece.dart';
import 'dart:math';

void main() {
  runApp(const FreeMain());
}

class FreeMain extends StatelessWidget {
  const FreeMain({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const HomeLayout(),
        backgroundColor: const Color(0xFF393939),
        // settings button, here so it doesn't interfere with main column
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: const Color(0xFF656565),
          child: const Text('⚙'),
        ),
      ),
    );
  }
}

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeState();
}

class _HomeState extends State<HomeLayout> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    // styles for text and buttons
    const TextStyle textStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 42);
    const TextStyle buttonTextStyle = TextStyle(color: Color(0xFFFFFFFF), fontSize: 16, fontFamily: "Montserrat");

    // styles for buttons
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: buttonTextStyle,
    padding: const EdgeInsets.all(20), backgroundColor: const Color(0xFF656565));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                // title
                onPressed: () {
                  if (fav) {
                    setState(() => fav=false);
                  } else {
                    setState(() => fav=true);
                  }
                },
                child: Text(
                  fav ? 'Chess 2' : 'Free Chess',
                  style: textStyle,
                ),
              ),

              const Padding(
                // load image and ensure it displays properly
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Image(image: AssetImage('assets/images/icon_draw.png'),
                width: 45, height: 45),
              ),
            ],
          )
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Game()));
            },
            child: const Text('START GAME'),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ElevatedButton(
            style: style,
            onPressed: () {

            },
            child: const Text('LOAD GAME'),
          ),
        ),
      ],
    );
  }
}

class Game extends StatelessWidget{
  final ChessGame game = ChessGame.newGame();
  List <ChessPiece> get pieces => game.pieces;
  Game({super.key});

  @override
  Widget build(BuildContext context) {
    // get maximum and minimum tile sizes based on screen size
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final double minTileSize = width / 8.5;
    final double maxTileSize;

    if (width > 1250) {
      maxTileSize = height / 11.0;
    } else {
      maxTileSize = height / 13.0;
    }

    // colours for tiles
    const Color darkTile = Color(0xFF8763B5);
    const Color lightTile = Color(0xFFF0DDF2);

    Color buildTileColor(int x, int y) {
      int value = x;
      if (y.isEven) {
        value++;
      }
      return value.isEven ? darkTile : lightTile;
    }

    Widget? buildChessPieces(int x, int y) {
      final piece = game.pieceOfTile(x, y);
      if (piece != null) {
        final child = Container(
          alignment: Alignment.center,
          child: Image.asset(
            // load piece graphics
            piece.fileName,
            width: min(maxTileSize, minTileSize),
            height: min(maxTileSize, minTileSize),
          ),
        );

        return Draggable<ChessPiece>(
          data: piece,
          feedback: child,
          childWhenDragging: const SizedBox.shrink(),
          child: child,
        );
      }
      return null;
    }

    // ensure UI is different for different devices
    MainAxisAlignment alignment() {
      // device friendly :3
      if (width <= 950) {
        return MainAxisAlignment.center;
      } else {
        return MainAxisAlignment.start;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF393939),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, width > 950 ? 50 : 0, 0, 0),
        child: Column(
          // center
          mainAxisAlignment: alignment(),
          children: [
            ...List.generate(8, (y) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(8, (x) => movePiece(buildTileColor, x, y,
                    maxTileSize, minTileSize, buildChessPieces, context),
                )
              ],
            ),).reversed,
          ],
        ),
      ),
    );
  }

  DragTarget<ChessPiece> movePiece(Color Function(int x, int y) buildTileColor, int x, int y,
      double maxTileSize, double minTileSize, Widget? Function(int x, int y) buildChessPieces, context) {
    return DragTarget<ChessPiece>(
      onAccept: (piece) {
        // get current square
        Square from = piece.getSquare();
        Square to = Square(x, y);
        // if current move & legal move
        print("from: " + from.toString());
        print("to: " + to.toString());
        if (piece.canMove(from, to) && game.getTurn() == piece.getColor()) {
          // move piece
          piece.setSquare(Square(x, y));
          if (from.x == to.x && from.y == to.y) {
            print("Bro's tryna not move his piece");
          } else {
            if (piece.getColor() == PieceColor.white) {
              // update turn
              game.setTurn(PieceColor.black);
            } else {
              game.setTurn(PieceColor.white);
            }
          }
          (context as Element).markNeedsBuild();
        }
      },
      builder:(context, data, rejects) => Container(
        decoration: BoxDecoration(
          // determine colour based on coordinate
          color: buildTileColor(x, y),
        ),
        // whichever fits better on screen
        width: min(maxTileSize, minTileSize),
        height: min(maxTileSize, minTileSize),
        child: buildChessPieces(x, y),
      ),
    );
  }
}
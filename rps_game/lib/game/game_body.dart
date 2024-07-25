import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:rps_game/game/enum.dart';
import 'package:rps_game/game/widget/cpu_input.dart';
import 'package:rps_game/game/widget/game_result.dart';
import 'package:rps_game/game/widget/user_input.dart';

class GameBody extends StatefulWidget {
  const GameBody({super.key});

  @override
  State<GameBody> createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  late bool isDone; //게임 진행 여부
  InputType? _userInput;
  late InputType _cpuInput;

  @override
  void initState() {
    super.initState();
    isDone = false;
    setCpuInput();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: CpuInput(isDone: isDone, cpuInput: _cpuInput)),
        Expanded(child: GameResult(isDone: isDone, result: getResult(), callback: reset,)),
        Expanded(
            child: UserInput(
          isDone: isDone,
          callback: setUserInput,
          userInput: _userInput,
        )),
      ],
    );
  }

  void setUserInput(InputType userInput) {
    setState(() {
      isDone = true;
      _userInput = userInput;
    });
  }

  void setCpuInput() {
    final random = Random();
    _cpuInput = InputType.values[random.nextInt(3)];
  }

  void reset() {
    setState(() {
      isDone = false;
      setCpuInput();
    });
  }

  Result? getResult() {
    if (_userInput == null) return null;

    const winConditions = {
      InputType.rock: InputType.scissors,
      InputType.paper: InputType.rock,
      InputType.scissors: InputType.paper
    };

    if (_userInput == _cpuInput) {
      return Result.draw;
    }

    if (winConditions[_userInput] == _cpuInput) {
      return Result.playerWin;
    } else {
      return Result.cpuWin;
    }
  }
}

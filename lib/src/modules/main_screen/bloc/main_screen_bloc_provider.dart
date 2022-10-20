import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';

class MainScreenBlocProvider extends StatelessWidget {
  final Widget child;

  const MainScreenBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenBloc(
        tickersRepository: context.read<ITickersRepository>(),
      ),
      child: child,
    );
  }
}

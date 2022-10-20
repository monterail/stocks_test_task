import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/config/api/api_client.dart';
import 'package:template/src/repositories/tickers_repository/tickers_repository.dart';

class ServicesProvider extends StatelessWidget {
  final Widget child;

  const ServicesProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>(
          create: (context) => const ApiClient(),
        ),
        RepositoryProvider<ITickersRepository>(
          create: (context) => TickersRepository(
            apiClient: context.read<ApiClient>().client,
            getTickerByName: getTickerByName,
          ),
        ),
      ],
      child: child,
    );
  }
}

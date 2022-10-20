import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc_provider.dart';
import 'package:template/src/modules/main_screen/widgets/custom_app_bar.dart';

class MainScreenWidget extends StatelessWidget implements AutoRouteWrapper {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const KeyboardDismisser(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Text('test'),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MainScreenBlocProvider(child: this);
  }
}

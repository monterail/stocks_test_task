import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc_provider.dart';
import 'package:template/src/modules/main_screen/widgets/custom_app_bar.dart';
import 'package:template/src/modules/stock_module/view/stock_module_view.dart';

class MainScreenWidget extends StatelessWidget implements AutoRouteWrapper {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        body: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.selectedTicker == null
                  ? Center(
                      child: SvgPicture.asset('assets/illustrations/main.svg'),
                    )
                  : const StockModuleView(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MainScreenBlocProvider(child: this);
  }
}

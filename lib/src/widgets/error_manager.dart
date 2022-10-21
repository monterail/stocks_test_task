import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/utils/bloc_exception.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void _showErrorSnackbar(
  BuildContext context, {
  required String errorText,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorText),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50),
        elevation: 30,
      ),
    );

class ErrorManager<B extends StateStreamable<S>, S> extends StatelessWidget {
  final Widget child;

  const ErrorManager({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, dynamic state) {
        final BlocError error = state?.error ?? BlocError.none;

        if (error != BlocError.none) {
          _showErrorSnackbar(
            context,
            errorText: error.localizedText(
              AppLocalizations.of(context)!,
            ),
          );
        }
      },
      child: child,
    );
  }
}

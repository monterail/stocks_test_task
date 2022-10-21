import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlocException with EquatableMixin implements Exception {
  final String cause;

  const BlocException(this.cause);

  @override
  List<Object?> get props => [cause];
}

enum BlocError {
  none,
  unauthorized,
  tooManyRequests,
  serverError,
}

extension StringValuesForError on BlocError {
  String get text {
    switch (this) {
      case BlocError.none:
        return 'none';
      case BlocError.unauthorized:
        return 'Api key is not valid';
      case BlocError.tooManyRequests:
        return 'Too many requests';
      case BlocError.serverError:
        return 'Server error';
    }
  }

  String localizedText(AppLocalizations appLocalizations) {
    switch (this) {
      case BlocError.unauthorized:
        return appLocalizations.unauthorized;
      case BlocError.tooManyRequests:
        return appLocalizations.tooManyRequests;
      case BlocError.none:
        return 'none';
      case BlocError.serverError:
        return 'Server error';
    }
  }
}

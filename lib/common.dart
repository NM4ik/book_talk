/// A library providing shared utilities, constants, and extensions
/// used across the application.
///
/// The `common` library includes reusable components and helpers
/// that support various features within the app. It is designed
/// to centralize common functionality for easier maintenance and
/// consistency.
library common;

export 'src/common/constants/config.dart';
export 'src/common/model/app_metadata.dart';

/// Routes
export 'src/common/router/guards/home_guard.dart';
export 'src/common/router/guards/authentication_guard.dart';
export 'src/common/router/routes.dart';

/// Utils
export 'src/common/utils/extensions/build_context_extension.dart';
export 'src/common/utils/interface/closable.dart';
export 'src/common/utils/mixins/set_state_mixin.dart';
export 'src/common/utils/preferences_storage/preferences_entry.dart';
export 'src/common/utils/preferences_storage/preferences_storage.dart';
export 'src/common/utils/app_bloc_observer.dart';
export 'src/common/utils/logger.dart';

/// Widgets
export 'src/common/widgets/window_size.dart';

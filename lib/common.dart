/// Common library contains all common components and utilities used throughout the BookTalk application.
library;

// Constants and configuration
export 'src/common/constants/config.dart';
export 'src/common/model/app_metadata.dart';
export 'src/common/model/room/room.dart';
export 'src/common/model/room/room_day_setting.dart';
export 'src/common/model/room/room_week_settings.dart';
export 'src/common/rest_api/auth/auth_client.dart';
export 'src/common/rest_api/auth/auth_refresh.dart';
export 'src/common/rest_api/auth/auth_storage.dart';
export 'src/common/rest_api/interceptors/log_interceptor.dart';
// REST API
export 'src/common/rest_api/rest_api.dart';
export 'src/common/router/guards/authentication_guard.dart';
export 'src/common/router/guards/home_guard.dart';
export 'src/common/router/router_mixin.dart';
// Routing
export 'src/common/router/routes.dart';
export 'src/common/utils/app_bloc_observer.dart';
// Utils
export 'src/common/utils/error_tracking.dart';
export 'src/common/utils/extensions/build_context_extension.dart';
export 'src/common/utils/logger.dart';
export 'src/common/utils/mixins/emittable_set_state_mixin.dart';
export 'src/common/utils/platform/platform_initialization.dart';
export 'src/common/utils/preferences_storage/preferences_entry.dart';
export 'src/common/utils/preferences_storage/preferences_storage.dart';
export 'src/common/widgets/bloc_builder.dart';
export 'src/common/widgets/image.dart';
export 'src/common/widgets/notifications.dart';
export 'src/common/widgets/overlay_popup.dart';
export 'src/common/widgets/shimmer.dart';
export 'src/common/widgets/user_avatar_widget.dart';
// Widgets
export 'src/common/widgets/window_size.dart';

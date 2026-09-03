import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/data/models/service_model.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/service_detail_screen.dart';
import '../../features/nearby/data/models/nearby_place_model.dart';
import '../../features/nearby/presentation/screens/favorite_places_screen.dart';
import '../../features/nearby/presentation/screens/nearby_screen.dart';
import '../../features/nearby/presentation/screens/place_details_screen.dart';
import '../../features/profile/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/weather/presentation/screens/weather_detail_screen.dart';
import '../shell/main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated =
          authState.status == AuthStatus.authenticated;
      final isInitial = authState.status == AuthStatus.initial;

      final authRoutes = [
        '/login',
        '/register',
        '/forgot-password',
      ];

      final isOnAuthRoute =
      authRoutes.contains(state.matchedLocation);

      if (isInitial) return null;
      if (!isAuthenticated && !isOnAuthRoute) return '/login';
      if (isAuthenticated && isOnAuthRoute) return '/home';

      return null;
    },
    routes: [

      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Settings
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Notifications
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),

      // Weather Detail
      GoRoute(
        path: '/weather',
        builder: (context, state) => const WeatherDetailScreen(),
      ),

      // Main Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [

          // Home Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'service/:id',
                    builder: (context, state) {
                      final service = state.extra as ServiceModel;
                      return ServiceDetailScreen(
                        serviceId: service.id,
                        title: service.title,
                        icon: service.icon,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Nearby Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/nearby',
                builder: (context, state) => const NearbyScreen(),
                routes: [
                  GoRoute(
                    path: 'place-details',
                    builder: (context, state) {
                      final place = state.extra as NearbyPlaceModel;
                      return PlaceDetailsScreen(place: place);
                    },
                  ),
                  GoRoute(
                    path: 'favorites',
                    builder: (context, state) =>
                    const FavoritePlacesScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
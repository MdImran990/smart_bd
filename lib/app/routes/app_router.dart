import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';

import '../../features/emergency/data/models/emergency_service_model.dart';
import '../../features/emergency/presentation/screens/emergency_details_screen.dart';
import '../../features/emergency/presentation/screens/emergency_screen.dart';

import '../../features/home/data/models/service_model.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/service_detail_screen.dart';

import '../../features/nearby/data/models/nearby_place_model.dart';
import '../../features/nearby/presentation/screens/favorite_places_screen.dart';
import '../../features/nearby/presentation/screens/nearby_screen.dart';
import '../../features/nearby/presentation/screens/place_details_screen.dart';

import '../../features/profile/presentation/screens/edit_profile_screen.dart';
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

      final isInitial =
          authState.status == AuthStatus.initial;

      final authRoutes = [
        '/login',
        '/register',
        '/forgot-password',
      ];

      final isOnAuthRoute =
      authRoutes.contains(state.matchedLocation);

      // এখনও authentication state check হচ্ছে
      if (isInitial) {
        return null;
      }

      // Login করা না থাকলে
      if (!isAuthenticated && !isOnAuthRoute) {
        return '/login';
      }

      // Login করা থাকলে auth page এ যেতে পারবে না
      if (isAuthenticated && isOnAuthRoute) {
        return '/home';
      }

      return null;
    },

    routes: [
      // ============================================================
      // AUTH ROUTES
      // ============================================================

      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),

      GoRoute(
        path: '/forgot-password',
        builder: (context, state) {
          return const ForgotPasswordScreen();
        },
      ),

      // ============================================================
      // PROFILE EXTRA ROUTES
      // ============================================================

      GoRoute(
        path: '/edit-profile',
        builder: (context, state) {
          return const EditProfileScreen();
        },
      ),

      GoRoute(
        path: '/settings',
        builder: (context, state) {
          return const SettingsScreen();
        },
      ),

      GoRoute(
        path: '/notifications',
        builder: (context, state) {
          return const NotificationsScreen();
        },
      ),

      // ============================================================
      // WEATHER
      // ============================================================

      GoRoute(
        path: '/weather',
        builder: (context, state) {
          return const WeatherDetailScreen();
        },
      ),

      // ============================================================
      // EMERGENCY
      // ============================================================

      GoRoute(
        path: '/emergency',
        builder: (context, state) {
          return const EmergencyScreen();
        },
        routes: [
          GoRoute(
            path: 'details',
            builder: (context, state) {
              final service =
              state.extra as EmergencyServiceModel;

              return EmergencyDetailsScreen(
                service: service,
              );
            },
          ),
        ],
      ),

      // ============================================================
      // MAIN BOTTOM NAVIGATION SHELL
      // ============================================================

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(
            navigationShell: navigationShell,
          );
        },

        branches: [
          // ========================================================
          // HOME
          // ========================================================

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return const HomeScreen();
                },
                routes: [
                  GoRoute(
                    path: 'service/:id',
                    builder: (context, state) {
                      final service =
                      state.extra as ServiceModel;

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

          // ========================================================
          // NEARBY
          // ========================================================

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/nearby',
                builder: (context, state) {
                  return const NearbyScreen();
                },
                routes: [
                  GoRoute(
                    path: 'place-details',
                    builder: (context, state) {
                      final place =
                      state.extra as NearbyPlaceModel;

                      return PlaceDetailsScreen(
                        place: place,
                      );
                    },
                  ),

                  GoRoute(
                    path: 'favorites',
                    builder: (context, state) {
                      return const FavoritePlacesScreen();
                    },
                  ),
                ],
              ),
            ],
          ),

          // ========================================================
          // PROFILE
          // ========================================================

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) {
                  return const ProfileScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
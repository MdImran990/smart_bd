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
import '../../features/nearby/presentation/screens/favorites_screen.dart';
import '../../features/nearby/presentation/screens/nearby_screen.dart';
import '../../features/nearby/presentation/screens/place_details_screen.dart';

import '../../features/profile/presentation/screens/profile_screen.dart';

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

      if (isInitial) return null;

      // User login না থাকলে
      if (!isAuthenticated && !isOnAuthRoute) {
        return '/login';
      }

      // User login থাকা অবস্থায় Login page এ গেলে
      if (isAuthenticated && isOnAuthRoute) {
        return '/home';
      }

      return null;
    },

    routes: [
      // ================= AUTH =================

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
        builder: (context, state) =>
        const ForgotPasswordScreen(),
      ),

      // ================= MAIN APP =================

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(
            navigationShell: navigationShell,
          );
        },

        branches: [
          // ================= HOME =================

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) =>
                const HomeScreen(),

                routes: [
                  GoRoute(
                    path: 'service/:id',
                    builder: (context, state) {
                      final extra =
                      state.extra as ServiceModel;

                      return ServiceDetailScreen(
                        serviceId: extra.id,
                        title: extra.title,
                        icon: extra.icon,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // ================= NEARBY =================

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/nearby',
                builder: (context, state) =>
                const NearbyScreen(),

                routes: [
                  // Place Details
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

                  // Favorites
                  GoRoute(
                    path: 'favorites',
                    builder: (context, state) =>
                    const FavoritesScreen(),
                  ),
                ],
              ),
            ],
          ),

          // ================= PROFILE =================

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) =>
                const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
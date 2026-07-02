import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/features/auth/view_models/auth_view_model.dart';
import '../ui/features/auth/views/login_screen.dart';
import '../ui/features/auth/views/register_screen.dart';
import '../ui/features/dashboard/views/dashboard_screen.dart';
import '../ui/features/events/views/create_event_screen.dart';
import '../ui/features/events/views/event_details_screen.dart';
import '../data/models/event.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final loggedIn = authState.value != null;
      final loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!loggedIn && !loggingIn) {
        return '/login';
      }
      if (loggedIn && loggingIn) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/create-event',
        builder: (context, state) => const CreateEventScreen(),
      ),
      GoRoute(
        path: '/event-details',
        builder: (context, state) {
          final event = state.extra as Event;
          return EventDetailsScreen(event: event);
        },
      ),
    ],
  );
});


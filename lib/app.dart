import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/features/cashflow/cash_flow_screen.dart';
import 'package:planora/features/home/home_screen.dart';
import 'package:planora/features/onboarding/onboarding_screen.dart';
import 'package:planora/features/plans/plan_form_screen.dart';
import 'package:planora/features/plans/plans_screen.dart';
import 'package:planora/features/portfolios/contributions_history_screen.dart';
import 'package:planora/features/portfolios/portfolio_detail_screen.dart';
import 'package:planora/features/portfolios/portfolio_form_screen.dart';
import 'package:planora/features/portfolios/portfolios_screen.dart';
import 'package:planora/features/profile/profile_screen.dart';
import 'package:planora/features/settings/settings_screen.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/features/splash/splash_screen.dart';
import 'package:planora/widgets/planora_widgets.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Halaman tidak ditemukan.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.go('/home'),
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, _) => '/home',
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/portfolios',
                builder: (context, state) => const PortfoliosScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/plans',
                builder: (context, state) => const PlansScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cashflow',
                builder: (context, state) => const CashFlowScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const ContributionsHistoryScreen(),
      ),
      GoRoute(
        path: '/portfolios/new',
        builder: (context, state) => const PortfolioFormScreen(),
      ),
      GoRoute(
        path: '/portfolios/:id',
        builder: (context, state) => PortfolioDetailScreen(
          portfolioId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/portfolios/:id/edit',
        builder: (context, state) => PortfolioFormScreen(
          portfolioId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/plans/new',
        builder: (context, state) => const PlanFormScreen(),
      ),
      GoRoute(
        path: '/plans/:id/edit',
        builder: (context, state) => PlanFormScreen(
          planId: state.pathParameters['id']!,
        ),
      ),
    ],
  );
});

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: PlanoraBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

class PlanoraApp extends ConsumerWidget {
  const PlanoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final profile = ref.watch(userProfileStreamProvider).value;
    ref.watch(hideAmountsProvider);

    final themeMode = switch (profile?.themePref) {
      'terang' => ThemeMode.light,
      'gelap' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    return MaterialApp.router(
      title: 'Planora',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}


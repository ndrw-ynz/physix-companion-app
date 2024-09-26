import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:physix_companion_app/widgets/teachers/teacher_form_widget.dart';
import 'commons.dart';
import 'firebase_options.dart';

import 'screens/admin/login/admin_login_screen.dart';
import 'screens/admin/sections/admin_sections_edit_screen.dart';
import 'screens/admin/login/admin_forgot_password_screen.dart';
import 'screens/admin/home/admin_home_screen.dart';
import 'screens/admin/sections/admin_sections_view_screen.dart';
import 'screens/admin/teachers/admin_teacher_add_screen.dart';
import 'screens/admin/teachers/admin_teacher_view_screen.dart';
import 'screens/admin/sections/admin_sections_add_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

final _router = GoRouter(
    initialLocation: "/",
    refreshListenable: authNotifier,
    redirect: (context, state) {
      print("State change detected");

      final bool isLoggedIn = authNotifier.isLoggedIn;
      final bool isLoading = authNotifier.isLoading;
      final String userRole = authNotifier.userRole;

      if (isLoading) {
        return null;
      }

      switch (userRole) {
        case "admin":
          if (isLoggedIn && state.matchedLocation == "/admin_login") {
            return "/admin_home";
          }
          break;
      }

      return null;
    },
    routes: [
      GoRoute(
          path: "/",
          builder: (context, state) =>
              HomeScreen(title: "PhysIX Companion App")),
      GoRoute(
          path: "/admin_login",
          builder: (context, state) => AdminLoginScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "forgot_password",
                builder: (context, state) => AdminForgotPasswordScreen())
          ]),
      GoRoute(
          path: "/admin_home",
          builder: (context, state) => AdminHomeScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "teachers",
                builder: (context, state) => AdminTeacherViewScreen(),
                routes: <RouteBase>[
                  GoRoute(
                      path: "add",
                      builder: (context, state) => AdminTeacherAddScreen()),
                  GoRoute(
                      path: "edit",
                      builder: (context, state) {
                        final extras = state.extra as Map<String, dynamic>?;

                        return TeacherFormWidget(
                          formMode: FormMode.edit,
                          uid: extras?['uid'],
                          firstName: extras?['firstName'],
                          lastName: extras?['lastName'],
                          email: extras?['email'],
                          dateRegistered: extras?['dateRegistered'],
                        );
                      })
                ]),
            GoRoute(
                path: "sections",
                builder: (context, state) => AdminSectionsViewScreen(),
                routes: <RouteBase>[
                  GoRoute(
                      path: "add",
                      builder: (context, state) => AdminSectionsAddScreen()),
                  GoRoute(
                      path: "edit",
                      builder: (context, state) => AdminSectionsEditScreen())
                ])
          ]),
    ]);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PhysIX Companion App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          useMaterial3: true,
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
          buttonTheme: const ButtonThemeData(
              buttonColor: Colors.white, textTheme: ButtonTextTheme.primary)),
      routerConfig: _router,
    );
  }
}

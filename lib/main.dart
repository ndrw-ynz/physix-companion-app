import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/admin/login/admin_login_screen.dart';
import 'screens/admin/sections/admin_sections_edit_screen.dart';
import 'screens/admin/teachers/admin_teacher_edit_screen.dart';
import 'screens/admin/login/admin_forgot_password_screen.dart';
import 'screens/admin/home/admin_home_screen.dart';
import 'screens/admin/sections/admin_sections_view_screen.dart';
import 'screens/admin/teachers/admin_teacher_add_screen.dart';
import 'screens/admin/teachers/admin_teacher_view_screen.dart';
import 'screens/admin/sections/admin_sections_add_screen.dart';
import 'screens/home_screen.dart';

final _router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
      path: "/",
      builder: (context, state) => HomeScreen(title: "PhysIX Companion App")),
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
                  builder: (context, state) => AdminTeacherEditScreen())
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

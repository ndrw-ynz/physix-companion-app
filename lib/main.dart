import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:physix_companion_app/widgets/change_password/change_password_screen_widget.dart';
import 'commons.dart';
import 'firebase_options.dart';

import 'screens/admin/login/admin_login_screen.dart';
import 'screens/admin/login/admin_forgot_password_screen.dart';
import 'screens/admin/home/admin_home_screen.dart';
import 'screens/admin/sections/admin_sections_view_screen.dart';
import 'screens/admin/teachers/admin_teacher_view_screen.dart';
import 'screens/student/attempt_history/attempt_history_screen.dart';
import 'screens/student/home/student_home_screen.dart';
import 'screens/student/login/student_login_screen.dart';
import 'screens/teacher/home/teacher_home_screen.dart';
import 'screens/teacher/login/teacher_forgot_password_screen.dart';
import 'screens/teacher/login/teacher_login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/teacher/student_progress/student_attempts_details_screen.dart';
import 'screens/teacher/student_progress/teacher_student_progress_screen.dart';
import 'screens/teacher/students/teacher_student_view_screen.dart';
import 'widgets/sections/section_form_widget.dart';
import 'widgets/students/student_form_widget.dart';
import 'widgets/teachers/teacher_form_widget.dart';
import 'services/auth_service.dart';

final _router = GoRouter(
    initialLocation: "/",
    refreshListenable: authNotifier,
    redirect: (context, state) {
      print("State change detected");

      final bool isLoggedIn = authNotifier.isLoggedIn;
      final bool isLoading = authNotifier.isLoading;

      if (isLoading) {
        return null;
      }

      if (isLoggedIn) {
        switch (state.matchedLocation) {
          case "/admin_login":
            return "/admin_home";
          case "/teacher_login":
            return "/teacher_home";
          case "/student_login":
            return "/student_home";
        }
      }

      return null;
    },
    routes: [
      GoRoute(
          path: "/",
          builder: (context, state) =>
              const HomeScreen(title: "PhysIX Companion App")),
      GoRoute(
          path: "/admin_login",
          builder: (context, state) => const AdminLoginScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "forgot_password",
                builder: (context, state) => const AdminForgotPasswordScreen())
          ]),
      GoRoute(
          path: "/admin_home",
          builder: (context, state) => const AdminHomeScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "teachers",
                builder: (context, state) => const AdminTeacherViewScreen(),
                routes: <RouteBase>[
                  GoRoute(
                      path: "add",
                      builder: (context, state) => TeacherFormWidget(
                            formMode: FormMode.add,
                            dateRegistered: Timestamp.now(),
                          )),
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
                          status: extras?['status'],
                        );
                      })
                ]),
            GoRoute(
                path: "sections",
                builder: (context, state) => const AdminSectionsViewScreen(),
                routes: <RouteBase>[
                  GoRoute(
                      path: "add",
                      builder: (context, state) => SectionFormWidget(
                            formMode: FormMode.add,
                            dateRegistered: Timestamp.now(),
                          )),
                  GoRoute(
                      path: "edit",
                      builder: (context, state) {
                        final extras = state.extra as Map<String, dynamic>?;

                        return SectionFormWidget(
                          formMode: FormMode.edit,
                          sectionId: extras?["sectionId"],
                          sectionName: extras?["sectionName"],
                          teacherUid: extras?["teacherUid"],
                          dateRegistered: extras?["dateRegistered"],
                        );
                      })
                ]),
            GoRoute(
                path: "change_password",
                builder: (context, state) => const ChangePasswordScreenWidget())
          ]),
      GoRoute(
          path: "/teacher_login",
          builder: (context, state) => const TeacherLoginScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "forgot_password",
                builder: (context, state) =>
                    const TeacherForgotPasswordScreen())
          ]),
      GoRoute(
          path: "/teacher_home",
          builder: (context, state) => const TeacherHomeScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "students",
                builder: (context, state) => const TeacherStudentViewScreen(),
                routes: <RouteBase>[
                  GoRoute(
                      path: "add",
                      builder: (context, state) => StudentFormWidget(
                            formMode: FormMode.add,
                            dateCreated: Timestamp.now(),
                          )),
                  GoRoute(
                      path: "edit",
                      builder: (context, state) {
                        final extras = state.extra as Map<String, dynamic>?;

                        return StudentFormWidget(
                          formMode: FormMode.edit,
                          uid: extras?['uid'],
                          firstName: extras?['firstName'],
                          lastName: extras?['lastName'],
                          email: extras?['email'],
                          sectionId: extras?['sectionId'],
                          dateCreated: extras?['dateCreated'],
                          status: extras?['status'],
                        );
                      })
                ]),
            GoRoute(
                path: "student_progress",
                builder: (context, state) =>
                    const TeacherStudentProgressScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: "attempts",
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>;
                      return StudentAttemptDetailsScreen(
                        studentId: extra['studentId'],
                        firstName: extra['firstName'],
                        lastName: extra['lastName'],
                        lessonNumber: extra['lessonNumber'],
                        difficulty: extra['difficulty'],
                      );
                    },
                  ),
                ]),
            GoRoute(
                path: "change_password",
                builder: (context, state) => const ChangePasswordScreenWidget())
          ]),
      GoRoute(
          path: "/student_login",
          builder: (context, state) => const StudentLoginScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "forgot_password",
                builder: (context, state) =>
                    const TeacherForgotPasswordScreen())
          ]),
      GoRoute(
          path: "/student_home",
          builder: (context, state) => const StudentHomeScreen(),
          routes: <RouteBase>[
            GoRoute(
                path: "attempt_history",
                builder: (context, state) => const AttemptHistoryScreen()),
            GoRoute(
                path: "change_password",
                builder: (context, state) => const ChangePasswordScreenWidget())
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

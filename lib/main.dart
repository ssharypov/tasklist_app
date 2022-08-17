import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/screens/tabs_screen.dart';
import 'package:todo_list/services/app_router.dart';
import 'package:todo_list/services/app_theme.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () {
      runApp(
        MyApp(
          appRouter: AppRouter(),
        ),
      );
    },
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

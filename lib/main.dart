import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/block/cubit.dart';
import 'package:notes/screens/home_screen.dart';

import 'models/darkModeCach.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveToCach.init();
  bool valueFromShared = SaveToCach.getData('isDark');
  runApp(MyApp(valueFromShared));
}

class MyApp extends StatelessWidget {
  bool valueFromCach;
  MyApp(this.valueFromCach);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<Appcubit>(
          create: (BuildContext context) => Appcubit()
            ..createData()
            ..toggleDarkTheme(valueFromCach: valueFromCach),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: HomeScreen()),
    );
  }
}

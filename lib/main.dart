import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/block/cubit.dart';
import 'package:notes/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:notes/models/notes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider<Appcubit>(
          create: (BuildContext context) => Appcubit()..createData(),
        ),
      ],
      child: MaterialApp(
debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen()),
    );

  }
}

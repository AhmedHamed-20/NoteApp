import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/block/cubit.dart';
import 'package:notes/models/block/states.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/widgets/colorpicker.dart';

class AddNoteScreen extends StatelessWidget {
  final snackBar = SnackBar(
    content: Text(
      'Body of the note can not be empty',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Color(0xff80cbc4),
    elevation: 3,
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<Appcubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Appcubit.get(context).isDark == true
              ? Color(0xff252526)
              : Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  titlecontroler.clear();
                                  bodycontroler.clear();
                                  Appcubit.get(context)
                                      .deleColorValueWhenBack();
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 40,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Appcubit.get(context).isDark == true
                                        ? Color(0xff3a3a3a)
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                          Appcubit.get(context).isDark == true
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //String body=bodycontroler.text.trim();
                                  if (bodycontroler.text.trim() == '') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    Appcubit.get(context).insertIntoDataBase(
                                        body: bodycontroler.text.trim(),
                                        title: titlecontroler.text.trim(),
                                        color:
                                            Appcubit.get(context).pickedColor,
                                        time: DateFormat.yMMMMd()
                                            .format(DateTime.now()));
                                    titlecontroler.clear();
                                    bodycontroler.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  width: 80,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Appcubit.get(context).isDark == true
                                        ? Color(0xff3a3a3a)
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'save',
                                      style: TextStyle(
                                        color:
                                            Appcubit.get(context).isDark == true
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    primaryColor: Colors.transparent,
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                      color:
                                          Appcubit.get(context).isDark == true
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 18,
                                    ),
                                    controller: titlecontroler,
                                    decoration: InputDecoration(
                                      focusColor: Colors.transparent,
                                      fillColor:
                                          Appcubit.get(context).isDark == true
                                              ? Colors.white
                                              : Colors.black,
                                      hintText: 'Title',
                                      hintStyle: TextStyle(
                                        color:
                                            Appcubit.get(context).isDark == true
                                                ? Colors.grey
                                                : Colors.black,
                                        fontSize: 24,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Theme(
                                  data: ThemeData(
                                    primaryColor: Colors.transparent,
                                  ),
                                  child: Container(
                                    child: TextField(
                                      cursorColor:
                                          Appcubit.get(context).isDark == true
                                              ? Colors.white
                                              : Colors.black,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: TextStyle(
                                        color:
                                            Appcubit.get(context).isDark == true
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: 18,
                                      ),
                                      controller: bodycontroler,
                                      decoration: InputDecoration(
                                        focusColor: Colors.transparent,
                                        fillColor: Colors.white,
                                        hintText: 'Type somthing...',
                                        hintStyle: TextStyle(
                                          color: Appcubit.get(context).isDark ==
                                                  true
                                              ? Colors.grey
                                              : Colors.black,
                                          fontSize: 20,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                PickColor(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/models/block/cubit.dart';
import 'package:notes/models/block/states.dart';
import 'package:notes/screens/add_noteScreen.dart';
import 'package:notes/widgets/note.dart';

import 'edit_note screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Appcubit, AppState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Color(0xff252526),
            appBar: AppBar(
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xff252526),
                  statusBarIconBrightness: Brightness.light),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Notes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => AddNoteScreen()));
              },
              backgroundColor: Colors.black,
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(15),
                child: Appcubit.get(context).notes.length > 0
                    ? StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        itemCount: Appcubit.get(context).notes.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNoteScreen(
                                      bodyOfNote: Appcubit.get(context)
                                          .notes[index]['body'],
                                      titleOfNote: Appcubit.get(context)
                                          .notes[index]['title'],
                                      noteColor: Appcubit.get(context)
                                          .notes[index]['Color'],
                                      index: Appcubit.get(context).notes[index]
                                          ['id'],
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text(
                                            'Are you sure ?',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          content: Text(
                                            'Delete this note ?',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Appcubit.get(context)
                                                    .deleteFromDataBase(
                                                        Appcubit.get(context)
                                                                .notes[index]
                                                            ['id']);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                          backgroundColor: Color(0xff252526),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ));
                              },
                              child: Notes(
                                body: Appcubit.get(context).notes[index]
                                    ['body'],
                                title: Appcubit.get(context).notes[index]
                                    ['title'],
                                color: Appcubit.get(context).notes[index]
                                    ['Color'],
                                time: Appcubit.get(context).notes[index]
                                    ['time'],
                              ),
                            ),
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(1))
                    : Center(
                        child: Text(
                          'press + button and add new notes',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )));
      },
    );
  }
}

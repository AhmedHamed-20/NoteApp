import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/block/states.dart';
import 'package:sqflite/sqflite.dart';

class Appcubit extends Cubit<AppState>{
  Appcubit() :super(AppintiState());
  static Appcubit get(context)=>BlocProvider.of(context);

  String pickedColor='0xffffab91';
  List<bool> switchColor = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  Database database;

  List<Map> notes = [];
  void changeColor(String color){
    pickedColor=color;

    emit(ColorPickedState());
  }
  void createData()  {
    openDatabase(
      'notes.db',
      version: 1,
      onCreate: (createdDataBase, ver) {
        createdDataBase
            .execute(
            'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT, Color TEXT,time TEXT)')
            .then(
              (value) => {
            print('ad'),
          },
        );

      },
      onOpen: (createdDataBase) {
        getdataFromDataBase(createdDataBase).then((value) {

          notes = value;
          print(notes);
          emit(AppGetDataBase());

        });
print('database opened');
      },
    ).then((value) {
      database=value;
      emit(AppCreateDataBase());
    });
  }

   insertIntoDataBase(
      {@required String title,
        @required String body,
        @required String color,
        String time}) async {
  await database.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO notes(title,body,color,time) VALUES("$title","$body","$color","$time")')
          .then((value)  {
            print('Inserted succ');
        emit(AppInsertDataBase());
            getdataFromDataBase(database).then((value) {
              notes = value;
              print(notes);
              emit(AppGetDataBase());

            });

          },)
          .catchError((error) {
        print('error');
      });

      return null;
    });
  }

  Future<List<Map>> getdataFromDataBase(createdDataBase) async {
    return await createdDataBase.rawQuery('SELECT * FROM notes');
  }
  void updateDateBase({String title,String body,int id})async{
  await database.rawUpdate(
        'UPDATE notes SET  title= ?, body = ? WHERE id = ?',
        ['${title}', '${body}', id]).then((value)
  {
          emit(AppUdateDataBase()
          );
  }).catchError(
        (error)=>print(error),
  );
  }
  void deleteFromDataBase(int id)async{
     await database
        .rawDelete('DELETE FROM notes WHERE id = ?', [id]).then((value)
     {
       getdataFromDataBase(database).then((value) {
         notes = value;
         emit(AppGetDataBase());

       });
emit(AppDeleteFromDataBase());
     }).catchError(
             (onError)
         {print(onError);}
             );

  }
}
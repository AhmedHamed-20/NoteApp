import 'package:flutter/material.dart';
import 'package:notes/models/block/cubit.dart';
import 'package:notes/models/notes.dart';


class PickColor extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Appcubit.get(context).    switchColor[0] = !Appcubit.get(context).switchColor[0];
            Appcubit.get(context).  switchColor[1] = Appcubit.get(context).switchColor[2] = Appcubit.get(context).switchColor[3] =
            Appcubit.get(context). switchColor[4] = Appcubit.get(context).switchColor[5] = Appcubit.get(context).switchColor[6] = false;
            Appcubit.get(context).changeColor('0xffffab91');
       //     pickedColor = '0xffffab91';

          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Appcubit.get(context).switchColor[0] == true
                      ? Colors.white
                      : Colors.transparent,
                  width: 2),
              color: Color(0xffffab91),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Appcubit.get(context).  switchColor[1] = !Appcubit.get(context).switchColor[1];
            Appcubit.get(context).  switchColor[0] = Appcubit.get(context).switchColor[2] = Appcubit.get(context).switchColor[3] =
            Appcubit.get(context).    switchColor[4] = Appcubit.get(context).switchColor[5] = Appcubit.get(context).switchColor[6] = false;
            Appcubit.get(context).changeColor('0xffffcc80');
         //   pickedColor = '0xffffcc80';

          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Appcubit.get(context).switchColor[1] == true
                      ? Colors.white
                      : Colors.transparent,
                  width: 2),
              color: Color(0xffffcc80),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Appcubit.get(context).   switchColor[2] = !Appcubit.get(context).switchColor[2];
            Appcubit.get(context). switchColor[0] = Appcubit.get(context).switchColor[1] = Appcubit.get(context).switchColor[3] =

            Appcubit.get(context).    switchColor[4] =Appcubit.get(context). switchColor[5] = Appcubit.get(context).switchColor[6] = false;
            Appcubit.get(context).changeColor('0xffe6ee9b');
    //       pickedColor = '0xffe6ee9b';

          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color:Appcubit.get(context). switchColor[2] == true
                      ? Colors.white
                      : Colors.transparent,
                  width: 2),
              color: Color(0xffe6ee9b),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Appcubit.get(context).   switchColor[3] = !Appcubit.get(context).switchColor[3];
            Appcubit.get(context).    switchColor[0] = Appcubit.get(context).switchColor[1] = Appcubit.get(context).switchColor[2] =
            Appcubit.get(context).   switchColor[4] = Appcubit.get(context).switchColor[5] = Appcubit.get(context).switchColor[6] = false;
            Appcubit.get(context).changeColor('0xffe6ee9b');
         //  pickedColor = '0xffe6ee9b';

          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Appcubit.get(context).switchColor[3] == true
                      ? Colors.white
                      : Colors.transparent,
                  width: 2),
              color: Color(0xffe6ee9b),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Appcubit.get(context). switchColor[4] = !Appcubit.get(context).switchColor[4];
            Appcubit.get(context).   switchColor[0] = Appcubit.get(context).switchColor[1] = Appcubit.get(context).switchColor[2] =
            Appcubit.get(context). switchColor[3] = Appcubit.get(context).switchColor[5] = Appcubit.get(context).switchColor[6] = false;
            Appcubit.get(context).changeColor('0xffcf93d9');
          // pickedColor = '0xffcf93d9';

          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Appcubit.get(context).switchColor[4] == true
                      ? Colors.white
                      : Colors.transparent,
                  width: 2),
              color: Color(0xffcf93d9),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Appcubit.get(context).  switchColor[5] = !Appcubit.get(context).switchColor[5];
            Appcubit.get(context).  switchColor[0] = Appcubit.get(context).switchColor[1] = Appcubit.get(context).switchColor[2] =
            Appcubit.get(context).  switchColor[3] = Appcubit.get(context).switchColor[4] = Appcubit.get(context).switchColor[6] = false;
            Appcubit.get(context).changeColor('0xff80cbc4');
     //      pickedColor = '0xff80cbc4';

          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color:Appcubit.get(context). switchColor[5] == true
                      ? Colors.white
                      : Colors.transparent,
                  width: 2),
              color: Color(0xff80cbc4),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Appcubit.get(context). switchColor[6] = !Appcubit.get(context).switchColor[6];
            Appcubit.get(context). switchColor[0] = Appcubit.get(context).switchColor[1] = Appcubit.get(context).switchColor[2] =
            Appcubit.get(context).   switchColor[3] = Appcubit.get(context).switchColor[4] = Appcubit.get(context).switchColor[5] = false;
            Appcubit.get(context).changeColor('0xfff48fb1');
     //     pickedColor = '0xfff48fb1';

          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                color:
                Appcubit.get(context).    switchColor[6] == true ? Colors.white : Colors.transparent,
                width: 2,
              ),
              color: Color(0xfff48fb1),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ],
    );
  }
}

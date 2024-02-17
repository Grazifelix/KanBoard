import 'package:flutter/material.dart';
import 'package:kandoard/model/board_model.dart';
import 'package:kandoard/shared/app_colors.dart';

// ignore: must_be_immutable
class BoardCart extends StatelessWidget {
  String boardName;
  final BoardModel cardContent;

  BoardCart({super.key, required this.boardName, required this.cardContent});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      color: AppColors.grey,
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.blue,
          ),
          borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: AppColors.blue,
        onTap: () {
          Navigator.pushNamed(context, '/board', arguments: cardContent);
        },
        child: SizedBox(
            width: 375,
            height: 128,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        'Board: ',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        boardName,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
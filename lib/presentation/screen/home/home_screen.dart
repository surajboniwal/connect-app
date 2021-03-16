import 'package:connect/controller/app_bar_controller.dart';
import 'package:connect/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _listController = ScrollController();
  final AppBarController appBarController = AppBarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: AppColors.WHITE_COLOR,
        title: Row(
          children: [
            Text(
              "Chats",
              style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.BLACK_COLOR),
            ),
            SizedBox(width: 12),
            Text(
              "Groups",
              style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.GREY_COLOR),
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.person_add), onPressed: () {}),
        ],
        actionsIconTheme: IconThemeData(
          color: AppColors.PRIMARY_COLOR,
        ),
      ),
      body: ListView.builder(
        controller: _listController,
        physics: BouncingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/$index.jpg'),
                    ),
                    index.isEven
                        ? CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.PRIMARY_COLOR,
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: AppColors.WHITE_COLOR,
                                fontSize: 14,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[400], width: 0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Suraj Boniwal',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('3:13 PM')
                          ],
                        ),
                        Text(
                          'This is a text message please reply and please reply and reply',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.5,
                            fontWeight: index.isEven ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

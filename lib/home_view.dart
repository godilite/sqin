import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqin/constants/colors.dart';
import 'package:sqin/models/slider_model.dart';
import 'package:timelines/timelines.dart';

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<SliderModel> _list;
  SliderModel slider = SliderModel();
  @override
  void initState() {
    _list = slider.items;
    super.initState();
  }

  int _processIndex = 0;

  void changePage() {
    if (_processIndex != _list.length - 1)
      setState(() {
        _processIndex++;
      });
  }

  Color getColor(int index) {
    if (index == _processIndex) {
      return AppColors.darkPink;
    } else if (index < _processIndex) {
      return AppColors.darkPink;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/clock.svg',
              width: 25,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 100,
            width: 200,
            child: SvgPicture.asset(
              _list[_processIndex].icon,
              width: 150,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text('${_list[_processIndex].title}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.kBlack,
                  fontSize: 30,
                  fontWeight: FontWeight.w800)),
          SizedBox(
            height: 40,
          ),
          Text('${_list[_processIndex].subtitle}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          Expanded(
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(
                  space: 30.0,
                  thickness: 5.0,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemExtentBuilder: (_, __) =>
                    MediaQuery.of(context).size.width / _list.length,
                contentsBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 10, right: 10),
                    child: Text(
                      _list[index].indicatorText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  if (index < _processIndex) {
                    return Stack(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 20,
                          color: AppColors.darkPink,
                        ),
                      ],
                    );
                  } else if (index == _processIndex) {
                    return Stack(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 30,
                          color: AppColors.darkPink,
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 20,
                          color: AppColors.lightGrey,
                        ),
                      ],
                    );
                  }
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == _processIndex) {
                      final prevColor = AppColors.darkPink;
                      final color = AppColors.darkPink;
                      List<Color> gradientColors;
                      if (type == ConnectorType.start) {
                        gradientColors = [
                          Color.lerp(prevColor, color, 0.5),
                          color
                        ];
                      } else {
                        gradientColors = [
                          prevColor,
                          Color.lerp(prevColor, color, 0.5)
                        ];
                      }
                      return DecoratedLineConnector(
                        thickness: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        thickness: 2,
                        color: getColor(index),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: _list.length,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    disabledColor: AppColors.lightGrey,
                    onPressed: _list[_processIndex].active
                        ? () {
                            changePage();
                          }
                        : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: AppColors.darkPink,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '${_list[_processIndex].buttonLabel}',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: _list[_processIndex].active
                                ? Colors.white
                                : AppColors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Magazine',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon_adviser.svg',
              width: 30,
            ),
            label: 'Treatment',
          ),
        ],
        currentIndex: 2,
        unselectedItemColor: AppColors.grey,
        selectedItemColor: AppColors.darkPink,
      ),
    );
  }
}

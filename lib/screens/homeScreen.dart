import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/LoginList.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show get;
import '../models/RecomList.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  final int id;

  const HomeScreen({Key? key, required this.id}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  List<RecomList> list = [];
  String cursor = '';
  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print(')))))))))))))))))))))))))');
        fetchAgain();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    var res = await get(Uri.parse(
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all'));

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      // print('####################################$response');
      var dataArr = response['data']['tournaments'];

      cursor = response['data']['cursor'];

      for (int i = 0; i < dataArr.length; i++) {
        var item = dataArr[i];

        var obj = RecomList(item['name'], item['cover_url'], item['game_name'],
            item['tournament_id']);
        setState(() {
          list.add(obj);
        });
      }
    } else {
      print('not status code of error free');
    }
  }

  Future<void> fetchAgain() async {
    var res = await get(Uri.parse(
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$cursor'));

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      var dataArr = response['data']['tournaments'];
      cursor = response['data']['cursor'];
      print('-----------------cursor---------$cursor');
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${dataArr.length}');
      for (int i = 0; i < dataArr.length; i++) {
        var item = dataArr[i];
        print(
            '---------${item['name']}-------${item['cover_url']}-------${item['game_name']}---------${item['tournament_id']}');
        var obj = RecomList(item['name'], item['cover_url'], item['game_name'],
            item['tournament_id']);
        setState(() {
          list.add(obj);
        });
        print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${list[i]}');
      }
      print(';lllllllllllllllllllllllllllll${list.length}');
    } else {
      print('not status code of error free');
    }
  }

  Widget middleView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black, width: 0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text('${LoginList.userData[widget.id]['T_played']}'),
                  const Text('Tournaments'),
                  const Text('Played'),
                ],
              ),
              color: Colors.orange,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.purple,
              child: Column(
                children: [
                  Text('${LoginList.userData[widget.id]['T_won']}'),
                  const Text('Tournaments'),
                  const Text('Won'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text('${LoginList.userData[widget.id]['T_percent']}%'),
                  const Text('Winning'),
                  const Text('Percentage'),
                ],
              ),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget topView() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2.0, color: Colors.cyan),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    '${LoginList.userData[widget.id]['profilePic']}'),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  '${LoginList.userData[widget.id]['name']}',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.cyan),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Text('${LoginList.userData[widget.id]['eloRating']}'),
                      const Text('Elo Rating'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget middleView() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     clipBehavior: Clip.hardEdge,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(40),
  //         border: Border.all(color: Colors.black, width: 0)),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Container(
  //           decoration: const BoxDecoration(
  //             color: Colors.orange,
  //           ),
  //           child: Expanded(
  //             flex: 1,
  //             child: Container(
  //               child: Column(
  //                 children: [
  //                   Text('${LoginList.userData[widget.id]['T_played']}'),
  //                   const Text('Tournaments'),
  //                   const Text('Played'),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           decoration: const BoxDecoration(
  //             color: Colors.purple,
  //           ),
  //           child: Expanded(
  //             flex: 1,
  //             child: Column(
  //               children: [
  //                 Text('${LoginList.userData[widget.id]['T_won']}'),
  //                 const Text('Tournaments'),
  //                 const Text('Won'),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           decoration: const BoxDecoration(
  //             color: Colors.red,
  //           ),
  //           child: Expanded(
  //             flex: 1,
  //             child: Column(
  //               children: [
  //                 Text('${LoginList.userData[widget.id]['T_percent']}%'),
  //                 const Text('Winning'),
  //                 const Text('Percentage'),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            topView(),
            middleView(),
            const Center(
              child: Text('Recommended For You'),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: list.length + 1,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index == list.length) {
                    return const CupertinoActivityIndicator();
                  }
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.network(list[index].cover_url),
                        ),
                        Text(list[index].game_name),
                        Text(list[index].name),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

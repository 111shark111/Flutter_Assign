import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/utils/LoginList.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show get;
import 'package:shared_preferences/shared_preferences.dart';
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
      // print('not status code of error free');
    }
  }

  Future<void> fetchAgain() async {
    var res = await get(Uri.parse(
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$cursor'));

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      var dataArr = response['data']['tournaments'];
      cursor = response['data']['cursor'];
      // print('-----------------cursor---------$cursor');
      // print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%${dataArr.length}');
      for (int i = 0; i < dataArr.length; i++) {
        var item = dataArr[i];
        // print(
        //     '---------${item['name']}-------${item['cover_url']}-------${item['game_name']}---------${item['tournament_id']}');
        var obj = RecomList(item['name'], item['cover_url'], item['game_name'],
            item['tournament_id']);
        setState(() {
          list.add(obj);
        });
        // print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${list[i]}');
      }
      // print(';lllllllllllllllllllllllllllll${list.length}');
    } else {
      // print('not status code of error free');
    }
  }

  Widget middleView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.orange.shade600,
                Colors.orange.shade400
              ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${LoginList.userData[widget.id]['T_played']}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                  const Text(
                    'Tournaments',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                  const Text(
                    'played',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.purple.shade600,
                Colors.purple.shade400
              ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${LoginList.userData[widget.id]['T_won']}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                  const Text(
                    'Tournaments',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                  const Text(
                    'won',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.red.shade400])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${LoginList.userData[widget.id]['T_percent']}%',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                  const Text(
                    'Winning',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                  const Text(
                    'percentage',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Open Sans'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget topView() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              // border: Border.all(width: 0.0, color: Colors.cyan),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    '${LoginList.userData[widget.id]['profilePic']}'),
              ),
            ),
          ),
          Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${LoginList.userData[widget.id]['name']}',
                  style: const TextStyle(
                      fontSize: 26,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.deepPurple),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${LoginList.userData[widget.id]['eloRating']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                      ),
                      const Text(
                        'Elo rating',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences shr = await SharedPreferences.getInstance();
                  shr.remove('id');
                  Navigator.push(context, MaterialPageRoute(builder: (contex) {
                    return Login();
                  }));
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: Container(
          // height: MediaQuery.of(context).size.height - 40,
          margin: EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              topView(),
              Container(
                margin: EdgeInsets.only(bottom: 20),
              ),
              middleView(),
              Container(
                margin: EdgeInsets.only(bottom: 20),
              ),
              const Text(
                'Recommended for you',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
              ),
              Container(
                  height: (MediaQuery.of(context).size.height) * 0.4,
                  child: ListView.builder(
                    itemCount: list.length + 1,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: scrollController,
                    padding: EdgeInsets.only(bottom: 10),
                    itemBuilder: (context, index) {
                      if (index == list.length) {
                        return const CupertinoActivityIndicator();
                      }
                      return Container(
                        height: 150,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 0),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        '${list[index].cover_url}'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  list[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  list[index].game_name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Open Sans',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

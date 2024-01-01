
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goodproject/team.dart';
import 'package:http/http.dart' as http;

class CricketPage extends StatelessWidget {
  CricketPage({super.key});

  List<Team> teams = [];

  Future getTeams() async {
    var response = await http.get(Uri.https("balldontlie.io" ,"api/v1/games"));
    var jsonData = jsonDecode(response.body);
    for (var eachTeam in jsonData['data']) {
      final team =
          Team(abbreviation: eachTeam['abbreviation'], city: eachTeam['city']);
      teams.add(team);
    }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(teams[index].abbreviation),
                    subtitle: Text(teams[index].city),);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

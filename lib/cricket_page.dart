import 'package:flutter/material.dart';

class CricketPage extends StatefulWidget {
  @override
  _CricketPageState createState() => _CricketPageState();
}

class _CricketPageState extends State<CricketPage> {
  String team1 = 'Team A';
  String team2 = 'Team B';
  int team1Score = 0;
  int team2Score = 0;
  int overs = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Scorecard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Live Score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$team1: $team1Score/$overs',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$team2: $team2Score/$overs',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  team1Score += 1;
                  overs += 1;
                });
              },
              child: Text('Team 1 Run'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  team2Score += 1;
                  overs += 1;
                });
              },
              child: Text('Team 2 Run'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  team1Score = 0;
                  team2Score = 0;
                  overs = 0;
                });
              },
              child: Text('Reset Scorecard'),
            ),
          ],
        ),
      ),
    );
  }
}

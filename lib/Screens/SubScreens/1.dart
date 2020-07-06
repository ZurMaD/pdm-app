import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PresCard extends StatelessWidget {
  final Map<String, dynamic> data;
  PresCard(this.data);
  Widget build(BuildContext context) {
    double p_c = data['pres_card'];
    return new Text(
      '${p_c.toStringAsFixed(2)} mmHg',
      style: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w900,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

class FrecResp extends StatelessWidget {
  final Map<String, dynamic> data;
  FrecResp(this.data);
  Widget build(BuildContext context) {
    double f_r = data['frec_resp'];
    return new Text(
      '${f_r.toStringAsFixed(2)} resp/m',
      style: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w900,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

class TempCorp extends StatelessWidget {
  final Map<String, dynamic> data;
  TempCorp(this.data);
  Widget build(BuildContext context) {
    double t_c = data['temp_corp'];
    return new Text(
      '${t_c.toStringAsFixed(2)} °C',
      style: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.w900,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  Future<http.Response> _response;
  // Future<http.Response> _response2;
  // Future<http.Response> _response3;

  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(
      () {
        _response =
            http.get('https://pdm3.herokuapp.com/api/last_data/?format=json');
      },
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("TempCorp Example"),
      // ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.refresh),
        onPressed: _refresh,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox.fromSize(
                size: Size(MediaQuery.of(context).size.width / 1.2, 200),
                // size: Size(160, 200),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage('Assets/Images/heart.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        'Presión arterial',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      new FutureBuilder(
                        future: _response,
                        builder: (BuildContext context,
                            AsyncSnapshot<http.Response> response) {
                          debugPrint(response.data.body);
                          if (!response.hasData)
                            return new Text('Cargando...');
                          else if (response.data.statusCode != 200) {
                            return new Text(
                                'No pudimos conectarnos al servidor');
                          } else {
                            Map<String, dynamic> json1 =
                                json.decode(response.data.body)[0];
                            if (json1['time'] != '')
                              return new PresCard(json1);
                            else
                              return new Text(
                                  'Error getting column, JSON is  $json1.');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox.fromSize(
                size: Size(MediaQuery.of(context).size.width / 1.2, 200),
                // size: Size(160, 200),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage('Assets/Images/frec.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        'Presión arterial',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      new FutureBuilder(
                        future: _response,
                        builder: (BuildContext context,
                            AsyncSnapshot<http.Response> response) {
                          debugPrint(response.data.body);
                          if (!response.hasData)
                            return new Text('Cargando...');
                          else if (response.data.statusCode != 200) {
                            return new Text(
                                'No pudimos conectarnos al servidor');
                          } else {
                            Map<String, dynamic> json2 =
                                json.decode(response.data.body)[0];
                            if (json2['time'] != '')
                              return new FrecResp(json2);
                            else
                              return new Text(
                                  'Error getting column, JSON is  $json2.');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox.fromSize(
                size: Size(MediaQuery.of(context).size.width / 1.2, 200),
                // size: Size(160, 200),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage('Assets/Images/term.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        'Presión arterial',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      new FutureBuilder(
                        future: _response,
                        builder: (BuildContext context,
                            AsyncSnapshot<http.Response> response) {
                          debugPrint(response.data.body);
                          if (!response.hasData)
                            return new Text('Cargando...');
                          else if (response.data.statusCode != 200) {
                            return new Text(
                                'No pudimos conectarnos al servidor');
                          } else {
                            Map<String, dynamic> json3 =
                                json.decode(response.data.body)[0];
                            if (json3['time'] != '')
                              return new TempCorp(json3);
                            else
                              return new Text(
                                  'Error getting column, JSON is  $json3.');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

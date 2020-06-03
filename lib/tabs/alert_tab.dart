import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/models/alert_model.dart';
import 'package:home_buddy/screens/alert_detail.dart';
import 'package:http/http.dart' as http;

class AlertTab extends StatefulWidget {
  final String email;
  AlertTab({this.email});
  @override
  _AlertTabState createState() => _AlertTabState();
}

class _AlertTabState extends State<AlertTab> {
  StreamController _alertsController;
  @override
  void initState() {
    super.initState();
    _alertsController = new StreamController();
    Timer.periodic(Duration(milliseconds: 300), (_) => loadAlerts());
  }

  Future<List<AlertItem>> fetchAlerts() async {
    final response = await http.post(
      getAlertsAPI,
      body: {'email': widget.email},
    );

    var data = json.decode(response.body);

    List<AlertItem> items = [];

    for (var i in data) {
      AlertItem product = AlertItem.fromJson(i);
      items.add(product);
    }
    return items;
  }

  loadAlerts() async {
    fetchAlerts().then((res) async {
      _alertsController.add(res);
      return res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20.0),
              child: Text(
                "ALERTS",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.0,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          bottom: 0,
          right: 0,
          left: 0,
          child: StreamBuilder(
            stream: _alertsController.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    AlertItem item = snapshot.data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlertDetail(item),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            'To: ' + item.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            item.status + ' | ' + item.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

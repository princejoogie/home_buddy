import 'package:flutter/material.dart';
import 'package:home_buddy/models/product_list.dart';

class HomeTab extends StatefulWidget {
  final String email;
  HomeTab({Key key, this.email}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState(email);
}

class _HomeTabState extends State<HomeTab> {
  String email;
  _HomeTabState(this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets/dashbg.png'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      child: Image(
                        image: AssetImage('assets/logoSmall.png'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Color(0xFFE3D9D9),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Type Keywords...",
                              style: TextStyle(
                                color: Color(0xFF7B7676),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ProductList(
            url:
                'http://192.168.1.4/home_buddy_crud/api/get_category.php?category=fruits%20and%20vegetables',
            title: 'Fruits and Vegetables',
            color: Color(0xFF7AFF00).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            url:
                'http://192.168.1.4/home_buddy_crud/api/get_category.php?category=Meat%20and%20Seafood',
            title: 'Meat and Seafood',
            color: Color(0xFF6FBAF7).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            url:
                'http://192.168.1.4/home_buddy_crud/api/get_category.php?category=Frozen',
            title: 'Frozen',
            color: Color(0xFFFF8300).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

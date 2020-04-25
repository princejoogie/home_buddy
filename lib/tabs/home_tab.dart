import 'package:flutter/material.dart';
import 'package:home_buddy/models/product_list.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
                  left: 10,
                  right: 10,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/logoSmall.png'),
                    ),
                    Container(
                      height: 50,
                      width: 300,
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
                  ],
                ),
              ),
            ],
          ),
          ProductList(
            'http://192.168.1.6/home_buddy_crud/api/get_category.php?category=Meat%20and%20Seafood',
            'Meat and Seafood',
            Color(0xFFF0EAEA),
          ),
          SizedBox(height: 10),
          ProductList(
            'http://192.168.1.6/home_buddy_crud/api/get_category.php?category=fruits%20and%20vegetables',
            'Fruits and Vegetables',
            Color(0xFFF0EAEA),
          ),
          SizedBox(height: 10),
          ProductList(
            'http://192.168.1.6/home_buddy_crud/api/get_category.php?category=Frozen',
            'Frozen',
            Color(0xFFF0EAEA),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

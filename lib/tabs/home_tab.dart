import 'package:flutter/material.dart';
import 'package:home_buddy/widgets/best_seller_carousel.dart';

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
          Padding(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Meat and Seafood",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xFF534747),
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 1.0,
                    color: Color(0xFF534747),
                  ),
                ),
              ],
            ),
          ),
          BestSellerCarousel(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy/models/product_list.dart';
import 'package:home_buddy/screens/see_all.dart';

class HomeTab extends StatefulWidget {
  final String email;
  HomeTab({Key key, this.email}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState(email);
}

class _HomeTabState extends State<HomeTab> {
  String email;
  TextEditingController _searchText = TextEditingController();

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
                      height: 40.0,
                      child: Image(
                        image: AssetImage('assets/logoSmall.png'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: CupertinoTextField(
                          controller: _searchText,
                          placeholder:
                              'Search Keywords... ex. meat, vegetables',
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.search, color: Color(0xFF7B7676)),
                          ),
                          clearButtonMode: OverlayVisibilityMode.editing,
                          enableInteractiveSelection: true,
                          enableSuggestions: true,
                          autofocus: false,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFF2F2F2),
                          ),
                          onEditingComplete: () {
                            if (_searchText.text.trim() == '') {
                              final snackBar = SnackBar(
                                  content: Text('Input Field is empty.'));
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SeeAllScreen(
                                    color: Color(0xFF6FBAF7),
                                    email: email,
                                    name: _searchText.text.trim(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ProductList(
            title: 'Fruits and Vegetables',
            color: Color(0xFF7AFF00).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            title: 'Meat and Seafood',
            color: Color(0xFF6FBAF7).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            title: 'Frozen',
            color: Color(0xFFFF8300).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            title: 'Pet Care and Food',
            color: Color(0xFFFF8300).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            title: 'Keto Vendors and Products',
            color: Color(0xFFFF8300).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            title: 'Rice Pasta Noodles',
            color: Color(0xFFFF8300).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            title: 'Canned and Ready-to-eat Products',
            color: Color(0xFFFF8300).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
          ProductList(
            title: 'Dairy and Bakery',
            color: Color(0xFFFF8300).withOpacity(0.8),
            email: email,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

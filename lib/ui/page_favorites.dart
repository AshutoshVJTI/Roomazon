import 'package:Roomazon/ui/page_house_detail.dart';
import 'package:Roomazon/ui/page_search.dart';
import 'package:Roomazon/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_container/responsive_container.dart';

List<bool> _isPressed = [];

class FavoritePage extends StatefulWidget {
  @override
  _MyFavoritePage createState() => _MyFavoritePage();
}

class _MyFavoritePage extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  // ignore: non_constant_identifier_names
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text('Favorites'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('House').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            return (snapshot.connectionState == null)
                ? new Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.purple[700],
                    ),
                  )
                : Container(
                    child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot docsSnap =
                          snapshot.data.documents[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          index == 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox(height: 0),
                          if (docsSnap.data['favourite'] != 0)
                            Container(
                                padding:
                                    new EdgeInsets.symmetric(horizontal: 10),
                                child:
                                    getCard(docsSnap, context, index, userRef)),
                        ],
                      );
                    },
                  ));
          }),
    );
  }
}

Widget getCard(
    DocumentSnapshot docsSnap, var context, index, var userReference) {
  //setStatus(snapshot);

  return Column(children: <Widget>[
    Stack(
      children: <Widget>[
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: new EdgeInsets.all(8),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              // Navigate
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HouseDetail(docsSnap),
                ),
              );
            },
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.25,
                    color: Colors.grey,
                    child: Image.network('${docsSnap['houseImages'][0]}',
                        fit: BoxFit.fill),
                  ),
                ),
                Row(
                  children: <Widget>[
                    ResponsiveContainer(
                      widthPercent: 23,
                      heightPercent: 9,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('${docsSnap['builtUpArea']} Sq.ft.')),
                        ),
                      ),
                    ),
                    ResponsiveContainer(
                      widthPercent: 41,
                      heightPercent: 9,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                                child: Text(
                                    '${docsSnap['Overview']['room']} BHK in ${docsSnap['Address']['city']}')),
                            Align(
                                child: Text(
                                    '${docsSnap['Overview']['furnishingStatus']}')),
                          ],
                        ),
                      ),
                    ),
                    ResponsiveContainer(
                      widthPercent: 23,
                      heightPercent: 9,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(10)),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('${docsSnap['monthlyRent']}'),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('Rs. / month'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
    SizedBox(
      height: 10.0,
    ),
  ]);
}

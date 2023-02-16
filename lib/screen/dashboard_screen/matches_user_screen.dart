import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_up/model/matches_user_model.dart';

class MatchesUserScreen extends StatefulWidget {
  var locationName, userCount, isQrCode;
  MatchesUserScreen({this.locationName, this.userCount, this.isQrCode});

  @override
  State<MatchesUserScreen> createState() => _MatchesUserScreenState();
}

class _MatchesUserScreenState extends State<MatchesUserScreen> {
  var searchTxt = TextEditingController();

  static List<MatchesUserModel> main_matchesUserList = [
    MatchesUserModel('Ranjit Kumar', 'assets/images/man_1.jpeg'),
    MatchesUserModel('Aanand Kumar', 'assets/images/man_2.jpeg'),
    MatchesUserModel('Sonu Kumar', 'assets/images/man_3.jpeg'),
    MatchesUserModel('Vijay Kumar', 'assets/images/man_4.jpeg'),
    MatchesUserModel('Rahul Kumar', 'assets/images/man_5.jpeg'),
    MatchesUserModel('Chandan Kumar', 'assets/images/man_1.jpeg'),
    MatchesUserModel('Anurag Kumar', 'assets/images/man_4.jpeg'),
    MatchesUserModel('Akash Rawat', 'assets/images/man_2.jpeg'),
    MatchesUserModel('Suraj Adhikari', 'assets/images/man_3.jpeg'),
    MatchesUserModel('Shivam Rawat', 'assets/images/man_5.jpeg'),
  ];

  List<MatchesUserModel> display_matchesUserList =
      List.from(main_matchesUserList);

  // function for search filter
  void updateList(String value) {
    setState(() {
      display_matchesUserList = main_matchesUserList
          .where((element) =>
              element.userName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE9E8E8),
        automaticallyImplyLeading: false,
        title: widget.isQrCode != true
            ? Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '${widget.locationName}',
                        style: GoogleFonts.merriweather(
                            color: Color(0xFF3D1766),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3)),
                    TextSpan(
                        text: ' (${widget.userCount})',
                        style: GoogleFonts.merriweather(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3)),
                  ],
                ),
              )
            : Text('Matches Users'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.all(10),
                  // color: Color(0xFFF7EFE5),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: searchTxt,
                    maxLines: 1,
                    onChanged: (value) {
                      updateList(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search by Name',
                      hintText: 'Search by Name',
                      isDense: true,
                      prefixIcon: Icon(Icons.search_rounded),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: const BorderSide(color: Colors.grey)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: display_matchesUserList.length == 0
                      ? Center(
                          child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image(
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    image: new AssetImage(
                                        'assets/images/no_result.png')),
                              ),
                              Container(
                                child: Text(
                                  'No Result Found',
                                  style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.3,
                                      color: Color(0xFF3D1766)),
                                ),
                              )
                            ],
                          ),
                        ))
                      : Container(
                          margin: EdgeInsets.all(10),
                          child: GridView.builder(
                            shrinkWrap: true,
                            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: display_matchesUserList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 40,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return MatchesUserScreen(
                                  //         locationName: userData[index]
                                  //             ['location_name'],
                                  //         userCount: userData[index]
                                  //             ['location_user_count']);
                                  //   },
                                  // ));
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        Container(
                                            child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              '${display_matchesUserList[index].userImg}'),
                                          radius: 60,
                                        )),
                                        Positioned(
                                          right: 7,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.5),
                                              color: Colors.red,
                                            ),
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ]),
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(
                                          '${display_matchesUserList[index].userName}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF3D1766),
                                              fontSize: 16,
                                              letterSpacing: 0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                )
              ],
            )),
      ),
    );
  }
}

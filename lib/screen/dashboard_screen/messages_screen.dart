import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/model/message_model.dart';
import 'package:meet_up/widgets/custom_textFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController searchController = TextEditingController();
  String search = '';
  late String address = '';

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    var prefs = await SharedPreferences.getInstance();
    address = prefs.getString('address')!;
    print(address);
  }

  Future<Null> _refresh() {
    return doSomeAsyncStuff().then((_user) {
      setState(() => address = address);
    });
  }

  static List<MessageModel> main_messageModal = [
    MessageModel('1', 'Ranjit Kumar', 'Hii :) How are you?', '02:50 PM', true,
        '05', 'assets/images/man_1.jpeg'),
    MessageModel('2', 'Aanand Kumar', 'ok please send me', '6 hour ago', true,
        '07', 'assets/images/man_2.jpeg'),
    MessageModel('3', 'Sonu Kumar', "Lets's play", '11 hour ago', false, '00',
        'assets/images/man_3.jpeg'),
    MessageModel('4', 'Chandan Kumar', 'Hii :) How are you?', '02:50 PM', true,
        '05', 'assets/images/man_4.jpeg'),
    MessageModel('5', 'Akash Rawat', 'Hii :) How are you?', '02:50 PM', true,
        '05', 'assets/images/man_5.jpeg'),
    MessageModel('6', 'Vipin', 'Hii :) How are you?', '02:50 PM', true, '07',
        'assets/images/man_4.jpeg'),
    MessageModel('7', 'Suraj Adhikari', 'Hii :) How are you?', '1 day ago',
        false, '00', 'assets/images/man_3.jpeg'),
    MessageModel('8', 'Shivam Rawat', 'Hii :) How are you?', '3 day ago', true,
        '08', 'assets/images/man_2.jpeg'),
    MessageModel('9', 'Anupam', 'Hii :) How are you?', '02:50 PM', false, '03',
        'assets/images/man_1.jpeg'),
    MessageModel('10', 'Vijay Kumar', 'Hii :) How are you?', '1 week ago',
        false, '10', 'assets/images/man_5.jpeg'),
  ];

  List<MessageModel> display_message_list = List.from(main_messageModal);
  void updateList(String value) {
    setState(() {
      display_message_list = main_messageModal
          .where((element) => element.location_name!
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            child: Text(
              address,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.qr_code_scanner_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.red.shade100
              ],
                  begin: FractionalOffset(1.0, 0.0),
                  end: FractionalOffset(0.0, 1.0))),
          child: SafeArea(
              child: Column(
            children: [
              Container(
                // margin: EdgeInsets.all(10),
                color: Color(0xFFF7EFE5),
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: searchController,
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
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: display_message_list.length == 0
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
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: display_message_list.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        '${display_message_list[index].location_image}'),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        '${display_message_list[index].location_name}',
                                        style: GoogleFonts.merriweather(
                                            color: Color(0xFF3D1766),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      display_message_list[index]
                                                  .message_count !=
                                              '00'
                                          ? Container(
                                              width: 25,
                                              height: 25,
                                              margin: EdgeInsets.only(left: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.5)),
                                              child: Center(
                                                  child: Text(
                                                      '${display_message_list[index].message_count}',
                                                      style: GoogleFonts
                                                          .merriweather(
                                                              fontSize: 13.5,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing:
                                                                  0.3))),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                  subtitle: Text(
                                    '${display_message_list[index].location_user_count}',
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.merriweather(
                                        color: Colors.grey),
                                  ),
                                  trailing: display_message_list[index]
                                              .isOnline !=
                                          true
                                      ? Text(
                                          '${display_message_list[index].user_last_online}')
                                      : Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                              color: Colors.green.shade900,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Color(0xFFD3D3D3),
                                thickness: 1.0,
                              );
                            },
                          ),
                        ))
            ],
          )),
        ),
      ),
    );
  }
}

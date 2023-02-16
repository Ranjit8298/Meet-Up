import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:meet_up/model/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static List<NotificationModel> main_NotificationList = [
    NotificationModel('Today', 'Ranjit Kumar', 'Liked your daily UI',
        'assets/images/man_1.jpeg', '2 h ago', false),
    NotificationModel('Today', 'Aanand Kumar', 'Comment on your daily UI',
        'assets/images/man_2.jpeg', '5 h ago', false),
    NotificationModel('Today', 'Sonu Kumar', 'Liked your daily UI',
        'assets/images/man_3.jpeg', '8 h ago', false),
    NotificationModel('Tomorrow', 'Chandan Kumar', 'Start following your work',
        'assets/images/man_4.jpeg', '7 Feb', true),
    NotificationModel('Tomorrow', 'Akash Rawat', 'Mentioned on you a comment',
        'assets/images/man_3.jpeg', '7 Feb', true),
    NotificationModel('Tomorrow', 'Ankit Raj', 'Liked your photo',
        'assets/images/man_2.jpeg', '8 Feb', true),
    NotificationModel('Tomorrow', 'Ajay', 'Send you a message',
        'assets/images/man_1.jpeg', '9 Feb', true),
    NotificationModel('Tomorrow', 'Vipin', 'Comment on your photo',
        'assets/images/man_4.jpeg', '12 Feb', true),
  ];

  List<NotificationModel> display_notification_list =
      List.from(main_NotificationList);

  List _elements = [
    {
      'userName': 'Ranjit Kumar',
      'group': 'Today',
      'userImg': 'assets/images/man_1.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '2 h ago',
      'isRead': true,
    },
    {
      'userName': 'Aanand Kumar',
      'group': 'Today',
      'userImg': 'assets/images/man_2.jpeg',
      'userMessage': 'Start following your work',
      'notification_time': '4 h ago',
      'isRead': true,
    },
    {
      'userName': 'Sonu Kumar',
      'group': 'Today',
      'userImg': 'assets/images/man_3.jpeg',
      'userMessage': 'Like your photo',
      'notification_time': '6 h ago',
      'isRead': true,
    },
    {
      'userName': 'Chandan Kumar',
      'group': 'This Week',
      'userImg': 'assets/images/man_4.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '12 Feb, 2023',
      'isRead': false,
    },
    {
      'userName': 'Akash Rawat',
      'group': 'This Week',
      'userImg': 'assets/images/man_3.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '10 Feb, 2023',
      'isRead': false,
    },
    {
      'userName': 'Vipin',
      'group': 'This Week',
      'userImg': 'assets/images/man_2.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '8 Feb, 2023',
      'isRead': false,
    },
    {
      'userName': 'Vijay',
      'group': 'This Week',
      'userImg': 'assets/images/man_1.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '7 Feb, 2023',
      'isRead': false,
    },
    {
      'userName': 'Ankit Raj',
      'group': 'This Week',
      'userImg': 'assets/images/man_1.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '7 Feb, 2023',
      'isRead': true,
    },
    {
      'userName': 'Mahindra Gupta',
      'group': 'Last Week',
      'userImg': 'assets/images/man_2.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '5 Feb,',
      'isRead': false,
    },
    {
      'userName': 'Lokesh Gupta',
      'group': 'Last Week',
      'userImg': 'assets/images/man_1.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '4 Feb,',
      'isRead': true,
    },
    {
      'userName': 'Anurag',
      'group': 'Last Week',
      'userImg': 'assets/images/man_3.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '5 Feb,',
      'isRead': false,
    },
    {
      'userName': 'Shivam Rawat',
      'group': 'Last Week',
      'userImg': 'assets/images/man_3.jpeg',
      'userMessage': 'Mentioned on you a comment',
      'notification_time': '4 Feb, 2023',
      'isRead': false,
    },
  ];

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xFFE9E8E8),
        title: Text(
          'Notifications',
          style: GoogleFonts.merriweather(
              color: Color(0xFF3D1766),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'You have ',
                        style: GoogleFonts.merriweather(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3)),
                    TextSpan(
                        text: '3 Notifications ',
                        style: GoogleFonts.merriweather(
                            color: Colors.blueGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3)),
                    TextSpan(
                        text: 'today',
                        style: GoogleFonts.merriweather(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3)),
                  ],
                ),
              ),
            ),
            Expanded(
                child: GroupedListView<dynamic, String>(
              elements: _elements,
              groupBy: (element) => element['group'],
              separator: Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                margin: EdgeInsets.only(left: 80, bottom: 3),
                color: Color(0xFFD3D3D3),
              ),
              groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1['userName'].compareTo(item2['userName']),
              order: GroupedListOrder.ASC,
              useStickyGroupSeparators: true,
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              itemBuilder: (context, element) {
                return Container(
                    child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      selected: true,
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('${element['userImg']}'),
                      ),
                      title: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '${element['userName']} ',
                            style: GoogleFonts.merriweather(
                                color: Color(0xFF3D1766),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3)),
                        TextSpan(
                            text: '${element['userMessage']}',
                            style: GoogleFonts.merriweather(
                                color: Colors.grey,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                                letterSpacing: 0.3)),
                      ])),
                      subtitle: Text(
                        element['notification_time'],
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: element['isRead'] == true
                          ? Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4)),
                            )
                          : SizedBox(),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 1,
                    //   margin: EdgeInsets.only(left: 20, bottom: 3),
                    //   color: Color(0xFFD3D3D3),
                    // )
                  ],
                ));
              },
            ))
          ],
        ),
      ),
    ));
  }
}

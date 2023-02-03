import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchesUserScreen extends StatelessWidget {
  var locationName, userCount, isQrCode;
  MatchesUserScreen({this.locationName, this.userCount, this.isQrCode});

  var searchTxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isQrCode != true
            ? Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '${locationName}'),
                    TextSpan(
                        text: ' (${userCount})',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              )
            : Text('Matches Users'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFF7EFE5),
          Colors.white,
          Colors.white24,
          Colors.blue.shade50,
          Colors.red.shade100
        ], begin: FractionalOffset(1.0, 0.0), end: FractionalOffset(0.0, 1.0))),
        child: SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.all(10),
                  color: Color(0xFFF7EFE5),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: searchTxt,
                    maxLines: 1,
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
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  Container(
                                      child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${userData[index]['location_image']}'),
                                    radius: 60,
                                  )),
                                  Positioned(
                                    right: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.5),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ]),
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: Text(
                                    '${userData[index]['location_name']}',
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
                      itemCount: userData.length,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  var userData = [
    {
      'location_id': '1',
      'location_name': 'Social Hangout',
      'location_user_count': '15 User Live',
      'location_image':
          'https://www.euttaranchal.com/hotels/photos/lemon-tree-hotel-dehradun-1779387.jpg'
    },
    {
      'location_id': '2',
      'location_name': 'Chef Restaurant',
      'location_user_count': '10 User Live',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
    {
      'location_id': '3',
      'location_name': 'Kingford Hotel',
      'location_user_count': '18 User Live',
      'location_image':
          'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'
    },
    {
      'location_id': '4',
      'location_name': 'Taj Hotel',
      'location_user_count': '06 User Live',
      'location_image':
          'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'
    },
    {
      'location_id': '5',
      'location_name': 'Namsate Bharat',
      'location_user_count': '25 User Live',
      'location_image':
          'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='
    },
    {
      'location_id': '6',
      'location_name': 'Greenfield Hotel',
      'location_user_count': '35 User Live',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
    {
      'location_id': '7',
      'location_name': 'Doon Bar',
      'location_user_count': '05 User Live',
      'location_image':
          'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'
    },
    {
      'location_id': '8',
      'location_name': 'Poppins Hangout',
      'location_user_count': '16 User Live',
      'location_image':
          'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'
    },
    {
      'location_id': '9',
      'location_name': 'Chai Sutta Bar',
      'location_user_count': '10 User Live',
      'location_image':
          'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='
    },
    {
      'location_id': '10',
      'location_name': 'Roboto Hangout',
      'location_user_count': '15 User Live',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
  ];
}

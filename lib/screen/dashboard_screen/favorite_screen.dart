import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_up/model/favorite_model.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var searchController = TextEditingController();
  bool showLoder = true;

  static List<FavoriteModel> main_favoriteModel = [
    FavoriteModel(
        "Ranjit Kumar", 'React Native Developer', 'assets/images/man_1.jpeg'),
    FavoriteModel("Sonu Kumar", 'App Developer', 'assets/images/man_2.jpeg'),
    FavoriteModel("Aanand Kumar", 'Developer', 'assets/images/man_3.jpeg'),
    FavoriteModel(
        "Chandan Kumar", 'Full Stack Developer', 'assets/images/man_4.jpeg'),
    FavoriteModel(
        "Akash Rawat", 'React Native Developer', 'assets/images/man_3.jpeg'),
    FavoriteModel("Vipin", 'Web Developer', 'assets/images/man_2.jpeg'),
    FavoriteModel("Mahendra", 'BDE', 'assets/images/man_1.jpeg'),
    FavoriteModel(
        "Shivam Rawat", 'Full Stack Developer', 'assets/images/man_4.jpeg'),
  ];

  List<FavoriteModel> display_favorite_list = List.from(main_favoriteModel);

  void updateList(String value) {
    setState(() {
      display_favorite_list = main_favoriteModel
          .where((element) =>
              element.userName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _handleRemoveAction() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) => SafeArea(
        child: Container(
          height: 250,
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel, size: 28, color: Colors.red),
                ),
              ),
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xFFD3D3D3),
                      borderRadius: BorderRadius.circular(35)),
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                    size: 45,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  'Are you sure want to remove?',
                  style: GoogleFonts.merriweather(
                      color: Color(0xFF3D1766),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 10),
                      child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD3D3D3),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'No',
                            style: GoogleFonts.merriweather(
                                color: Color(0xFF3D1766),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3),
                          )),
                    ),
                    Container(
                      width: 150,
                      child: FilledButton(
                          onPressed: () {},
                          child: Text(
                            'Yes',
                            style: GoogleFonts.merriweather(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showLoder = false;
      });
    });
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Color(0xFFE9E8E8),
        title: Text(
          'Favorite',
          style: GoogleFonts.merriweather(
              color: Color(0xFF3D1766),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3),
        ),
      ),
      body: showLoder
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
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
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: display_favorite_list.length == 0
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
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: display_favorite_list.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 80,
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 3.0,
                                                  spreadRadius: 3.0,
                                                  color: Colors.grey,
                                                  offset: Offset(0.0, 0.0))
                                            ]),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(
                                                '${display_favorite_list[index].userImg}'),
                                          ),
                                          title: Text(
                                            '${display_favorite_list[index].userName}',
                                            style: GoogleFonts.merriweather(
                                                color: Color(0xFF3D1766),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          subtitle: Text(
                                            '${display_favorite_list[index].userPosition}',
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.merriweather(
                                                color: Colors.grey),
                                          ),
                                          trailing: FilledButton(
                                              onPressed: () {
                                                _handleRemoveAction();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueGrey,
                                              ),
                                              child: Text('Remove')),
                                        ),
                                      );
                                    },
                                  ),
                                ))
                    ],
                  )),
            ),
    );
  }
}

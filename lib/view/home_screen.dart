import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_wave/models/news_channel_headlines_model.dart';
import 'package:news_wave/view/category_screen.dart';
import 'package:news_wave/view/news_detail_screen.dart';
import 'package:news_wave/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/category_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList{
  bbcNews, aryNews, buzzfeed, Finance, cnn, alJazeera
}
class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.sizeOf(context).height;
    print(width);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoriesScreen()));
          },
            icon: Image.asset('images/category_icon.png',
            color: Colors.white,
            height: 30,
              width: 30,
            )),
        title: Center(child: Text('   News Wave', style: GoogleFonts.acme(fontSize: 24, fontWeight: FontWeight.w700,
        color: Colors.white),
        ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
              icon: Icon(Icons.more_vert, color: Colors.white,),
              onSelected: (FilterList item){
                if(FilterList.bbcNews.name==item.name){
                  name = 'bbc-news';
                }
                if(FilterList.aryNews.name==item.name){
                  name = 'ary-news';
                }
                if(FilterList.buzzfeed.name==item.name){
                  name = 'buzzfeed';
                }
                if(FilterList.Finance.name==item.name){
                  name = 'financial-post';
                }
                if(FilterList.cnn.name==item.name){
                  name = 'cnn';
                }
                if(FilterList.alJazeera.name==item.name){
                  name = 'al-jazeera-english';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                    child: Text('BBC News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text('Ary News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.buzzfeed,
                  child: Text('Buzzfeed'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.Finance,
                  child: Text('Finance'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text('CNN'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.alJazeera,
                  child: Text('Al-Jazeera News'),
                ),
              ]
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height* .45,
            width: width ,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.cyan,
                    ),
                  );
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailScreen(
                              snapshot.data!.articles![index].urlToImage.toString(),
                              snapshot.data!.articles![index].title.toString(),
                              snapshot.data!.articles![index].publishedAt.toString(),
                                snapshot.data!.articles![index].author.toString(),
                              snapshot.data!.articles![index].description.toString(),
                              snapshot.data!.articles![index].content.toString(),
                              snapshot.data!.articles![index].source!.name.toString(),
                            )));
                          },
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height* 0.6,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: height*0.02,

                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(child: spinKit2,),
                                      errorWidget: (context, url ,error) => Icon(Icons.error_outline, color: Colors.purple,),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(15),
                                      height: height*.22,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width* 0.7,
                                            child: Text(snapshot.data!.articles![index].title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                              GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700,
                                              color: Colors.white)
                                              ,),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width* 0.7,
                                            child:
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600,
                                                  color: Colors.cyan)
                                                  ,),
                                                Text(format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70)
                                                  ,),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.cyan,
                    ),
                  );
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,

                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailScreen(
                              snapshot.data!.articles![index].urlToImage.toString(),
                              snapshot.data!.articles![index].title.toString(),
                              snapshot.data!.articles![index].publishedAt.toString(),
                              snapshot.data!.articles![index].author.toString(),
                              snapshot.data!.articles![index].description.toString(),
                              snapshot.data!.articles![index].content.toString(),
                              snapshot.data!.articles![index].source!.name.toString(),)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height : height* 0.18,
                                    width: width * 0.3,
                                    placeholder: (context, url) => Container(child: SpinKitCircle(
                                      size: 50,
                                      color: Colors.cyan,
                                    ),),
                                    errorWidget: (context, url ,error) => Icon(Icons.error_outline, color: Colors.purple,),
                                  ),
                                ),
                                Expanded(child: Container(
                                  height: height*0.18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!.articles![index].title.toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.cyan,
                                              ),
                                            ),

                                            Text(format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

}
const spinKit2 = SpinKitFadingCircle(
  color: Colors.cyan,
  size: 50,
);

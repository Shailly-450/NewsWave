import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/category_news_model.dart';
import '../models/news_channel_headlines_model.dart';
import '../view_model/news_view_model.dart';
import 'news_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  String categoryName = 'general';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white70, // Change this color to your desired color
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                  itemBuilder: (context, index){
                   return InkWell(
                     onTap: (){
                       categoryName = categoriesList[index];
                       setState(() {

                       });
                     },
                     child: Padding(
                       padding: const EdgeInsets.only(right: 12),
                       child: Container(
                         decoration: BoxDecoration(
                           color: categoryName== categoriesList[index] ? Colors.cyan : Colors.black,
                           borderRadius: BorderRadius.circular(20)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 12),
                           child: Center(child: Text(categoriesList[index].toString(), style: GoogleFonts.acme(
                             color: categoryName== categoriesList[index] ? Colors.white : Colors.white,
                             fontSize: 18,
                             fontWeight: FontWeight.w700,

                           ),)),
                         ),
                       ),
                     ),
                   );
                  }
              ),

            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
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
            ),
          ],
        ),
      ),
    );
  }
}


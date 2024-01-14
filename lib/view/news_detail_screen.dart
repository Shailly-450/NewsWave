// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// class NewsDetailScreen extends StatefulWidget {
//  final String newsImage, newsTitle, newsDate, author, description, content, source;
//   const NewsDetailScreen({Key? key,
//     required this.newsImage,
//     required this.source,
//   required this.newsDate,
//   required this.newsTitle,
//   required this.author,
//   required this.description,
//   required this.content,
//
//   }): super(key: key);
//
//   @override
//   State<NewsDetailScreen> createState() => _NewsDetailScreenState();
// }
//
// class _NewsDetailScreenState extends State<NewsDetailScreen> {
//   final format = DateFormat('MMMM dd, yyyy');
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.sizeOf(context).height;
//     DateTime dateTime = DateTime.parse(widget.newsDate);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             height: height* 0.45,
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20)
//               ),
//               child: CachedNetworkImage(
//                 imageUrl: widget.newsImage,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(
//             height: height*0.6,
//
//             margin: EdgeInsets.only(top: height* .4),
//             padding: EdgeInsets.only(top: 20,
//             right: 20,
//             left: 20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30)
//               ),
//             ),
//             child: ListView(
//               children: [
//                 Text(widget.newsTitle, style: GoogleFonts.poppins(
//                   fontSize: 20,
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w700
//                 ),),
//                 SizedBox(
//                   height: height*0.02,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(widget.source,style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       color: Colors.blueAccent,
//                       fontWeight: FontWeight.w600
//                                       ),),
//                     ),
//                     Text(format.format(dateTime),style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: Colors.black54,
//                         fontWeight: FontWeight.w500
//                     ),)
//                   ],
//                 ),
//                 SizedBox(
//                   height: height*0.03,
//                 ),
//                 Text(widget.content,style: GoogleFonts.poppins(
//                     fontSize: 15,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500
//                 ),),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';




class NewsDetailScreen extends StatefulWidget {
  final String newsImage, newsTitle, newsDate, author, description, content, source;
  const NewsDetailScreen(this.newsImage, this.newsTitle, this.newsDate,
      this.author, this.description, this.content, this.source, {super.key,});


  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  final format = DateFormat('MMMM dd,yyyy');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.description);
  }

  @override
  Widget build(BuildContext context) {
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white70,
            )),
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              color: Colors.black,
              // padding: EdgeInsets.symmetric(horizontal: Kheight * 0.02),
              height: Kheight * 0.45,
              width: Kwidth,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: "${widget.newsImage}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Kheight * 0.4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            height: Kheight * 0.6,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Text('${widget.newsTitle}',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: Kheight * 0.02),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            '${widget.source}',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.cyan,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Text(
                        '${format.format(dateTime)}',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                Text('${widget.description}',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                Text('${widget.content}',

                    style: GoogleFonts.poppins(
                        fontSize: 12,
                         color: Colors.white,
                         fontWeight: FontWeight.w400)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewGalleryScreen extends StatefulWidget {
  List images=[];
  final int index;
  final String heroTag;

  PhotoViewGalleryScreen({
    required this.images,
    this.index=0,
    this.heroTag = '0',})
      : assert(images != null);

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int currentIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex=widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        InkWell(child:
        Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                  child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(widget.images[index]),
                        heroAttributes: widget.heroTag.isNotEmpty?PhotoViewHeroAttributes(tag: widget.heroTag):null,

                      );
                    },
                    itemCount: widget.images.length,
                    // loadingChild: Container(),
                    backgroundDecoration: null,
                    pageController: PageController(initialPage: currentIndex),
                    enableRotation: true,
                    onPageChanged: (index){
                      setState(() {
                        currentIndex=index;
                      });
                    },
                  )
              ),
            ),

            Positioned(///topCentre
              top: MediaQuery.of(context).padding.top+15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("${currentIndex+1}/${widget.images.length}",style: TextStyle(color: Colors.white,fontSize: 18)),
              ),
            ),

            Positioned(///left
              left: 10,
              top: MediaQuery.of(context).padding.top+15,
              child:

              GestureDetector(child:
              Container(width: 130,height: 130,
                color: Colors.transparent,
                alignment: Alignment.topLeft,
                // padding: EdgeInsets.only(right: 0,top: 0),
                // margin: const EdgeInsets.only(left: 0,top: 0),
                child:
                Icon(
                  size:30,
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
                onTap: (){
                  Navigator.pop(context);
                },
              )
              ,),

            // Positioned(///right
            //   right: 10,
            //   top: MediaQuery.of(context).padding.top,
            //   child: IconButton(
            //     icon: Icon(Icons.close_rounded,size: 30,color: Colors.white,),
            //     onPressed: (){
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ),

          ],
        )
          ,onTap: (){
            Navigator.of(context).pop();
          },)
    );
  }
}
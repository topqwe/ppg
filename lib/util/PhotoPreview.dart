import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

typedef PageChanged = void Function(int index);
class PhotoPreview extends StatefulWidget {
  final List galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PageChanged pageChanged; //切换图片回调
  final Axis direction; //图片查看方向
  // final Decoration decoration;//背景设计

  PhotoPreview(
      {required this.galleryItems,
        this.defaultImage = 0,
        required this.pageChanged,
        this.direction = Axis.horizontal,
        // required this.decoration
      })
      : assert(galleryItems != null);
  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  late int tempSelect;
  @override
  void initState() {
    // TODO: implement initState
    tempSelect=widget.defaultImage+1;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
              child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.galleryItems[index]),
                    );
                  },
                  scrollDirection: widget.direction,
                  itemCount: widget.galleryItems.length,
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  pageController: PageController(initialPage: widget.defaultImage),
                  onPageChanged: (index) =>setState(() {
                    tempSelect=index+1;
                    if( widget.pageChanged!=null)
                    {widget.pageChanged(index);}
                  }))),

          Positioned(///布局自己换
            left: 20,
            top: 20,
            child:

            GestureDetector(child:
            // Text('$tempSelect/${widget.galleryItems.length}',style: TextStyle(color:Colors.black),),
            Container(width: 130,height: 130,
              color: Colors.transparent,
              alignment: Alignment.topLeft,
              // padding: EdgeInsets.only(right: 0,top: 0),
              margin: const EdgeInsets.only(left: 0,top: 24),
              child:
              Icon(
                size:25,
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
              onTap: (){
                Navigator.pop(context);
              },
          )
            ,)
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:noticias/models/noticia.dart';

class NoticiaCard extends StatefulWidget {

  final Noticia noticia;
  
  NoticiaCard({
    Key key,
    @required this.noticia
  }) : super(key: key);

  @override
  _NoticiaCardState createState() => _NoticiaCardState();
}

class _NoticiaCardState extends State<NoticiaCard> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double cardWidth = width*0.9;
    double cardHeight = (cardWidth/21)*9;
    double imageWidth = cardWidth*0.33;
    double contentWidth = cardWidth*0.67;
    double horMargin = (width - cardWidth) * 0.5;
  
    return Card(
      elevation: 4,
      semanticContainer: true,
      margin: EdgeInsets.only(bottom: width/10, left: horMargin, right: horMargin),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children:[
          Image.network(
            widget.noticia.urlToImage,
            fit: BoxFit.fill,
            height: cardHeight,
            width: imageWidth
          ),
          Container(
            width: contentWidth,
            height: cardHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.noticia.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                      ),
                      Text(
                        widget.noticia.publishedAt,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]
                  ),
                  Text(
                      widget.noticia.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2
                  ),
                  Text(
                    widget.noticia.author,
                    overflow: TextOverflow.ellipsis,
                  )
                ]
              )
            )
          )
        ]
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      )
    );
  }
}
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/stacked-thumbnails.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class StockItemComponent extends StatefulWidget {
  final Stock item;
  final Function addAction;

  const StockItemComponent({@required this.item, @required this.addAction});

  @override
  _StockItemComponentState createState() =>
      _StockItemComponentState(item, addAction);
}

class _StockItemComponentState extends State<StockItemComponent> {
  final Stock item;
  final Function addAction;
  bool _expanded = false;

  bool get expanded => _expanded;
  set expanded(bool expanded) {
    _expanded = expanded;
    setState(() {});
  }

  _StockItemComponentState(this.item, this.addAction);

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];

    widgets.addAll([
      Container(
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              width: !item.hasImages? 130 : 90,
              child:Text(
            "${item.name}",
            style: Forms.INPUT_TEXT_STYLE,
            )),
           !item.hasImages ? Container() : Container(
        margin: EdgeInsets.only(right: 8),
        child: StackedThumbnails(urls: item.images),
      ) 
          ]
        )),
      Container(
          child: Text(
        "R${Utils.formatToCurrency(item.price)}",
        style: Forms.INPUT_TEXT_STYLE,
      )),
      Container(
          child: FlatButton(
              onPressed: item.itemsAvailable > 0
                  ? () => addAction(item.take(1))
                  : null,
              child: Text("ADD")))
    ]);

    return GestureDetector(
        onTap: () => expanded = !expanded && item.hasImages,
        child: Container(
            //height: 62,
            padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: IjudiColors.color5, width: 0.05),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widgets,
                ),
                !expanded
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        child: CarouselSlider(
                            items: item.images
                                .map((url) => Container(
                                        decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: IjudiColors.color3,
                                        width: 10,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(url),
                                        fit: BoxFit.cover,
                                      ),
                                    )))
                                .toList(),
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 4),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            )),
                      )
              ],
            )));
  }
}
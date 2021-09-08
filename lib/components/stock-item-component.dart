import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-selection-component.dart';
import 'package:ijudi/components/stacked-thumbnails.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class StockItemComponent extends StatefulWidget {
  final Stock item;
  final Function addAction;

  const StockItemComponent({required this.item, required this.addAction});

  @override
  _StockItemComponentState createState() =>
      _StockItemComponentState(item, addAction);
}

class _StockItemComponentState extends State<StockItemComponent>
    with MessageDialogs {
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            width: 152,
            child: Text(
              "${item.name}",
              style: Forms.INPUT_TEXT_STYLE,
            )),
        !item.hasImages
            ? Container(
                height: 65,
              )
            : Container(
                margin: EdgeInsets.only(right: 8, left: 8),
                child: StackedThumbnails(urls: item.images),
              )
      ])),
      Container(
          margin: EdgeInsets.only(right: 16),
          child: Text(
            "R${Utils.formatToCurrency(item.price)}",
            style: Forms.INPUT_TEXT_STYLE,
          ))
    ]);

    return GestureDetector(
        onTap: item.itemsAvailable <= 0 ? null : () => openSeletionDialog(),
        child: Container(
            //height: 62,
            padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: IjudiColors.color5, width: 0.05),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widgets,
            )));
  }

  openSeletionDialog() {
    List<Widget> mandatorySelection = [];
    item.mandatorySelection?.forEach((option) {
      mandatorySelection.add(IjudiSelectionComponent(option: option));
    });

    showMessageDialog(context,
        title: item.name,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: item.mandatorySelection == null ||
                    item.mandatorySelection!.isEmpty
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height,
            child: ListView(children: [
              item.images == null
                  ? Container(
                      margin: EdgeInsets.only(top: 16),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: Container(
                          height: 200,
                          child: CarouselSlider(
                              items: item.images!
                                  .map((url) => Container(
                                          decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: IjudiColors.color3,
                                          width: 2,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(url),
                                          fit: BoxFit.cover,
                                        ),
                                      )))
                                  .toList(),
                              options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.9,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 4),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ))),
                    ),
              Container(
                  margin: EdgeInsets.all(16),
                  child: Table(children: [
                    TableRow(
                      children: [
                        Text("Price"),
                        Text("R ${Utils.formatToCurrency(item.price)}")
                      ],
                    ),
                    item.description == null || item.description!.isEmpty
                        ? TableRow(children: [Container(), Container()])
                        : TableRow(
                            children: [
                              Text("Description"),
                              Text("${item.description}")
                            ],
                          )
                  ])),
              item.mandatorySelection == null ||
                      item.mandatorySelection!.isEmpty
                  ? Container()
                  : Container(
                      margin: EdgeInsets.all(16),
                      child: Text(
                        "Choices",
                        style: IjudiStyles.HEADER_2,
                      )),
              Container(
                  margin: EdgeInsets.all(16),
                  child: Column(children: mandatorySelection))
            ])),
        actionName: "Add",
        action: () => addAction(item));
  }
}

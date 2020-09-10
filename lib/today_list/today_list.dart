import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'arrow_button.dart';
import 'colors.dart';
import 'header_icon.dart';
import 'search.dart';

class TodayList extends StatelessWidget {
  const TodayList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/background.jpg',
            ),
          ),
        ),
        alignment: Alignment.topLeft,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Search(),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      TodayListTile(
                        title: 'Teléfono',
                        main: _BrandTable(
                          list: [
                            _TableRowData(
                                text: 'Calls:',
                                color: Colors.yellow,
                                count: 3,
                                hasPoint: true),
                            _TableRowData(
                                text: 'Messages:',
                                color: Colors.greenAccent,
                                count: 2,
                                hasPoint: true),
                          ],
                        ),
                        extra: _BrandTable(
                          list: [
                            _TableRowData(
                                text: 'Emails:',
                                color: Colors.blue,
                                count: 99,
                                hasPoint: true),
                            _TableRowData(
                                text: 'SMS:',
                                color: Colors.greenAccent,
                                count: 0,
                                hasPoint: false),
                          ],
                        ),
                        icon: HeaderIcon(
                          iconData: CupertinoIcons.phone_solid,
                          gradient: BrandColors.gradient3,
                        ),
                      ),
                      TodayListTile(
                        title: 'Duración de la batería',
                        main: _BrandTable(
                          list: [
                            _TableRowData(
                                text: 'Time left:',
                                color: Colors.orangeAccent,
                                count: 2,
                                hasPoint: true),
                            _TableRowData(
                                text: 'Time needed to full charge:',
                                color: Colors.greenAccent,
                                count: 3,
                                hasPoint: true),
                          ],
                        ),
                        icon: HeaderIcon(
                          iconData: CupertinoIcons.battery_25_percent,
                          gradient: BrandColors.gradient2,
                        ),
                      ),
                      TodayListTile(
                        title: 'Despertador',
                        main: _BrandTable(
                          list: [
                            _TableRowData(
                                text: 'Calls:',
                                color: Colors.yellow,
                                count: 3,
                                hasPoint: true),
                            _TableRowData(
                                text: 'Messages:',
                                color: Colors.greenAccent,
                                count: 2,
                                hasPoint: true),
                          ],
                        ),
                        icon: HeaderIcon(
                          iconData: CupertinoIcons.clock,
                          gradient: BrandColors.gradient1,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 600,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodayListTile extends StatefulWidget {
  const TodayListTile({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.main,
    this.extra,
  })  : assert(main != null),
        assert(title != null),
        assert(icon != null),
        super(key: key);

  final String title;
  final HeaderIcon icon;
  final Widget main;
  final Widget extra;

  @override
  _TodayListTileState createState() => _TodayListTileState();
}

class _TodayListTileState extends State<TodayListTile> {
  double maxExtend = 200;

  double extraHeight;
  double mainHeight;

  final GlobalKey mainKey = GlobalKey();
  final GlobalKey extraKey = GlobalKey();
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
        () {
          mainHeight = mainKey.currentContext.size.height;
          if (widget.extra != null) {
            extraHeight = extraKey.currentContext.size.height;
          }
          maxExtend = mainHeight + 45;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _TodayListTileDelegate(
          mainKey: mainKey,
          extraKey: extraKey,
          widget: widget,
          maxExtent: maxExtend,
          isOpen: isOpen,
          setMaxExtend: (bool isOpen) {
            setState(() {
              this.isOpen = isOpen;
              this.maxExtend =
                  (isOpen ? mainHeight + extraHeight : mainHeight) + 45;
            });
          }),
    );
  }
}

class _TodayListTileDelegate extends SliverPersistentHeaderDelegate {
  final TodayListTile widget;
  final void Function(bool isOpen) setMaxExtend;

  _TodayListTileDelegate({
    this.widget,
    this.maxExtent,
    this.setMaxExtend,
    this.mainKey,
    this.extraKey,
    this.isOpen,
  });

  final Key mainKey;
  final Key extraKey;
  final bool isOpen;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    var leftSize = maxExtent - shrinkOffset;
    var v = leftSize.clamp(0, 45) / 45;

    bool isShrinking = v < 1;

    var scale = v * 0.2 + 0.8;
    var dy = 5 - (leftSize.clamp(0, 30) / 30) * 5;
    var child = Transform.scale(
      scale: scale,
      child: Transform.translate(
        offset: Offset(0, dy),
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: isShrinking ? 40 : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.18),
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      tileHeader(),
                      Container(
                        key: mainKey,
                        child: widget.main,
                      ),
                      if (widget.extra != null)
                        Container(
                          key: extraKey,
                          child: widget.extra,
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (isShrinking) {
      return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: IgnorePointer(
          ignoringSemantics: false,
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: child,
          ),
        ),
      );
    }

    return child;
  }

  Padding tileHeader() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          widget.icon,
          SizedBox(width: 10),
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.white30,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Spacer(),
          if (widget.extra != null)
            ArrowButton(
              onTap: setMaxExtend,
              isExpanded: isOpen,
            ),
        ],
      ),
    );
  }

  @override
  double maxExtent;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _BrandTable extends StatelessWidget {
  const _BrandTable({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<_TableRowData> list;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Table(
        defaultColumnWidth: FlexColumnWidth(0.2),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(0.5),
        },
        children: list
            .map((d) => buildRow(d.text, d.color, d.count, d.hasPoint))
            .toList(),
      ),
    );
  }

  TableRow buildRow(
    String text,
    Color color,
    int count,
    bool hasPoint,
  ) {
    return TableRow(
      children: [
        Visibility(
          visible: hasPoint,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            width: 5,
            height: 5,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: color),
        ),
        Text(
          count.toString(),
          style: TextStyle(color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _TableRowData {
  _TableRowData({this.text, this.color, this.count, this.hasPoint});

  final String text;
  final Color color;
  final int count;
  final bool hasPoint;
}

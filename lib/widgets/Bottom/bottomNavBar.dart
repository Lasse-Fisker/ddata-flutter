import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/navigation/actions.dart';
import 'package:ddata/store/navigation/state.dart';
import 'package:ddata/store/period/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BottomBarNavItem {
  Icon icon;
  String title;
  NavigationPage pageIndex;

  BottomBarNavItem(this.icon, this.title, this.pageIndex);
}

class _BottomBarNavItemWidget extends StatelessWidget {
  final BottomBarNavItem _navItem;
  final NavigationPage _activePageIndex;
  final VoidCallback _onTapCallback;

  _BottomBarNavItemWidget(
      this._navItem, this._activePageIndex, this._onTapCallback);

  @override
  Widget build(BuildContext context) => new Expanded(
        flex: _activePageIndex == _navItem.pageIndex ? 5 : 3,
        child: new GestureDetector(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                  margin: new EdgeInsets.only(bottom: 4.0, top: 4.0),
                  child: _navItem.icon),
              new Text(
                _activePageIndex == _navItem.pageIndex ? _navItem.title : '',
                textAlign: TextAlign.center,
              )
            ],
          ),
          onTap: _onTapCallback,
        ),
      );
}

class _BottomBarShowSelectPeriodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Expanded(
        flex: 3,
        child: new StoreBuilder<AppState>(
          builder: (context, store) => new GestureDetector(
                child: new Center(
                  child: new Container(
                      margin: new EdgeInsets.only(bottom: 4.0, top: 4.0),
                      child: store.state.periodState.selectPeriodOpen
                          ? new Icon(Icons.keyboard_arrow_down)
                          : new Icon(Icons.keyboard_arrow_up)),
                ),
                onTap: () => store.dispatch(new SelectPeriodOpenAction(
                    !store.state.periodState.selectPeriodOpen)),
              ),
        ),
      );
}

class BottomNavBar extends StatelessWidget {
  List<BottomBarNavItem> _buildNavItems() => [
        new BottomBarNavItem(
            new Icon(Icons.show_chart), 'Averages', NavigationPage.AVERAGES),
        new BottomBarNavItem(
            new Icon(Icons.date_range), 'Days', NavigationPage.DAYS),
        new BottomBarNavItem(new Icon(Icons.pie_chart), 'Distribution',
            NavigationPage.DISTRIBUTION),
        new BottomBarNavItem(
            new Icon(Icons.settings), 'Settings', NavigationPage.SETTINGS),
      ];

  @override
  Widget build(BuildContext context) => new Container(
        height: 65.0,
        padding: new EdgeInsets.all(8.0),
        color: Colors.white,
        child: new StoreBuilder<AppState>(
          builder: (context, store) => new Row(
              mainAxisSize: MainAxisSize.max,
              children: new List.from(_buildNavItems()
                  .map((navItem) => new _BottomBarNavItemWidget(
                      navItem,
                      store.state.navigation.activePage,
                      () => store
                          .dispatch(new ChangePageAction(navItem.pageIndex))))
                  .toList())
                ..add(new _BottomBarShowSelectPeriodWidget())),
        ),
      );
}

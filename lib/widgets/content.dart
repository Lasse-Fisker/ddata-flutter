import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/app/store.dart';
import 'package:ddata/store/navigation/actions.dart';
import 'package:ddata/store/navigation/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../widgets/day/day.dart';
import '../widgets/averages/averages.dart';

class Content extends StatelessWidget {
  final PageController _pageController = new PageController(keepPage: true);

  final _pages = [new AveragesWidget(), new DaysWidget()];

  _initNavChangeListen() => store.onChange
      // skip initial state
      .skip(1)
      .map((state) => state.navigation.activePage.index)
      .where((page) => _pageController.page != page)
      .distinct()
      .listen((page) => _pageController.animateToPage(page,
          duration: new Duration(milliseconds: 200), curve: Curves.ease));

  @override
  Widget build(BuildContext context) {
    _initNavChangeListen();
    return new Positioned.fill(
        bottom: 65.0,
        child: new PageView(
          children: _pages,
          controller: _pageController,
          onPageChanged: (int page) => StoreProvider
              .of<AppState>(context)
              .dispatch(new ChangePageAction(NavigationPage.values[page])),
        ));
  }
}

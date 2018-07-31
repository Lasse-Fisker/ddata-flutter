import 'package:ddata/store/navigation/actions.dart';
import 'package:ddata/store/navigation/state.dart';
import 'package:redux/redux.dart';

Reducer<NavigationState> navigationReducer = combineReducers([
  TypedReducer<NavigationState, ChangePageAction>(_setActivePageReducer),
]);

NavigationState _setActivePageReducer(
        NavigationState lastState, ChangePageAction action) =>
    new NavigationState(action.newPageIndex);

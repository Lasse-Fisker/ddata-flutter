import 'package:ddata/store/app/reducer.dart';
import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/app/sideEffects.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

Persistor<AppState> persistor = Persistor<AppState>(
    storage:
        FlutterStorage("ddata", location: FlutterSaveLocation.documentFile),
    decoder: AppState.fromJson);

final Store<AppState> store = new Store<AppState>(appReducer,
    initialState: new AppState.empty(),
    middleware: [new LoggingMiddleware.printer(), appSideEffectsMiddleware]);

loadState() => persistor.load(store);

saveState() => persistor.save(store);

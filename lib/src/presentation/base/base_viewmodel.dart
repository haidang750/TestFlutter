import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/src/resources/resources.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;

  BuildContext get context => _context!;

  setContext(BuildContext value) {
    _context = value;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final NewsRepository newsRepository = NewsRepository();

  void unFocus() {
    FocusScope.of(context).unfocus();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
}

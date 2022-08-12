import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

class AppPrefs {
  AppPrefs._();

  static final GetStorage _box = GetStorage('AppPref');

  static final BehaviorSubject<dynamic> _localNews = BehaviorSubject();

  static initListener() async {
    await GetStorage.init("AppPref");
    _box.listenKey('local_news', (listNews) {
      _localNews.add(listNews);
    });
  }

  static set localNews(List<String> listNews) => _box.write('local_news', listNews);

  static List<String> get localNews {
    final _ = _box.read('local_news');
    if (_ == null) return [];
    return _ is List<String>
        ? _
        : List<String>.from(_box.read('local_news').map((x) => x.toString()));
  }

  static Stream get watchLocalNews => _localNews.stream;
}

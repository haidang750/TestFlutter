import 'package:flutter/material.dart';
import 'package:news_app/src/presentation/widgets/widget_image_network.dart';
import 'package:news_app/src/resources/resources.dart';
import '../presentation.dart';

class ListNewsScreen extends StatefulWidget {
  const ListNewsScreen({Key? key}) : super(key: key);

  @override
  _ListNewsScreenState createState() => _ListNewsScreenState();
}

class _ListNewsScreenState extends State<ListNewsScreen> with ResponsiveWidget {
  late ListNewsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ListNewsViewModel>(
        viewModel: ListNewsViewModel(),
        onViewModelReady: (viewModel) => _viewModel = viewModel..init(),
        builder: (context, viewModel, child) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SampleAnimation())),
                backgroundColor: Colors.blue,
                child: const Icon(Icons.arrow_forward_outlined),
              ),
              body: buildUi(context));
        });
  }

  @override
  Widget buildMobile(BuildContext context) => _buildScreen();

  @override
  Widget buildTablet(BuildContext context) => SizedBox();

  @override
  Widget buildDesktop(BuildContext context) => SizedBox();

  Widget _buildScreen() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _search(),
            _listNews(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(top: 55),
      child: Text("News App", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
    );
  }

  Widget _search() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        maxLines: 1,
        controller: _viewModel.searchController,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.bottom,
        style: TextStyle(fontSize: 18),
        onChanged: (value) => _viewModel.onSearch(value),
        onSubmitted: (value) => _viewModel.onSearch(value, isSubmit: true),
        decoration: InputDecoration(
          labelText: null,
          hintText: "Search for News",
          hintStyle:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFF616161)),
          suffixIcon: Padding(
            padding: EdgeInsets.zero,
            child: Icon(Icons.search, size: 36),
          ),
        ),
      ),
    );
  }

  Widget _listNews() {
    return Expanded(
      child: StreamBuilder(
        stream: _viewModel.listNews.stream,
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List<NewsModel> listNews = snapshot.data;

            return listNews.isNotEmpty
                ? ListView(
                padding: EdgeInsets.only(top: 20),
                children: List.generate(listNews.length, (index) => _oneNews(listNews[index])))
                : SizedBox();
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _oneNews(NewsModel news) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news))),
        child: Row(
          children: [
            WidgetImageNetwork(url: news.urlToImage, height: 95, width: 116),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.title ?? '',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(news.author ?? '',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      Container(width: 50, height: 2, color: Colors.black),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/src/presentation/widgets/widget_image_network.dart';
import 'package:news_app/src/resources/resources.dart';
import '../presentation.dart';
import 'package:get/get.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({Key? key, required this.news}) : super(key: key);

  final NewsModel news;

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> with ResponsiveWidget {
  late NewsDetailViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NewsDetailViewModel>(
        viewModel: NewsDetailViewModel(),
        onViewModelReady: (viewModel) => _viewModel = viewModel..init(),
        builder: (context, viewModel, child) {
          return Scaffold(body: buildUi(context));
        });
  }

  @override
  Widget buildMobile(BuildContext context) => _buildScreen();

  @override
  Widget buildTablet(BuildContext context) => SizedBox();

  @override
  Widget buildDesktop(BuildContext context) => SizedBox();

  Widget _buildScreen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          _content(),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(top: 55, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              child: Icon(Icons.arrow_back_ios, size: 26, color: Colors.black),
              onTap: () => Navigator.of(context).pop()),
          GestureDetector(
              child: Icon(Icons.save_alt_outlined, size: 28, color: Colors.black),
              onTap: () => _viewModel.saveNewsToLocal(widget.news))
        ],
      ),
    );
  }

  Widget _content() {
    NewsModel news = widget.news;

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFF616161),
                  radius: 26,
                  child: Text(news.author?[0] ?? '',
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w500, color: Color(0xFFFE5E5E5))),
                ),
                Container(
                  height: 52,
                  width: 2,
                  color: Colors.black,
                  margin: EdgeInsets.only(left: 20, right: 8),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(news.publishedAt?.split('T')[0] ?? '',
                          style: TextStyle(fontSize: 16, color: Color(0xFFF616161))),
                      SizedBox(height: 8),
                      Text(news.author ?? '',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(news.title ?? '', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36)),
            SizedBox(height: 27),
            Text(news.description ?? '', style: TextStyle(fontSize: 18, color: Color(0xFFF616161))),
            SizedBox(height: 40),
            Text("Read news", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(width: 50, height: 2, color: Colors.black),
            SizedBox(height: 20),
            WidgetImageNetwork(url: news.urlToImage, height: 230, width: Get.width),
            SizedBox(height: 27),
            Text(news.content ?? '', style: TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}

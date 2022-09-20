import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_read_json_file/Models/news_data.dart';
import '../Widgets/news_card.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  @override
  Widget build(BuildContext context) {
    // This helps to notify listeners for updated data each time the app runs
    context.read<NewsData>().fetchData;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<NewsData>().initialValues();
              context.read<NewsData>().fetchData;
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<NewsData>().fetchData;
        },
        child: Center(
          child: Consumer<NewsData>(
            builder: (context, value, child) {
              return value.map.isEmpty && !value.error
                  ? const CircularProgressIndicator()
                  : value.error
                      ? Text(
                          "Oops! Something went wrong. ${value.errormessage}",
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: value.map['Stories'].length,
                          itemBuilder: (context, index) {
                            return NewsCard(map: value.map['Stories'][index]);
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}

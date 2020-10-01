import 'package:flutter/material.dart';
import 'package:journal_app/providers/story_provider.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  final PageController pageController;
  Home({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double _pageOffset = 0;

  PageController _storyPageController;

  double viewportFraction = 0.8;

  List<Map<String, dynamic>> stories;

  @override
  void initState() {
    super.initState();
    _storyPageController = PageController(
      initialPage: 0,
      viewportFraction: viewportFraction,
      keepPage: true,
    )..addListener(() {
        setState(() {
          _pageOffset = _storyPageController.page;
        });
      });
  }

  @override
  void dispose() {
    _storyPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stories = context.select((StoryProvider storyProvider) => storyProvider.getStories);
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    widget.pageController.animateToPage(
                      2,
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 350),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            height: 380,
            child: PageView.builder(
              reverse: true,
              controller: _storyPageController,
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                return buildStories(_pageOffset, index.toDouble(), stories);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              iconSize: 40.0,
              onPressed: () {
                widget.pageController.animateToPage(
                  0,
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 350),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  buildStories(
      double offset, double index, List<Map<String, dynamic>> stories) {
    double scale = (index - offset).abs();
    return Container(
      margin: EdgeInsets.only(
        top: scale * MediaQuery.of(context).size.width * 0.08 + 5.0,
        bottom:scale * MediaQuery.of(context).size.width * 0.08 + 5.0,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).primaryColorLight,
        child: Text(
          '${stories[index.toInt()]['year']} \n ${stories[index.toInt()]['month']}',
        ),
      ),
    );
  }
}

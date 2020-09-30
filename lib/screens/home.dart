import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/providers/story_provider.dart';
import 'package:journal_app/route_transitions/scale_transition.dart';
import 'package:journal_app/screens/story.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {

  final PageController pageController;
  Home({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  final PageController _storyPageController = PageController(
    initialPage: 0,
    viewportFraction: 0.7,
    keepPage: true,
  );

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
     create: (context) => StoryProvider(),
      builder: (context, child){
       var storyProvider = context.watch<StoryProvider>();
       _activePage = storyProvider.getCurrentIndex;
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
                        pageController.animateToPage(
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
                height: 360,
                child: PageView.builder(
                  reverse: true,
                  controller: _storyPageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: storyPages.length,
                  onPageChanged: (int) {
                   storyProvider.setCurrentIndex(int);
                  },
                  itemBuilder: (context, index) {
                    return buildStories(context, storyPages, index, _activePage);
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
                    pageController.animateToPage(
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
      },
    );
  }

  List<Map<String, dynamic>> storyPages = [
    {'color': Colors.white, 'date': '20th April', 'year': '2020'},
    {'color': Colors.white, 'date': '19th April', 'year': '2020'},
    {'color': Colors.white, 'date': '19th April', 'year': '2020'}
  ];

  buildStories(BuildContext context, List<Map<String, dynamic>> children,
      int index, int active) {
    return GestureDetector(
      onTap: () {
        if (index != active) return;
        Navigator.of(context).push(CustomScalePageRoute().createRoute(
          route: Story(),
          duration: Duration(milliseconds: 350),
          scale: 0.8,
        ));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.decelerate,
        decoration: BoxDecoration(
            color: children[index]['color'],
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: index == active
                ? [
                    BoxShadow(
                      color: Theme.of(context).textTheme.caption.color.withAlpha(150),
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      offset: Offset(0, 0.5),
                    ),
                  ]
                : []),
        margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          top: index == active ? 0.0 : MediaQuery.of(context).size.width * 0.12,
          bottom:
              index == active ? 0.0 : MediaQuery.of(context).size.width * 0.12,
        ),
        child: Stack(
          overflow: Overflow.clip,
          children: [
            Container(
              // color: Colors.red,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/200/300/?random'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 10.0,
              child: Container(
                color: Theme.of(context).cardColor.withAlpha(150),
                padding: EdgeInsets.all(2.0),
                child: Text(
                  children[index]['year'] ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Positioned(
              top: 40.0,
              left: 10.0,
              child: Container(
                color: Theme.of(context).cardColor.withAlpha(150),
                padding: EdgeInsets.all(2.0),
                child: Text(
                  children[index]['date'] ?? '',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

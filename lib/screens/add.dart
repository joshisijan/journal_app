import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/widgets/add_image.dart';

class Add extends StatelessWidget {
  final PageController pageController;
  const Add({
    Key key,
    @required this.pageController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              SizedBox(
                height: 80.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    AddImage(),
                    Container(
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateTime.now().year.toString(),
                            style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('dd MMMM').format(DateTime.now()).toString(),
                            style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10.0,
          right: 15.0,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: (){
                pageController.animateToPage(
                  1,
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 350),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

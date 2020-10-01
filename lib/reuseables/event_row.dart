import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventRow extends StatelessWidget {
  final TimeOfDay time;
  final String text;

  const EventRow({
    Key key,
    @required this.time,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.25 - 5.0,
                child: Container(
                  child: Text(
                    time.format(context).toString(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1 - 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65 - 5.0,
                padding: EdgeInsets.only(
                  bottom: 10.0,
                  top: 10,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: -20.0,
            left: MediaQuery.of(context).size.width * 0.22 + 6.5,
            bottom: -20.0,
            child: Container(
              width: 2.0,
              color: Theme.of(context).colorScheme.onPrimary.withAlpha(255),
            ),
          ),
          Positioned(
            top: -10,
            left: MediaQuery.of(context).size.width * 0.22,
            child: Container(
              width: 15.0,
              height: 15.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary.withAlpha(255),
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
        ],
      ),
    );
  }
}

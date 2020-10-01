import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/providers/cache_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CacheManager extends StatelessWidget {
  int cacheSize = 0;

  @override
  Widget build(BuildContext context) {
    cacheSize = context
        .select((CacheProvider cacheProvider) => cacheProvider.getCacheSize);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${convertSize(cacheSize)} of Storage is used for Cache',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          cacheSize > 0 ?  SizedBox(height: 10.0,) : SizedBox.shrink(),
          cacheSize > 0
              ? MaterialButton(
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    'Clear Cache',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    context.read<CacheProvider>().deleteCache();
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  String convertSize(int n) {
    if (n > 1024) {
      double kb = (n / 1025).toDouble();
      if (kb > 1024) {
        double mb = kb / 1024;
        if (mb > 1024) {
          double gb = mb / 1024;
          return '${gb.toStringAsFixed(1)} GB';
        } else {
          return '${mb.toStringAsFixed(1)} MB';
        }
      } else {
        return '${kb.toStringAsFixed(1)} KB';
      }
    } else {
      return '${n.toStringAsFixed(1)} bytes';
    }
  }
}

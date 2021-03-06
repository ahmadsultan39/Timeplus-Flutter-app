import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/watches.dart';

import '../screens/watch_details_screen.dart';

class DiscoverListItem extends StatefulWidget {
  final String id;

  DiscoverListItem(this.id);
  @override
  _DiscoverListItemState createState() => _DiscoverListItemState();
}

class _DiscoverListItemState extends State<DiscoverListItem> {
  @override
  Widget build(BuildContext context) {
    final watches = Provider.of<WatchesProvider>(context, listen: false);
    final watch = watches.findId(widget.id);
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(WatchDetailsScreen.routeName, arguments: watch);
      },
      child: Hero(
        tag: watch.id,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: mediaQuery.size.width * 0.30 + 8,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.30,
                  height: mediaQuery.size.width * 0.30,
                  margin: const EdgeInsets.only(right: 8),
                  child: CachedNetworkImage(
                    imageUrl: watch.imageUrl,
                    placeholder: (context, url) =>
                        Image.asset('assets/images/watch.png'),
                    errorWidget: (context, url, error) =>
                        const Center(child: const Icon(Icons.error)),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: mediaQuery.size.width * 0.60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        watch.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(watch.price.toStringAsFixed(0) + ' SYP'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

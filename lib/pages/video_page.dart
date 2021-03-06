import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/videos.dart';

class VideoPage extends StatelessWidget {
  static const TextStyle BottomInfoStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Color(0xFFAAAAAA),
    fontSize: 12,
    fontFamily: 'Roboto',
  );

  final String id;
  final VoidCallback incrementSubscribeCounter;

  VideoPage({required this.id, required this.incrementSubscribeCounter});

  @override
  Widget build(BuildContext context) {
    final videos = context.watch<Videos>();
    final video = videos.getVideoById(this.id);
    final _previewImage = video['previewImage'];
    final _description = video['description'];
    final _channelAvatarImage = video['channelAvatarImage'];
    final _channelName = video['channelName'];
    final _views = video['views'];
    final _uploadedAt = video['uploadedAt'];
    final _likes = video['likes'];
    final _dislikes = video['dislikes'];
    final _followers = video['followers'];
    final _isLiked = video['isLiked'];

    return Hero(
      tag: this.id,
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_previewImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop('watched');
                        },
                        icon: Icon(Icons.keyboard_arrow_down),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    _description,
                                    style: TextStyle(fontSize: 18),
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  "$_views views",
                                  style: BottomInfoStyle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Color(0xFFAAAAAA),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                child: Text(
                                  _uploadedAt,
                                  style: BottomInfoStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Provider.of<Videos>(context, listen: false).like(this.id);
                      },
                      child: Column(
                        children: [
                          Icon(_isLiked == 'liked' ? Icons.thumb_up : Icons.thumb_up_outlined),
                          Divider(
                            thickness: 0,
                            height: 3,
                          ),
                          Text(NumberFormat.compact().format(_likes)),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Videos>(context, listen: false).dislike(this.id);
                      },
                      child: Column(
                        children: [
                          Icon(_isLiked == 'disliked' ? Icons.thumb_down : Icons.thumb_down_outlined),
                          Divider(
                            thickness: 0,
                            height: 3,
                          ),
                          Text(NumberFormat.compact().format(_dislikes)),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(Icons.send_outlined),
                          Divider(
                            thickness: 0,
                            height: 3,
                          ),
                          Text('SHARE'),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(Icons.playlist_add),
                          Divider(
                            thickness: 0,
                            height: 3,
                          ),
                          Text('SAVE'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // channel info
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(_channelAvatarImage),
                              ),
                            ),
                            Container(
                              width: 88,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            _channelName,
                                            style: TextStyle(fontSize: 14),
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            '$_followers followers',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        this.incrementSubscribeCounter();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'FOLLOW',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: IconButton(
                        icon: Icon(Icons.notifications_outlined),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

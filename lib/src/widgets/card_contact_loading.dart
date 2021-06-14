import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CardContactLoading extends StatelessWidget {
  final bool? direction;
  const CardContactLoading({Key? key, this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: (direction!)
          ? BounceInLeft(
              child: Container(
                  child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1.5, 1.5), // changes position of shadow
                    ),
                  ],
                ),
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Skeleton(
                                width: 80,
                                textColor: Colors.grey[300],
                                height: 10,
                                style: SkeletonStyle.circle),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Skeleton(
                                  width: 80,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                              SizedBox(
                                height: 5,
                              ),
                              Skeleton(
                                  width: 90,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                              SizedBox(
                                height: 10,
                              ),
                              Skeleton(
                                  width: 80,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                              SizedBox(
                                height: 5,
                              ),
                              Skeleton(
                                  width: 160,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                            ],
                          ),
                        ],
                      )),
                ),
              )),
            )
          : BounceInRight(
              child: Container(
                  child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1.5, 1.5), // changes position of shadow
                    ),
                  ],
                ),
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Skeleton(
                                width: 80,
                                textColor: Colors.grey[300],
                                height: 10,
                                style: SkeletonStyle.circle),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Skeleton(
                                  width: 80,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                              SizedBox(
                                height: 5,
                              ),
                              Skeleton(
                                  width: 90,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                              SizedBox(
                                height: 10,
                              ),
                              Skeleton(
                                  width: 80,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                              SizedBox(
                                height: 5,
                              ),
                              Skeleton(
                                  width: 160,
                                  textColor: Colors.grey[300],
                                  height: 10,
                                  style: SkeletonStyle.text),
                            ],
                          ),
                        ],
                      )),
                ),
              )),
            ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CardMovementsLoading extends StatelessWidget {
  final bool? direction;
  const CardMovementsLoading({Key? key, this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return (direction!)
        ? BounceInLeft(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: size.height * 0.12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 60,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 80,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 50,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 80,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 45,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 70,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 30,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 50,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )))
        : BounceInRight(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: size.height * 0.12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 60,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 80,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 50,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 80,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 45,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 70,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                      width: 30,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Skeleton(
                                      width: 50,
                                      textColor: Colors.grey[300],
                                      height: 10,
                                      style: SkeletonStyle.text),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )));
  }
}

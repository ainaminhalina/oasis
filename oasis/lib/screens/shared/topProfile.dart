import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/user.dart';

import 'colors.dart';

awesomeTopProfile(BuildContext context, double screenWidth, User user) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 67),
      height: 116.5,
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 75,
                width: 75,
                color: Colors.grey,
                child: user.profilePicture == null || user.profilePicture == ''
                    ? Icon(
                        Icons.person,
                        color: black,
                      )
                    : CachedNetworkImage(
                        imageUrl: user.profilePicture,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
          ),
          SizedBox(width: 12.5),
          Center(
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.displayName,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 21)),
                  SizedBox(height: 5),
                  Text(
                    user.phoneNumber,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

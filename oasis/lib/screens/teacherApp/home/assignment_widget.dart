import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/assignment.dart';
import 'package:oasis/screens/shared/colors.dart';

class AssignmentWidget extends StatelessWidget {
  AssignmentWidget({this.assignment});

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.7,
              color: dividerColor,
            ),
          ),
        ),
        padding: EdgeInsets.only(bottom: 10.5),
        child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => BookVehicleView(
              //             vehicle: vehicle, vehicleProfile: vehicleProfile)));
            },
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                //   child: (vehicle.vehiclePicture != null &&
                //           vehicle.vehiclePicture != '')
                //       ? Image.network(vehicle.vehiclePicture)
                //       : Image.asset('assets/images/car.png'),
                // ),
                ListTile(
                  dense: true,
                  title: Text(
                    assignment.startDate + ' - ' + assignment.endDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                        // Text(
                        //   vehicleProfile.displayName,
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 13.5,
                        //       fontWeight: FontWeight.w400),
                        // ),
                        // SizedBox(height: 8.5),
                        // Row(
                        //   children: [
                        //     Text(
                        //       vehicle.description,
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 13.0,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

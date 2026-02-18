// import 'package:flutter/material.dart';
// import 'package:flutter_application_testmaps/core/constants/AppColors.dart';
// import 'package:flutter_application_testmaps/core/features/home/data/model/mapmodel.dart';

// class DistanceAndTime extends StatelessWidget {
//   final RouteModel? placeDirections;
//   final isTimeAndDistanceVisible;

//   const DistanceAndTime({
//     super.key,
//     this.placeDirections,
//     required this.isTimeAndDistanceVisible,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isTimeAndDistanceVisible,
//       child: Positioned(
//         top: 0,
//         bottom: 570,
//         left: 0,
//         right: 0,
//         child: Row(
//           children: [
//             Flexible(
//               flex: 1,
//               child: Card(
//                 elevation: 6,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
//                 color: AppColors.white,
//                 child: ListTile(
//                   dense: true,
//                   horizontalTitleGap: 0,
//                   leading: Icon(
//                     Icons.access_time_filled,
//                     color: AppAppColors.blue,
//                     size: 30,
//                   ),
//                   title: Text(
//                     placeDirections!.duration.toString(),
//                     style: TextStyle(color: AppColors.black, fontSize: 16),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 30),
//             Flexible(
//               flex: 1,
//               child: Card(
//                 elevation: 6,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
//                 color: AppColors.white,
//                 child: ListTile(
//                   dense: true,
//                   horizontalTitleGap: 0,
//                   leading: Icon(
//                     Icons.directions_car_filled,
//                     color: AppAppColors.blue,
//                     size: 30,
//                   ),
//                   title: Text(
//                     placeDirections!.distance.toString(),
//                     style: TextStyle(color: AppColors.black, fontSize: 16),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_testmaps/core/constants/colors.dart';
import 'package:flutter_application_testmaps/core/features/home/data/model/mapmodel.dart';

class DistanceAndTime extends StatelessWidget {
  final RouteModel? placeDirections;
  final bool isTimeAndDistanceVisible;

  const DistanceAndTime({
    super.key,
    this.placeDirections,
    required this.isTimeAndDistanceVisible,
  });

  @override
  Widget build(BuildContext context) {
    if (!isTimeAndDistanceVisible) {
      return const SizedBox();
    }

    // تحويل الوقت والمسافة
    final durationMinutes = (placeDirections!.duration / 60).toStringAsFixed(0);
    final distanceKm = (placeDirections!.distance / 1000).toStringAsFixed(1);

    return Positioned(
      top: 120,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.white,
              child: ListTile(
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(
                  Icons.access_time_filled,
                  color: AppColors.blue,
                  size: 30,
                ),
                title: Text(
                  "$durationMinutes min",
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.white,
              child: ListTile(
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(
                  Icons.directions_car_filled,
                  color: AppColors.blue,
                  size: 30,
                ),
                title: Text(
                  "$distanceKm km",
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

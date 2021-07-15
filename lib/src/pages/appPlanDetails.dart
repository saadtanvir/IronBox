// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ironbox/src/controllers/plans_controller.dart';
// import 'package:ironbox/src/models/plan.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:global_configuration/global_configuration.dart';
// import '../repositories/user_repo.dart' as userRepo;
// import '../helpers/app_constants.dart' as Constants;

// class AppPlanDetails extends StatefulWidget {
//   final Plan plan;
//   AppPlanDetails(this.plan);
//   @override
//   _AppPlanDetailsState createState() => _AppPlanDetailsState();
// }

// class _AppPlanDetailsState extends State<AppPlanDetails> {
//   PlansController _con = Get.put(PlansController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.only(bottom: 100),
//             padding: const EdgeInsets.only(bottom: 15),
//             child: CustomScrollView(
//               primary: true,
//               shrinkWrap: false,
//               slivers: <Widget>[
//                 SliverAppBar(
//                   backgroundColor:
//                       Theme.of(context).accentColor.withOpacity(0.9),
//                   expandedHeight: 250,
//                   elevation: 0,
//                   iconTheme:
//                       IconThemeData(color: Theme.of(context).primaryColor),
//                   flexibleSpace: FlexibleSpaceBar(
//                     collapseMode: CollapseMode.parallax,
//                     background: CachedNetworkImage(
//                       fit: BoxFit.contain,
//                       imageUrl:
//                           "${GlobalConfiguration().get('storage_base_url')}${widget.plan.imgUrl}",
//                       placeholder: (context, url) => Image.asset(
//                         'assets/img/loading.gif',
//                         fit: BoxFit.cover,
//                       ),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                     child: Wrap(
//                       runSpacing: 8.0,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Expanded(
//                               flex: 3,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     widget.plan?.name ?? '',
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 2,
//                                     style: const TextStyle(
//                                       fontSize: 15.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   Text(
//                                     "\$ ${widget.plan.price}",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 3),
//                               decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius: BorderRadius.circular(24)),
//                               child: Text(
//                                 "${widget.plan.duration.toString()} days",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .caption
//                                     .merge(TextStyle(color: Colors.white)),
//                               ),
//                             ),
//                             Expanded(child: SizedBox(height: 0)),
//                             // Container(
//                             //   padding: EdgeInsets.symmetric(
//                             //       horizontal: 12, vertical: 3),
//                             //   decoration: BoxDecoration(
//                             //       color: Theme.of(context).focusColor,
//                             //       borderRadius: BorderRadius.circular(24)),
//                             //   child: Text(
//                             //     widget.plan.duration,
//                             //     style: Theme.of(context)
//                             //         .textTheme
//                             //         .caption
//                             //         .merge(TextStyle(
//                             //             color: Theme.of(context).accentColor)),
//                             //   ),
//                             // ),
//                             // SizedBox(width: 5),
//                           ],
//                         ),
//                         Divider(
//                           height: 20,
//                           thickness: 1.0,
//                         ),
//                         Text(
//                           "Description:",
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15.0,
//                           ),
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                         ),
//                         Text("${widget.plan.description}"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 40.0,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               child: Center(
//                 child: TextButton(
//                   onPressed: () {
//                     if (userRepo.currentUser.value.id != null) {
//                       _con.buyPlan(
//                           context: context,
//                           planId: widget.plan.id,
//                           category: widget.plan.category,
//                           userId: userRepo.currentUser.value.id);
//                     }
//                   },
//                   child: Text(
//                     Constants.buyNow,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.all<EdgeInsets>(
//                         EdgeInsets.symmetric(horizontal: 30.0)),
//                     backgroundColor: MaterialStateProperty.all(
//                         Theme.of(context).primaryColor),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

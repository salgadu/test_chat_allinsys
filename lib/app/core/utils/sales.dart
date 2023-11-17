// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
// import 'package:mecca/app/components/costcenter_bottomsheet/costcenter_bottomsheet.dart';
// import 'package:mecca/app/components/new_alert.dart';
// import 'package:mecca/app/components/new_confirm_alert.dart';
// import 'package:mecca/app/constants/colors.dart';
// import 'package:mecca/app/constants/const.dart';
// import 'package:mecca/app/constants/permissions.dart';
// import 'package:mecca/app/repositories/app_repository.dart';
// import 'package:mecca/app/screens/accompany_page/accompany_controller.dart';
// import 'package:mecca/app/screens/bag_page/bag_controller.dart';
// import 'package:mecca/app/screens/event_page/event_controller.dart';
// import 'package:mecca/app/screens/information_page/information_controller.dart';
// import 'package:mecca/app/screens/intermediary_page/intermediary_controller.dart';
// import 'package:mecca/app/screens/sales_page/sales_controller.dart';
// import 'package:mecca/app/screens/success_page/success_page.dart';
// import 'package:mecca/app/utils/functions.dart';

// Future<bool> hasSelectCostCenter() async {
//   var boxData = Hive.box("data");
//   var appData = Map<String, dynamic>.from(boxData.get("appData") ?? {});
//   var info = Map<String, dynamic>.from(appData["info"] ?? {});
//   Map data = AppConst.appData();
//   List costCenters = data["costCenter"] ?? [];
//   if (costCenters.length > 1) {
//     await Get.dialog(
//       const NewAlert(
//           icon: "company",
//           title:
//               "Será necessário selecionar umncentro de custo para continuar"),
//       barrierColor: AppColors.black.withOpacity(0.5),
//     );
//     Map value = await Get.bottomSheet(
//           CostCenterBottomSheet(),
//           persistent: false,
//           isScrollControlled: true,
//           backgroundColor: Colors.transparent,
//           barrierColor: AppColors.black.withOpacity(0.3),
//         ) ??
//         {};
//     if (value.isNotEmpty) {
//       info["costCenterSelected"] = value["id"];
//       info["managerId"] = value["manager"];
//       info["managerName"] = value["name"];
//       info["managerComm"] = value["comission"] ?? value["commission"] ?? [];
//       appData["info"] = info;
//       await boxData.put("appData", appData);
//     } else {
//       return false;
//     }
//   } else {
//     try {
//       info["costCenterSelected"] = costCenters.first["id"];
//       info["managerId"] = costCenters.first["manager"];
//       info["managerName"] = costCenters.first["name"];
//       info["managerComm"] = costCenters.first["comission"] ??
//           costCenters.first["commission"] ??
//           [];
//       appData["info"] = info;
//       await boxData.put("appData", appData);
//     } catch (e) {
//       await Get.dialog(
//         const NewAlert(
//           title: "Não há centro dencusto disponivel",
//         ),
//         barrierColor: AppColors.black.withOpacity(0.5),
//       );
//       return false;
//     }
//   }

//   return true;
// }

// Future<bool> checkAvailability() async {
//   bool resultGeneral = false;
//   AppRepository appRepository = AppRepository();
//   Box boxSales = Hive.box("sales");
//   Map order = boxSales.get("order", defaultValue: {});
//   List services = jsonDecode(jsonEncode(order["services"] ?? []));
//   List hotels = jsonDecode(jsonEncode(order["hotels"] ?? []));

//   List servicesCombos =
//       services.where((element) => element["parent"] != null).toList();
//   services = services.where((element) => element["parent"] == null).toList();
//   for (var service in services) {
//     if (service["service"] != null) {
//       service["combo"] = servicesCombos
//           .where(
//               (comboService) => comboService["parent"] == service["identifier"])
//           .toList();
//     }
//   }

//   for (Map service in services) {
//     if ((service["combo"] ?? []).isEmpty) {
//       DateTime date = DateTime.parse(service["date"]);
//       Map result = await appRepository.getServiceAvailability(
//         startDate: DateFormat("yyyy-MM-dd", "pt_BR").format(date),
//         endDate: DateFormat("yyyy-MM-dd", "pt_BR").format(date),
//         serviceId: service["id"],
//         variation: service["variation"].toString(),
//       );
//       if (result["errorCode"] != null && result["errorCode"] == 0) {
//         List availabilityList = result["itens"] ?? [];
//         bool resultCheck = availabilityList.every((element) =>
//             (int.tryParse(element["balance"].toString()) ?? 0) > 0);
//         service["checkout"] = resultCheck;
//         if (!resultGeneral) {
//           resultGeneral = !resultCheck;
//         }
//       }
//     } else {
//       if (service["date"] != null) {
//         DateTime date = DateTime.parse(service["date"]);
//         Map result = await appRepository.getServiceAvailability(
//           startDate: DateFormat("yyyy-MM-dd", "pt_BR").format(date),
//           endDate: DateFormat("yyyy-MM-dd", "pt_BR").format(date),
//           serviceId: service["id"],
//           variation: service["variation"].toString(),
//         );
//         if (result["errorCode"] != null && result["errorCode"] == 0) {
//           List availabilityList = result["itens"] ?? [];
//           bool resultCheck = availabilityList.every((element) =>
//               (int.tryParse(element["balance"].toString()) ?? 0) > 0);
//           service["checkout"] = resultCheck;
//           if (!resultGeneral) {
//             resultGeneral = !resultCheck;
//           }
//         }
//       }
//       for (Map serv in (service["combo"] ?? [])) {
//         DateTime date = DateTime.parse(serv["date"]);
//         Map result = await appRepository.getServiceAvailability(
//           startDate: DateFormat("yyyy-MM-dd", "pt_BR").format(date),
//           endDate: DateFormat("yyyy-MM-dd", "pt_BR").format(date),
//           serviceId: serv["id"],
//           variation: serv["variation"].toString(),
//         );
//         if (result["errorCode"] != null && result["errorCode"] == 0) {
//           List availabilityList = result["itens"] ?? [];
//           bool resultCheck = availabilityList.every((element) =>
//               (int.tryParse(element["balance"].toString()) ?? 0) > 0);
//           serv["checkout"] = resultCheck;
//           if (!resultGeneral) {
//             resultGeneral = !resultCheck;
//           }
//         }
//       }
//     }
//   }

//   for (Map hotel in hotels) {
//     List availability = [];
//     Map period = hotel["period"] ?? {};
//     DateTime start = DateTime.parse(period["start"]);
//     DateTime end = DateTime.parse(period["end"]);
//     Map result = await appRepository.getServiceAvailability(
//       startDate: DateFormat("yyyy-MM-dd", "pt_BR").format(start),
//       endDate: DateFormat("yyyy-MM-dd", "pt_BR").format(end),
//       serviceId: hotel["id"].toString(),
//     );
//     if (result["errorCode"] != null && result["errorCode"] == 0) {
//       List availabilityList = result["itens"] ?? [];
//       Map accommodation = hotel["accommodation"] ?? {};

//       List accList = availabilityList
//           .where((avai) =>
//               avai["accommodation"].toString() ==
//               accommodation["id"].toString())
//           .toList();
//       int days = end.difference(start).inDays;
//       days = days == 0 ? 1 : days + 1;
//       DateTime dayVerified = start;
//       for (var i = 0; i < days; i++) {
//         if (accList.isEmpty ||
//             !accList.any((element) => dayVerified.isAtSameMomentAs(
//                 DateTime.tryParse(element["date"]) ?? DateTime.now()))) {
//           accList.add({
//             "date": dayVerified.toIso8601String(),
//             "balance": 0,
//             "accommodation": accommodation["id"],
//           });
//         }
//         dayVerified = dayVerified.add(const Duration(days: 1));
//       }
//       availability = accList;
//     }

//     bool resultCheck = availability.every(
//         (element) => (int.tryParse(element["balance"].toString()) ?? 0) > 0);
//     hotel["checkout"] = resultCheck;
//     if (!resultGeneral) {
//       resultGeneral = !resultCheck;
//     }
//   }
//   if (resultGeneral) {
//     await Get.dialog(
//       const NewAlert(
//         title: "Há serviços indisponiveisnna sacola",
//       ),
//       barrierColor: AppColors.black.withOpacity(0.5),
//     );
//   }
//   servicesCombos = [];
//   for (Map service in services) {
//     if ((service["combo"] ?? []).isNotEmpty) {
//       servicesCombos = [...servicesCombos, ...service["combo"]];
//     }
//   }

//   services = services.map((service) {
//     service.remove("combo");
//     return service;
//   }).toList();
//   order["services"] = [...services, ...servicesCombos];
//   order["hotels"] = hotels;
//   await boxSales.put("order", order);
//   BagController bagController = Get.find();
//   bagController.getOrderServices();
//   return resultGeneral;
// }

// Future<void> putSale({isBudget = false, Map more = const {}}) async {
//   if (await checkAvailability()) return;
//   SalesController salesController = Get.find();
//   AppRepository appRepository = AppRepository();
//   Box boxSales = Hive.box("sales");
//   Box boxDraft = Hive.box("draft");
//   Box boxData = Hive.box("data");

//   Map sale = boxSales.toMap();

//   Map order = sale["order"] ?? {};
//   double total = 0.0;
//   List services = order["services"] ?? [];
//   List team = order["team"] ?? [];
//   List additionals = order["additional"] ?? [];
//   List tenancy = order["vehicle"] ?? [];
//   List hotels = order["hotels"] ?? [];
//   List flights = order["flights"] ?? [];
//   List payments = order["payments"] ?? [];

//   order["services"] = services;
//   order["team"] = team;
//   order["additional"] = additionals;
//   order["vehicle"] = tenancy;
//   order["hotels"] = hotels;
//   order["flights"] = flights;
//   order["payments"] = payments;

//   if (order["period"] == null) {
//     order["period"] = {"start": null, "end": null};
//   }

//   if (payments.isEmpty) {
//     await Get.dialog(
//       const NewAlert(
//         title: "É necessário um pagamento para continuar",
//       ),
//       barrierColor: AppColors.black.withOpacity(0.5),
//     );
//     return;
//   }

//   bool multipleZones = false;
//   Permissions permissions = AppConst.getPermissions();
//   multipleZones = permissions.multipleZones;

//   Set zones = {};
//   List servicesZones = [...hotels, ...services, ...tenancy, ...team]
//       .where((element) => (element["zones"] ?? "").toString().isNotEmpty)
//       .toList();
//   for (Map servi in servicesZones) {
//     zones = {...zones, ...(servi["zones"] ?? "").toString().split(",").toSet()};
//   }
//   zones.removeWhere(
//     (element) => element.toString().trim().isEmpty,
//   );
//   zones.remove("null");

//   if (zones.length > 1 && servicesZones.length > 1 && multipleZones) {
//     bool? resp = await Get.dialog(
//       const NewConfirmAlert(
//         title: "O serviços possuem multiplasnzonas, deseja continuar?",
//       ),
//       barrierColor: AppColors.black.withOpacity(0.5),
//     );
//     if (!(resp ?? false)) {
//       return;
//     }
//   } else if (zones.length > 1 && servicesZones.length > 1) {
//     await Get.dialog(
//       const NewAlert(
//         title: "O serviços possuem multiplasnzonas, não é possivel continuar",
//       ),
//       barrierColor: AppColors.black.withOpacity(0.5),
//     );
//     return;
//   }

//   Get.dialog(
//     Container(
//       color: AppColors.black.withOpacity(0.15),
//       child: const Center(
//         child: CircularProgressIndicator(color: AppColors.white),
//       ),
//     ),
//   );

//   Map paxTotal = {
//     "infant": 0,
//     "child": 0,
//     "adult": 0,
//     "senior": 0,
//   };

//   services.where((element) => element["parent"] == null).forEach((element) {
//     List paxList = element["pax"] ?? [];
//     for (var element in paxList) {
//       switch (element["ageGroupID"].toString()) {
//         case "1":
//           {
//             paxTotal["adult"] += element["total"];
//             continue;
//           }
//         case "2":
//           {
//             paxTotal["infant"] += element["total"];
//             continue;
//           }

//         case "3":
//           {
//             paxTotal["child"] += element["total"];
//             continue;
//           }

//         case "4":
//           {
//             paxTotal["senior"] += element["total"];
//             continue;
//           }
//         default:
//           continue;
//       }
//     }
//   });

//   for (var hotel in hotels) {
//     paxTotal["infant"] += hotel["totalPaxInfant"];
//     paxTotal["child"] += hotel["totalPaxChild"];
//     paxTotal["adult"] += hotel["totalPaxAdult"];
//   }

//   paxTotal["adult"] += flights.length;

//   order["paxTotal"] = paxTotal;

//   // try {
//   //   order["flights"] = flights.map((fli) {
//   //     fli["references"] = List.generate(
//   //         min((fli["voucher"] ?? []).length, (fli["assigned"] ?? []).length),
//   //         (index) {
//   //       return {
//   //         "voucher": (fli["voucher"] ?? [])[index],
//   //         "idPax": (fli["assigned"] ?? [])[index]
//   //       };
//   //     }).toList();

//   //     return fli;
//   //   }).toList();
//   // } catch (_) {}

//   order = {...order, ...more};

//   Map intermediary = order["intermediary"] ?? {};
//   Map event = order["event"] ?? {};
//   Map partner = order["partner"] ?? {};
//   order["commission"] = {"seller": [], "manager": [], "partner": []};

//   if (partner.isEmpty) {
//     order["partner"] = {"id": null};
//   }

//   if (intermediary.isEmpty) {
//     order["intermediary"] = {"id": null};
//   }
//   if (event.isEmpty) {
//     order["event"] = {"id": null};
//   }

//   List sellerComm = [];
//   List managerComm = [];
//   List partnerComm = [];
//   double totalCommission = 0.0;

//   for (var serv in [...services, ...tenancy, ...hotels, ...team]) {
//     if (serv["parent"] != null) continue;
//     totalCommission +=
//         (((serv["commission"] ?? {})["manager"] ?? {})["total"] ?? 0.0) +
//             (((serv["commission"] ?? {})["seller"] ?? {})["total"] ?? 0.0);
//     managerComm.add((serv["commission"] ?? {})["manager"] ?? {});
//     sellerComm.add((serv["commission"] ?? {})["seller"] ?? {});

//     Map servCom = serv["commission"] ?? {};
//     servCom["total"] =
//         (((serv["commission"] ?? {})["manager"] ?? {})["total"] ?? 0.0) +
//             (((serv["commission"] ?? {})["seller"] ?? {})["total"] ?? 0.0);

//     if (partner.isNotEmpty) {
//       double partnerCommission =
//           (double.tryParse("${serv["indicatorCommission"] ?? 0}") ?? 0);
//       double servCommission = 0.0;
//       if (partnerCommission > 0) {
//         servCommission = ((partnerCommission / 100.0) *
//                 (double.tryParse("${serv["total"] ?? 0}") ?? 0))
//             .toPrecision(2);
//       }

//       totalCommission += servCommission;

//       servCom = serv["commission"] ?? {};
//       servCom["partner"] = {
//         "id": partner["id"],
//         "serviceId": serv["id"],
//         "eventId": serv["eventId"],
//         "identifier": serv["identifier"],
//         "total": servCommission,
//       };

//       servCom["total"] =
//           (((serv["commission"] ?? {})["manager"] ?? {})["total"] ?? 0.0) +
//               (((serv["commission"] ?? {})["seller"] ?? {})["total"] ?? 0.0) +
//               servCommission;

//       serv["commission"] = servCom;

//       partnerComm.add({
//         "id": partner["id"],
//         "serviceId": serv["id"],
//         "eventId": serv["eventId"],
//         "identifier": serv["identifier"],
//         "total": servCommission,
//       });
//     }
//   }

//   order["commission"] = {
//     "seller": sellerComm
//         .where((com) => com["total"] > 0 || com["point"] > 0)
//         .toList(),
//     "manager": managerComm
//         .where((com) => com["total"] > 0 || com["point"] > 0)
//         .toList(),
//     "partner": partnerComm.where((com) => (com["total"] ?? 0) > 0).toList(),
//   };

//   order["costs"] = {
//     "services": order["services"] != null && order["services"].isNotEmpty
//         ? (order["services"] ?? []).map((e) => e["costTotal"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "partner": order["commission"] != null &&
//             order["commission"]["partner"] != null &&
//             order["commission"]["partner"].isNotEmpty
//         ? (order["commission"]["partner"] ?? [])
//             .map((e) => e["total"] ?? 0.0)
//             .reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "manager": order["commission"] != null &&
//             order["commission"]["manager"] != null &&
//             order["commission"]["manager"].isNotEmpty
//         ? (order["commission"]["manager"] ?? [])
//             .map((e) => e["total"] ?? 0.0)
//             .reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "seller": order["commission"] != null &&
//             order["commission"]["seller"] != null &&
//             order["commission"]["seller"].isNotEmpty
//         ? (order["commission"]["seller"] ?? [])
//             .map((e) => e["total"] ?? 0.0)
//             .reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "additional": order["additional"] != null && order["additional"].isNotEmpty
//         ? (order["additional"] ?? []).map((e) => e["cost"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "flight": order["flights"] != null && order["flights"].isNotEmpty
//         ? (order["flights"] ?? []).map((e) => e["cost"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "hotels": order["hotels"] != null && order["hotels"].isNotEmpty
//         ? (order["hotels"] ?? []).map((e) => e["costTotal"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "vehicle": order["vehicle"] != null && order["vehicle"].isNotEmpty
//         ? (order["vehicle"] ?? []).map((e) => e["costTotal"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "team": order["team"] != null && order["team"].isNotEmpty
//         ? (order["team"] ?? []).map((e) => e["costTotal"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "courtesy": ((order["extract"] ?? {})["courtesy"] ?? 0.0),
//     "commission": totalCommission,
//   };

//   total = services.isEmpty
//       ? 0.0
//       : services
//           .map((e) => e["parent"] == null
//               ? double.tryParse(e["total"].toString()) ?? 0.0
//               : 0.0)
//           .reduce(
//             (value, element) => value + element,
//           );

//   total += team.isEmpty
//       ? 0.0
//       : team.map((e) => e["total"] ?? 0.0).reduce(
//             (value, element) => value + element,
//           );

//   total += additionals.isEmpty
//       ? 0.0
//       : additionals.map((e) => e["total"] ?? 0.0).reduce(
//             (value, element) => value + element,
//           );

//   total += flights.isEmpty
//       ? 0.0
//       : flights.map((e) => e["total"] ?? 0.0).reduce(
//             (value, element) => value + element,
//           );

//   total += tenancy.isEmpty
//       ? 0.0
//       : tenancy.map((e) => e["total"] ?? 0.0).reduce(
//             (value, element) => value + element,
//           );

//   total += hotels.isEmpty
//       ? 0.0
//       : hotels.map((e) => e["total"] ?? 0.0).reduce(
//             (value, element) => value + element,
//           );

//   double pay = payments.isEmpty
//       ? 0.0
//       : payments.map((e) => e["total"] ?? 0.0).reduce(
//             (value, element) => value + element,
//           );

//   double balance =
//       (total - pay - ((order["extract"] ?? {})["courtesy"] ?? 0.0));

//   if (balance == 0.0) {
//     order["status"] = 2;
//   } else {
//     order["status"] = 1;
//   }

//   order["extract"] = {
//     ...order["extract"] ?? {},
//     "courtesy": ((order["extract"] ?? {})["courtesy"] ?? 0.0),
//     "services": order["services"] != null && order["services"].isNotEmpty
//         ? (order["services"] ?? [])
//             .map((e) => e["parent"] == null
//                 ? double.tryParse(e["total"].toString()) ?? 0.0
//                 : 0.0)
//             .reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "team": order["team"] != null && order["team"].isNotEmpty
//         ? (order["team"] ?? []).map((e) => e["total"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "additional": order["additional"] != null && order["additional"].isNotEmpty
//         ? (order["additional"] ?? []).map((e) => e["total"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "flight": order["flights"] != null && order["flights"].isNotEmpty
//         ? (order["flights"] ?? []).map((e) => e["total"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "hotels": order["hotels"] != null && order["hotels"].isNotEmpty
//         ? (order["hotels"] ?? []).map((e) => e["total"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "vehicle": order["vehicle"] != null && order["vehicle"].isNotEmpty
//         ? (order["vehicle"] ?? []).map((e) => e["total"] ?? 0.0).reduce(
//               (value, element) => value + element,
//             )
//         : 0.00,
//     "discount": [
//       ...services,
//       ...team,
//       ...additionals,
//       ...tenancy,
//       ...hotels,
//       ...flights
//     ].map((e) => e["discount"] ?? 0.0).reduce(
//           (value, element) => value + element,
//         ),
//     "addition": [
//       ...services,
//       ...team,
//       ...additionals,
//       ...tenancy,
//       ...hotels,
//       ...flights
//     ].map((e) => e["addition"] ?? 0.0).reduce(
//           (value, element) => value + element,
//         ),
//     "promotion": [
//       ...services,
//       ...team,
//       ...additionals,
//       ...tenancy,
//       ...hotels,
//       ...flights
//     ].map((e) => e["promotion"] ?? 0.0).reduce(
//           (value, element) => value + element,
//         ),
//     "cost": order["costs"] != null && order["costs"].isNotEmpty
//         ? order["costs"].values.toList().reduce(
//               (value, element) => value + element,
//             )
//         : 0.0,
//     "commission": totalCommission,
//     "paid": pay,
//     "balance": balance,
//     "total": total,
//   };

//   List pax = order["pax"] ?? [];
//   order["paxNames"] = pax.isNotEmpty
//       ? pax.map((e) => e["name"] ?? "").join(",").toString()
//       : "";

//   sale["order"] = order;
//   if (!isBudget) {
//     order["date"] =
//         DateFormat("yyyy-MM-dd", "pt_BR").add_Hm().format(DateTime.now());
//     sale["draft"] = sale["draft"];
//     sale["token"] = sale["token"] ?? generateToken();
//     sale["order"] = order;

//     log(jsonEncode(sale));
//     Map resultSale = await appRepository.putNewSale(sale: sale);

//     if (resultSale["errorCode"] != null && resultSale["errorCode"] == 0) {
//       sale["id"] = resultSale["id"] ?? sale["id"];
//       appRepository.goals();
//       await appRepository.saveOrder(
//           identifier: resultSale["identifier"],
//           version: sale["version"].toString(),
//           content: jsonEncode(sale).replaceAll(""", """));
//       Get.back();
//       Get.back();
//       Get.to(
//         () => SuccessPage(
//           draft: "",
//           title: "Parabéns",
//           msg: "A sua venda foi geradancom sucesso",
//           sale: {
//             ...resultSale,
//             "situationId": 1,
//             "situation": "Pendente",
//           },
//         ),
//         routeName: "/success",
//         opaque: false,
//         transition: Transition.noTransition,
//       );
//     } else {
//       String method = sale["draftId"] != null ? "update" : "insert";
//       sale["draft"] = sale["draft"] ?? generateIdentifier("DRF");
//       sale["token"] = sale["token"] ?? generateToken();

//       Map resultDraft = await appRepository.putDraft(sale: sale, type: method);
//       appRepository.getCrashOrder().then((List crashs) {
//         crashs.add({
//           "error": resultSale,
//           "json": sale,
//         });
//         appRepository.saveOrderCrash(
//           content: crashs,
//         );
//       });
//       Get.back();
//       Get.back();

//       await Get.dialog(
//         NewAlert(
//           title:
//               "${resultSale["errorMessage"] ?? "Houve um erro aonsincronizar a venda"}",
//         ),
//         barrierColor: AppColors.black.withOpacity(0.5),
//       );
//       Get.dialog(
//         Container(
//           color: AppColors.black.withOpacity(0.15),
//           child: const Center(
//             child: CircularProgressIndicator(color: AppColors.white),
//           ),
//         ),
//       );

//       if (resultDraft["errorCode"] != null && resultDraft["errorCode"] == 0) {
//         if (method == "insert") {
//           sale["draftId"] = resultDraft["id"] ?? sale["draftId"];
//         }
//         await appRepository.saveDraft(
//             identifier: sale["draft"],
//             content: jsonEncode(sale).replaceAll(""", """));
//         Get.back();
//         Get.to(
//           () => SuccessPage(
//             draft: sale["draft"],
//             sale: sale,
//             title: "Orçamento",
//             msg: "A sua venda foi armazenadannos seus orçamentos",
//           ),
//           routeName: "/success",
//           opaque: false,
//           transition: Transition.noTransition,
//         );
//       } else {
//         Get.back();
//         await Get.dialog(
//           NewAlert(
//             title:
//                 "${resultDraft["errorMessage"] ?? "Houve um erro aonsincronizar o orçamento"}",
//           ),
//           barrierColor: AppColors.black.withOpacity(0.5),
//         );
//       }
//     }
//   } else {
//     sale["order"] = order;
//     String method = sale["draftId"] != null ? "update" : "insert";
//     sale["draft"] = sale["draft"] ?? generateIdentifier("DRF");
//     sale["token"] = sale["token"] ?? generateToken();
//     Map resultDraft = await appRepository.putDraft(sale: sale, type: method);
//     if (resultDraft["errorCode"] != null && resultDraft["errorCode"] == 0) {
//       if (method == "insert") {
//         sale["draftId"] = resultDraft["id"] ?? sale["draftId"];
//       }
//       await appRepository.saveDraft(
//           identifier: sale["draft"],
//           content: jsonEncode(sale).replaceAll(""", """));
//       Get.back();
//       Get.back();
//       Get.to(
//         () => SuccessPage(
//           draft: sale["draft"],
//           sale: sale,
//           title: "Orçamento",
//           msg: "A sua venda foi armazenadannos seus orçamentos",
//         ),
//         routeName: "/success",
//         opaque: false,
//         transition: Transition.noTransition,
//       );
//     } else {
//       Get.back();
//       Get.back();
//       await Get.dialog(
//         NewAlert(
//           title:
//               "${resultDraft["errorMessage"] ?? "Houve um erro aonsincronizar o orçamento"}",
//         ),
//         barrierColor: AppColors.black.withOpacity(0.5),
//       );
//     }
//   }

//   await salesController.removeFilters();
//   await Get.delete<IntermediaryController>(force: true);
//   await Get.delete<EventController>(force: true);
//   await Get.delete<AccompanyController>(force: true);
//   await Get.delete<InformationController>(force: true);

//   await boxSales.clear();
//   BagController bagController = Get.find();
//   bagController.len = 0;
//   bagController.order = {};
//   bagController.services = [];
//   bagController.getOrderServices();
// }

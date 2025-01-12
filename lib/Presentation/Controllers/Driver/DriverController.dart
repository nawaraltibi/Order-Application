import 'dart:convert';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../App/Utils/ControllerHandling.dart';
import '../../../Data/Models/Driver.dart';
import '../../../Data/Models/location.dart';
import '../../../Data/Models/Meta.dart';
import '../../../Data/Models/Order.dart';
import '../../../Data/Models/ResponseBody.dart';
import '../../../Domain/Usecases/orders_usecases/DeliverAnOrderUseCase.dart';
import '../../../Domain/Usecases/orders_usecases/GetActiveOrderUseCase.dart';
import '../../../Domain/Usecases/orders_usecases/GetUnTakenOrdersUseCase.dart';
import '../../../Domain/Usecases/orders_usecases/TakeAnOrderUseCase.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../SharedPreferences/SharedPreferencesController.dart';

class DriverController extends GetxController {
  final GetActiveOrderUseCase getActiveOrderUseCase;
  final GetUnTakenOrdersUseCase getUnTakenOrdersUseCase;
  final TakeAnOrderUseCase takeAnOrderUseCase;
  final DeliverAnOrderUseCase deliverAnOrderUseCase;

  DriverController({
    required this.getActiveOrderUseCase,
    required this.getUnTakenOrdersUseCase,
    required this.takeAnOrderUseCase,
    required this.deliverAnOrderUseCase,
  });

  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;

  Rx<Driver> driver = Rx<Driver>(Driver.empty());
  RxList<Order> orders = <Order>[].obs;
  Rx<Order?> selectedOrder = Rx<Order?>(null);
  Rx<Meta?> meta = Rx<Meta?>(null);
  RxList<LatLng> routePoints = <LatLng>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadingMap['getActiveOrder'] = false.obs;
    loadingMap['getUnTakenOrders'] = false.obs;
    loadingMap['takeAnOrder'] = false.obs;
    loadingMap['deliverAnOrder'] = false.obs;
  }

  // Method to update location
  void updateLocation(double lat, double lon) {
    driver.value.setLocation(lat, lon, name: "Your current location");
  }

  Future<void> getActiveOrder() async {
    await controllerHandling(
      () async {
        final ResponseBody response = await getActiveOrderUseCase.call();
        if (response.data == null) {
          getUnTakenOrders();
          Get.toNamed("/DriverOrders");
        } else {
          selectedOrder.value = Order.fromJson(response.data);
          getDirections();
          Get.toNamed('DriverOrderTaken');
          selectedOrder.refresh();
        }
      },
      loadingMap,
      'getActiveOrder',
      errorMap,
      'getActiveOrder',
    );
  }

  Future<void> getUnTakenOrders({
    int page = 1,
  }) async {
    await controllerHandling(
      () async {
        final ResponseBody response =
        await getUnTakenOrdersUseCase.call(page: page);
        if (page == 1) {
          orders.value = Order.fromListJson(response.data);
        } else {
          orders.addAll(Order.fromListJson(response.data));
        }
        meta.value = response.meta;
        orders.refresh();
      },
      loadingMap,
      'getUnTakenOrders',
      errorMap,
      'getUnTakenOrders',
    );
  }

  bool getNextSearchPage() {
    if (meta.value != null && meta.value!.currentPage < meta.value!.lastPage) {
      getUnTakenOrders(page: meta.value!.currentPage + 1);
      return true;
    }
    return false;
  }

  Future<void> takeAnOrder(Order order) async {
    await controllerHandling(
      () async {
        final ResponseBody response =
            await takeAnOrderUseCase.call(id: order.id!);
        Get.snackbar('Success', response.message!);
        selectedOrder.value = order;
        getDirections();
        Get.offAllNamed('DriverOrderTaken');
        selectedOrder.refresh();
      },
      loadingMap,
      'takeAnOrder',
      errorMap,
      'takeAnOrder',
    );
  }

  Future<void> deliverAnOrder() async {
    await controllerHandling(
      () async {
        final ResponseBody response =
            await deliverAnOrderUseCase.call(id: selectedOrder.value!.id!);
        Get.snackbar('Success', response.message!);
        getUnTakenOrders();
        Get.offAllNamed("/DriverOrders")?.then((_) {
          Future.delayed(const Duration(milliseconds: 300), () {
            selectedOrder.value = null;
            selectedOrder.refresh();
          });
        });
        },
      loadingMap,
      'deliverAnOrder',
      errorMap,
      'deliverAnOrder',
    );
  }

  List<LatLng> decodePolyline() {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(selectedOrder.value!.geometry!);

    return result.map((point) => LatLng(point.latitude, point.longitude)).toList();
  }

  Future<void> getDirections() async {
    List<String> locations = [
      "${driver.value.location!.latitude},${driver.value.location!.longitude}",
    ];

    if (selectedOrder.value!.markets!.isNotEmpty) {
      for (var market in selectedOrder.value!.markets!) {
        locations
            .add("${market.address!.latitude},${market.address!.longitude}");
      }
    }

    if (selectedOrder.value?.location != null) {
      locations.add(
          "${selectedOrder.value!.location!.latitude},${selectedOrder.value!.location!.longitude}");
    }

    String url =
        "http://router.project-osrm.org/trip/v1/driving/${locations.join(";")}?source=first&destination=last";

    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      selectedOrder.value!.geometry = data['trips'][0]['geometry'];

      final waypoints = data['waypoints'];

      selectedOrder.value!.markets!.sort((a, b) {
        int indexA = findWaypointIndex(a.address!, waypoints);
        int indexB = findWaypointIndex(b.address!, waypoints);

        return indexA.compareTo(indexB);
      });

      for(int i =0 ; i< selectedOrder.value!.markets!.length ;i++) {
        print(selectedOrder.value!.markets![i].name);
      }

      Get.snackbar("Sorted Markets",
          "Markets have been sorted based on the shortest route.");

      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> result = polylinePoints.decodePolyline(data['trips'][0]['geometry']);

      routePoints.value = result.map((point) => LatLng(point.latitude, point.longitude)).toList();

      routePoints.refresh();

    } else {
      throw Exception("Failed to load directions");
    }

    try {} catch (e) {
      Get.snackbar("Error", "An error occurred while fetching directions");
    }
  }

  int findWaypointIndex(Location location, List waypoints) {
    for (int i = 0; i < waypoints.length; i++) {
      var waypoint = waypoints[i];
      double lat = waypoint['location'][1];
      double lon = waypoint['location'][0];

      if (location.latitude == lat && location.longitude == lon) {
        return i;
      }
    }
    return -1;
  }

  void updateExpanded(Order order) {
    order.expanded = !order.expanded;
    orders.refresh();
  }

  Future<void> logoutDriver() async {
    await controllerHandling(
          () async {
        Get.find<SharedPreferencesController>().clearData();
        Get.offAllNamed("/EnterNumber");
      },
      loadingMap,
      'logout',
      errorMap,
      'logout',
    );
  }
}
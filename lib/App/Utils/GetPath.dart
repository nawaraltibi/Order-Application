
import 'package:get/get.dart';
import 'package:order_application/Data/Models/Market.dart';
import 'package:order_application/Data/Models/Product.dart';
import '../../Presentation/Controllers/User/UserController.dart';
import '../Const/Host.dart';

String getUserPath() {
  return 'http://$host/images/users/${Get.find<UserController>().user.value.imageName}';
}

String getProductPath(Product product) {
  return 'http://$host${product.image}';
}

String getMarketPath(Market market) {
  return'http://$host${market.logo}';
}


import 'package:get/get.dart';
import 'package:order_application/Data/Models/Market.dart';
import 'package:order_application/Data/Models/Product.dart';
import '../../Presentation/Controllers/User/UserController.dart';
import '../Const/Host.dart';

String getUserPath() {
  return 'http://$host2/images/users/${Get.find<UserController>().user.value.imageName}';
}

String getProductPath(Product product) {
  return 'http://$host2${product.image}';
}

String getMarketPath(Market market) {
  return'http://$host2${market.logo}';
}

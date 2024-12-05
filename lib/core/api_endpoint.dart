class ApiEndpoint {
  static const String baseUrl =
      'https://e-commerce-server-zc33.onrender.com/api';
  static String productUrl = '$baseUrl/products';
  static String categoriesUrl = '$baseUrl/categories';
  static String loginUrl = '$baseUrl/users/login';
  static String singUpUrl = '$baseUrl/users/register';
  static String cartUrl = '$baseUrl/cart';
  static String orderUrl = '$baseUrl/orders';
  static String productId(String id) {
    return '$productUrl/$id';
  }

  static String categoryId(String id) {
    return '$categoriesUrl/$id';
  }

  static String cartId(String id) {
    return '$cartUrl/$id';
  }
}

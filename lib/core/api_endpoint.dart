
class ApiEndpoint {
  static const String baseUrl =
      'https://e-commerce-server-zc33.onrender.com/api';
  static const String addProductUrl = '$baseUrl/products';
  static String updateProductUrl = '$addProductUrl/';
  static String deleteProductUrl = '$addProductUrl/';
  static String fetchProductUrl = '$addProductUrl/';
  static String fetchCategoriesUrl = '$baseUrl/categories';
  static String addCategoriesUrl = '$baseUrl/categories';
  static String updateCategoriesUrl = '$baseUrl/categories/';
  static String deleteCategoriesUrl = '$baseUrl/categories/';
  static String loginUrl = 'https://e-commerce-server-zc33.onrender.com/api/users/login';
  static String singUpUrl = 'https://e-commerce-server-zc33.onrender.com/api/users/register';
  static String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjZhOGRlOTkxYWQzZTM4YjM0Yjg2OTRjIiwidXNlcm5hbWUiOiJhYmMifSwiaWF0IjoxNzMyMDY3NDQ0LCJleHAiOjE3MzIwNzEwNDR9.tG3M1HWbyviL17_InvQYneYFeTnW8Wk6SN-bFRRrLeY';

}

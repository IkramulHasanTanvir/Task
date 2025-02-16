
class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  dynamic responseBody;
  String errorMassage;

  NetworkResponse(
      {required this.statusCode,
        required this.isSuccess,
        this.responseBody,
        this.errorMassage = 'something went wrong'});
}

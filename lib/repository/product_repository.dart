//==============================================================================
// api
//==============================================================================
class ProductRepository {
  Future<List<String>> loadDefaultProduct() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(10, (index) => 'default$index');
  }

  Future<List<String>?> loadPayProduct(bool hasLicense) async {
    // TODO: get license from server
    if (hasLicense) {
      await Future.delayed(const Duration(seconds: 1));
      return List.generate(10, (index) => 'pay$index');
    } else {
      // throw Exception('No license');
      return null;
    }
  }
}

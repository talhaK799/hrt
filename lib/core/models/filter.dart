class Filtering {
  int? maxAge;
  int? minAge;
  List<String>? desire;
  List<String>? lookingFor;
  // double? maxHeight;
  // double? minHeight;
  // List<String>? countries;

  Filtering({
    // this.countries,
    this.maxAge = 60,
    // this.maxHeight = 200,
    this.desire,
    this.lookingFor,
    this.minAge = 18,
    // this.minHeight = 1,
  });
}

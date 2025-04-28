import 'package:json_annotation/json_annotation.dart';
part 'search_response.g.dart';


@JsonSerializable()
class SearchResponse {
  @JsonKey(name: 'product_id')
  final int? productId;
  @JsonKey(name: 'product_name_en')
  final String? productNameEn;
  @JsonKey(name: 'product_name_ar')
  final String? productNameAr;
  @JsonKey(name: 'sell_price')
  final String? sellPrice;
  @JsonKey(name: 'product_image_url')
  final String? productImageUrl;

  SearchResponse({
    required this.productId,
    required this.productNameEn,
    required this.productNameAr,
    required this.sellPrice,
    this.productImageUrl,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
  // Factory method to deserialize a list of SearchResponse objects
  static List<SearchResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SearchResponse.fromJson(json)).toList();
  }
}

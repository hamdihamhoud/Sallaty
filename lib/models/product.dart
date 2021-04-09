class Product {
  final String id;
  final String ownerId;
  final String title;
  final int price;
  final int quantity;
  final List<String> imageUrls;
  final String category;
  final bool warranty;
  final int warrantyPeriod;
  final double rating;
  final bool isReplaceable;
  final int replacementPeriod;
  final bool isReturnable;
  final int returningPeriod;
  final String description;
  final Map<String, String> specs;
  final bool hasDiscount;
  final int discountPercentage;

  Product({
    this.id,
    this.ownerId,
    this.title,
    this.price,
    this.quantity,
    this.imageUrls,
    this.category,
    this.description,
    this.specs,
    this.warranty = false,
    this.warrantyPeriod = 0,
    this.rating = 0,
    this.isReplaceable = false,
    this.replacementPeriod = 0,
    this.isReturnable = false,
    this.returningPeriod = 0,
    this.hasDiscount = false,
    this.discountPercentage = 0,
  });
}

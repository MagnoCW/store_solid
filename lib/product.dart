class Product {
  String name;
  double price;
  int availableAmount;
  int amountInCart;

  Product(
      {required this.name,
      required this.price,
      required this.availableAmount,
      this.amountInCart = 0});

  void addToCart() {
    amountInCart += 1;
    availableAmount -= 1;
  }

  void removeFromCart() {
    if (amountInCart >= 1) {
      amountInCart -= 1;
      availableAmount += 1;
    } else {
      print("Amount in cart is insufficient to remove.");
    }
  }
}

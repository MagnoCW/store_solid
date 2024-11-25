abstract class PaymentProcessor {
  void processPayment(double amount);
}

class CreditCardPaymentProcessor extends PaymentProcessor {
  @override
  void processPayment(double amount) {
    print("Processing credit card payment of \$$amount");
  }
}

class PayPalPaymentProcessor extends PaymentProcessor {
  @override
  void processPayment(double amount) {
    print("Processing PayPal payment of \$$amount");
  }
}

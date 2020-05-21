class User {
  final String uid, username, number;

  User({
    this.uid,
    this.username,
    this.number,
  });
}

class Amount {
  final String amount;

  Amount({
    this.amount
    });
}

class TollPay {
  final String tollGate, tollAmount, plateNumber;

  TollPay({
    this.tollGate, 
    this.tollAmount, 
    this.plateNumber
    });
}

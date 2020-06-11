class AlertItem {
  var id;
  var userEmail;
  var status;
  var fullName;
  var phoneNumber;
  var address;
  var isGcash;
  var gcashReferenceNumber;
  var items;
  var message;  
  var deliveryFee;

  AlertItem({
    this.id,
    this.userEmail,
    this.status,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.isGcash,
    this.gcashReferenceNumber,
    this.items,
    this.message,
    this.deliveryFee,
  });

  factory AlertItem.fromJson(Map<String, dynamic> json) {
    return AlertItem(
      id: json['id'],
      userEmail: json['user_email'],
      status: json['status'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      isGcash: json['is_gcash'],
      gcashReferenceNumber: json['gcash_reference_number'],
      items: json['items'],
      message: json['message'],
      deliveryFee: json['delivery_fee'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_email': userEmail,
        'status': status,
        'full_name': fullName,
        'phone_number': phoneNumber,
        'address': address,
        'is_gcash': isGcash,
        'gcash_reference_number': gcashReferenceNumber,
        'items': items,
        'delivery_fee': deliveryFee,
      };
}

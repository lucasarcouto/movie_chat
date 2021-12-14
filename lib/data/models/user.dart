class User {
  String uuid;
  String name;

  User({this.uuid = "", this.name = ""});

  Map<String, dynamic> toData() => {
        'uuid': uuid,
        'name': name,
      };
}

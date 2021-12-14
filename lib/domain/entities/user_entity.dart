import '../../data/models/user.dart';

class UserEntity extends User {
  UserEntity({String uuid = "", String name = ""}) {
    this.uuid = uuid;
    this.name = name;
  }
}

extension UserParsing on UserEntity {
  UserEntity fromModel(User? model) => UserEntity(
        uuid: model != null ? model.uuid : "",
        name: model != null ? model.name : "",
      );

  UserEntity fromData(Map<dynamic, dynamic> data) => UserEntity(
        uuid: data['uuid'],
        name: data['name'],
      );
}

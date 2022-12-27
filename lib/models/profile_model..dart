class ProfileModel {
  int? idProfile;
  String? image;
  String? name;
  String? mail;
  String? number;
  String? github;

  ProfileModel({this.idProfile, this.image, this.name, this.mail, this.number, this.github});
  factory ProfileModel.fromJSON(Map<String, dynamic> mapProfile){
    return ProfileModel(
      idProfile: mapProfile['idProfile'],
      image: mapProfile['image'],
      name: mapProfile['name'],
      mail: mapProfile['mail'],
      number: mapProfile['number'],
      github: mapProfile['github']
    );
  }
}
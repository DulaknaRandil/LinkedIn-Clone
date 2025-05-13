class UserModel {
  final String email;
  final String password;
  final String name;
  final String headline;
  final String company;
  final String location;
  final String profileImage;
  final String bannerImage;
  final int connections;
  final int followers;
  final List<String> talkingAbout;
  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.headline,
    this.company = "Gooogle",
    this.location = "Bengaluru, Karnataka, India",
    required this.profileImage,
    this.bannerImage = "",
    this.connections = 0,
    this.followers = 0,
    this.talkingAbout = const ["flutter", "dart", "mobileappdevelopment"],
  });

  // Factory method to create a LinkedIn-style profile
  factory UserModel.linkedInProfile() {
    return UserModel(
      email: "stebin.alex@example.com",
      password: "password123",
      name: "Stebin Alex",
      headline: "Freelance iOS Developer | UIKit | SwiftUI",
      company: "LEAN TRANSITION SOLUTIONS - LTS",
      location: "Thiruvananthapuram, Kerala, India",
      profileImage:
          "https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?s=612x612&w=0&k=20&c=uP9rKidKETywVil0dbvg_vAKyv2wjXMwWJDNPHzc_Ug=",
      bannerImage:
          "https://img.freepik.com/free-photo/abstract-blur-bokeh-background_1150-6153.jpg",
      connections: 500,
      followers: 4413,
      talkingAbout: ["swift", "swiftui", "iosdevelopment"],
    );
  }
}

// This is the API service class for handling network requests
// In a real application, this would handle actual API calls
// Currently using mock data for the assignment

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  // Mock method to fetch user data
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return mock user data
    return {
      'id': userId,
      'name': 'John Doe',
      'email': 'john@example.com',
      'photo': 'https://randomuser.me/api/portraits/men/32.jpg',
      'title': 'Software Developer',
      'company': 'Tech Solutions Ltd.',
    };
  }

  // Mock method to fetch posts
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    // Return mock posts
    return [
      {
        'id': '1',
        'author_name': 'Tony Antonio',
        'author_title': 'Android Dev at Niko',
        'author_image': 'https://randomuser.me/api/portraits/men/32.jpg',
        'content':
            'Creating opportunity for every member of the global workforce drives everything we do at LinkedIn...',
        'post_image':
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2ViJTIwZGV2ZWxvcG1lbnR8ZW58MHx8MHx8fDA%3D',
        'likes': 97,
        'comments': 77,
        'edited': true,
        'time': '2nd',
        'liked_by': 'Budi',
        'others_liked': 97,
      },
      {
        'id': '2',
        'author_name': 'Andy Ortega',
        'author_title': 'Web Dev at Google',
        'author_image': 'https://randomuser.me/api/portraits/men/33.jpg',
        'content':
            'Just launched my new portfolio website! Check it out and let me know what you think.',
        'post_image':
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2ViJTIwZGV2ZWxvcG1lbnR8ZW58MHx8MHx8fDA%3D',
        'likes': 42,
        'comments': 15,
        'edited': false,
        'time': '3d',
        'liked_by': null,
        'others_liked': 0,
      }
    ];
  }
}

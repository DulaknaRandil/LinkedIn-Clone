import '../models/post_model.dart';
import '../services/api_service.dart';
import '../services/service_locator.dart';
import '../services/analytics_service.dart';

class PostRepository {
  final _apiService = locator<ApiService>();
  final _analyticsService = locator<AnalyticsService>();

  Future<List<PostModel>> getPosts() async {
    // Track the event
    _analyticsService.trackEvent('fetch_posts');

    // Get posts from API service
    final posts = await _apiService.fetchPosts();

    // Convert to model objects using factory constructor
    return posts.map((post) => PostModel.fromApiData(post)).toList();
  }
}

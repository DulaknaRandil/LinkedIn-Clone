class PostModel {
  final String authorName;
  final String authorTitle;
  final String authorImage;
  final String content;
  final String postImage;
  final String? id;
  final int? likes;
  final int? comments;
  final bool? isEdited;
  final String? timePosted;
  final String? likedBy;
  final int? othersLiked;

  PostModel({
    required this.authorName,
    required this.authorTitle,
    required this.authorImage,
    required this.content,
    required this.postImage,
    this.id,
    this.likes,
    this.comments,
    this.isEdited,
    this.timePosted,
    this.likedBy,
    this.othersLiked,
  });

  // Create a factory constructor to convert from API
  factory PostModel.fromApiData(Map<String, dynamic> data) {
    return PostModel(
      id: data['id'] as String?,
      authorName: data['author_name'] as String,
      authorTitle: data['author_title'] as String,
      authorImage: data['author_image'] as String,
      content: data['content'] as String,
      postImage: data['post_image'] as String,
      likes: data['likes'] as int?,
      comments: data['comments'] as int?,
      isEdited: data['edited'] as bool?,
      timePosted: data['time'] as String?,
      likedBy: data['liked_by'] as String?,
      othersLiked: data['others_liked'] as int?,
    );
  }
}

class PostPreview {
  // id: string(autogenerated)
  // text: string(length: 6-50, preview only)
  // image: string(url)
  // likes: number(init value: 0)
  // tags: array(string)
  // publishDate: string(autogenerated)
  // owner: object(User Preview)
  // final String owner;

  final String id;
  final String text;
  final String image;
  final int likes;
  final List<String> tags;
  final String publishDate;

  PostPreview({
    required this.id,
    required this.text,
    required this.image,
    required this.likes,
    required this.tags,
    required this.publishDate,
  });
}
class Category{
  static String sportsId = "sports";
  static String musicId = "music";
  static String moviesId = "movies";
  String id;
  late String name;
  late String image;
  Category({required this.id,required this.name,required this.image});
  Category.id(this.id){
    this.name = id;
    this.image = "assets/images/$id.png";
  }
  static List<Category>getCategories(){
    return [
      Category.id(sportsId),
      Category.id(musicId),
      Category.id(moviesId),

    ];
  }
}
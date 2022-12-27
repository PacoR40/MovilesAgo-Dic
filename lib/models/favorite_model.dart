class FavoriteDAO{
  int? id_movie, id;
  String? posterPath;
  String? backdropPath;
  String? title;
  double? voteAverage;
  String? overview;

  FavoriteDAO({
    this.id_movie,
    this.id,
    this.posterPath,
    this.backdropPath,
    this.title,
    this.voteAverage,
    this.overview
  });

  factory FavoriteDAO.fromJSON(Map<String, dynamic> map){
    return FavoriteDAO(
      id: map['id'],
      id_movie: map['id_movie'],
      posterPath: map['posterPath'],
      backdropPath: map['backdropPath'],
      title: map['title'],
      voteAverage: map['voteAverage'],
      overview: map['overview'],
    );
  }

  // Map<String, dynamic> toJSON(){
  //   return{
  //     "id": id,
  //     "id_movie": id_movie,
  //     "posterPath": posterPath,
  //     "backdropPath": backdropPath,
  //     "title": title,
  //     "voteAverage": voteAverage,
  //     "overview": overview,
  //   };
  // }

  
}
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

final testMovie = Movie(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  voteAverage: 7.2,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
);

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testTvCache = MovieTable(
  id: 67419,
  overview:
  "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
  posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
  title: "Victoria",
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testTvCacheMap = {
  'id': 67419,
  'overview':
  'The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.',
  'posterPath': '/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg',
  'title': 'Victoria',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testTvFromCache = Movie.watchlist(
  id: 67419,
  overview:
  'The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.',
  posterPath: '/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg',
  title: 'Victoria',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

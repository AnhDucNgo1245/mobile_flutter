import 'package:flutter/material.dart';

// Model
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// Sample Data
const List<Movie> allMovies = [
  Movie(
    title: 'The Matrix',
    year: 1999,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://via.placeholder.com/150/000000/FFFFFF/?text=The+Matrix',
    rating: 8.7,
  ),
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    posterUrl: 'https://via.placeholder.com/150/000000/FFFFFF/?text=Inception',
    rating: 8.8,
  ),
  Movie(
    title: 'The Godfather',
    year: 1972,
    genres: ['Crime', 'Drama'],
    posterUrl: 'https://via.placeholder.com/150/000000/FFFFFF/?text=The+Godfather',
    rating: 9.2,
  ),
  Movie(
    title: 'Pulp Fiction',
    year: 1994,
    genres: ['Crime', 'Drama'],
    posterUrl: 'https://via.placeholder.com/150/000000/FFFFFF/?text=Pulp+Fiction',
    rating: 8.9,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl: 'https://via.placeholder.com/150/000000/FFFFFF/?text=The+Dark+Knight',
    rating: 9.0,
  ),
  Movie(
    title: 'Forrest Gump',
    year: 1994,
    genres: ['Drama', 'Romance'],
    posterUrl: 'https://via.placeholder.com/150/000000/FFFFFF/?text=Forrest+Gump',
    rating: 8.8,
  ),
];

const List<String> allGenres = ['Action', 'Sci-Fi', 'Thriller', 'Crime', 'Drama', 'Romance', 'Comedy'];

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = 'A-Z';

  final List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  @override
  Widget build(BuildContext context) {
    // Filter
    List<Movie> visibleMovies = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenres = selectedGenres.isEmpty || movie.genres.any((g) => selectedGenres.contains(g));
      return matchesSearch && matchesGenres;
    }).toList();

    // Sort
    visibleMovies.sort((a, b) {
      switch (selectedSort) {
        case 'A-Z':
          return a.title.compareTo(b.title);
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return b.year.compareTo(a.year); // Newest first
        case 'Rating':
          return b.rating.compareTo(a.rating); // Highest first
        default:
          return 0;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Movie'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              
              // Genres and Sort Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: allGenres.map((genre) {
                        final isSelected = selectedGenres.contains(genre);
                        return FilterChip(
                          label: Text(genre),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedGenres.add(genre);
                              } else {
                                selectedGenres.remove(genre);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: selectedSort,
                    items: sortOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSort = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              
              if (selectedGenres.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Badge(
                        label: Text('${selectedGenres.length}'),
                        child: const Text('Genres Selected'),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedGenres.clear();
                          });
                        },
                        child: const Text('Clear Filters'),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              
              // Movie List Area
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 800) {
                      // Phone Layout
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return _buildMovieCard(visibleMovies[index]);
                        },
                      );
                    } else {
                      // Tablet/Web Layout
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 3, // adjust based on design
                        ),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return _buildMovieCard(visibleMovies[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 300;
          return Row(
            children: [
              Image.network(
                movie.posterUrl,
                width: isWide ? 100 : 80,
                height: isWide ? 150 : 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(width: 100, height: 150, color: Colors.grey),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${movie.year} • ${movie.genres.join(', ')}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${movie.rating}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

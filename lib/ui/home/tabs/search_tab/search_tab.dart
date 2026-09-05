import 'package:flutter/material.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/model/movies.dart';
import 'package:movie_app/utils/app_text_styles.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/custom_text_field.dart';
import '../home_tab/movie_details/movie_details_widget.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Movies> _movies = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDefaultMovies();
  }

  void _loadDefaultMovies() async {
    setState(() {
      _isLoading = true;
    });
    var response = await ApiManager.getMovies(queryTerm: 'Action');
    setState(() {
      _isLoading = false;
      if (response != null && response.data?.movies != null) {
        _movies = response.data!.movies!;
      }
    });
  }

  void _searchMovies(String query) async {
    if (query.isEmpty) {
      _loadDefaultMovies();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var response = await ApiManager.getMovies(queryTerm: query);

    setState(() {
      _isLoading = false;
      if (response != null && response.data?.movies != null) {
        _movies = response.data!.movies!;
      } else {
        _movies = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _searchController,
              onChanged: _searchMovies,
              textStyle: AppTextStyles.regular16White,
              hintText: AppLocalizations.of(context)!.search,
              fillColor: AppColors.grayColor,
              prefixIcon: Image.asset(AppAssets.iconSearch),
              borderColor: AppColors.transparent,
              hintStyle: AppTextStyles.regular16White,
            ),

            SizedBox(height: height * 0.02),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      itemCount: _movies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        var movie = _movies[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              movie.mediumCoverImage != null
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsWidget(
                                                  id: movie.id,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        movie.mediumCoverImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      color: AppColors.grayColor,
                                      child: const Icon(Icons.movie),
                                    ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.blackColor.withValues(
                                      alpha: 0.7,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        movie.rating?.toString() ?? '0.0',
                                        style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Image.asset(
                                        AppAssets.iconStar,
                                        height: height * .02,
                                        width: width * .03,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

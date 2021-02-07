import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/screens/home/components/movieContainer.dart';
import 'package:movie_app/ui/settings/theme/colorTheme.dart';
import 'package:movie_app/viewModels/movieViewModel.dart';
import 'package:sizer/sizer.dart';

class MovieDetailBody extends StatelessWidget {
  const MovieDetailBody({
    Key key,
    this.movie,
  }) : super(key: key);

  final MovieViewModel movie;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kContainerColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  MovieDetailPoster(movie: movie),
                  MovieDetailShortDescription(movie: movie),
                ],
              ),
            ),
            MovieSynopsis(movie: movie),
            SizedBox(height: 25),
            BuyNowButton(),
          ],
        ),
      ),
    );
  }
}

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          color: kYellow,
          onPressed: () {
            // movie Urls page
          },
          child: Text(
            'Buy Now',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MovieSynopsis extends StatelessWidget {
  const MovieSynopsis({
    Key key,
    this.movie,
  }) : super(key: key);

  final MovieViewModel movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Introduction',
            style: GoogleFonts.montserrat(
              color: Color(0xffC1C1C6),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            movie.description,
            style: GoogleFonts.montserrat(
              color: Color(0xffC1C1C6),
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }
}

class MovieDetailShortDescription extends StatelessWidget {
  const MovieDetailShortDescription({
    Key key,
    this.movie,
  }) : super(key: key);

  final MovieViewModel movie;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10.0.w,
      top: 20.0,
      child: Container(
        height: 30.0.h,
        width: 40.0.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _movieTitle(movie),
            SizedBox(height: 5),
            Row(
              children: [
                MovieShortDescription.movieQuality('3D', Colors.blue),
                SizedBox(width: 5),
                MovieShortDescription.movieQuality('IMAX', kYellow),
              ],
            ),
            SizedBox(height: 5),
            _movieType(text: 'Genre: Drama'),
            SizedBox(height: 5),
            _movieType(text: 'Runtime: 85min'),
            SizedBox(height: 5),
            starRating(movie),
          ],
        ),
      ),
    );
  }

  Flexible _movieTitle(MovieViewModel movie) {
    return Flexible(
      child: Text(
        movie.title,
        maxLines: 2,
        style: GoogleFonts.montserrat(
          color: Color(0xffC1C1C6),
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Row starRating(MovieViewModel movie) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: movie.rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: kYellow,
          ),
          itemCount: 5,
          itemSize: 20.0,
        ),
        SizedBox(width: 5),
        Text(
          movie.rating.toString(),
          style: GoogleFonts.montserrat(
            color: const Color(0xffFFBB3B),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Text _movieType({String text}) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        color: Color(0xff8D8E96),
        fontSize: 13,
      ),
    );
  }
}

class MovieDetailPoster extends StatelessWidget {
  const MovieDetailPoster({
    Key key,
    this.movie,
  }) : super(key: key);

  final MovieViewModel movie;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.0,
      top: -25.0,
      child: Hero(
        tag: 'poster${movie.id}',
        child: CachedNetworkImage(
          imageUrl: movie.poster,
          height: 27.0.h,
          width: 27.0.w,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              //backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
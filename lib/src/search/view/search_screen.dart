import 'package:eat/src/search/bloc/bloc.dart';
import 'package:eat/src/search/models/nearby_restaurant.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(
          SearchStarted(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.viewStatus == ViewStatus.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.viewStatus == ViewStatus.failure) {
          return const Center(child: Text('Search failed'));
        }
        if (state.searchResults.length == 0) {
          return const Center(child: Text('No restaurants found'));
        }
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              final NearbyRestaurant restaurant = state.searchResults[index];
              return Center(
                child: ListTile(
                  leading: Image.network(restaurant.icon),
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.vicinity),
                ),
              );
            });
      },
    );
  }
}

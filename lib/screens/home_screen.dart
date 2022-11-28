import 'package:flutter/material.dart';
import 'package:medicollap_assignment/providers/location_provider.dart';
import 'package:medicollap_assignment/widgets/country_card_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchQuery = TextEditingController();

  Map<dynamic, dynamic> searchMap = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: const [Icon(Icons.search)],
          ),
          // ? If isLoading then show loading Animation
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ElevatedButton(
                          onPressed: (() async {
                            provider.getCurrentLocation();
                          }),
                          child: const Text('Get Current Location'),
                        ),
                      ),
                      // ? Show Position when it is obtained
                      provider.isPositionSet
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                provider.position.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                              ),
                            )
                          : Container(),
                      // ? Show CountryCode when it is obtained
                      provider.isCountryCodeSet
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                provider.countryCode,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                              ),
                            )
                          : Container(),
                      // ? If the country list is present then only show search bar
                      provider.countryList.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery.text = value;
                                    searchMap =
                                        updateSearchMap(searchQuery.text);
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Search',
                                  suffixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                      // ? If No Matches found then display No Matches Found
                      // ? If search query is empty then show all countries in list
                      searchMap.isEmpty
                          ? provider.countryList.isEmpty
                              ? Container()
                              : searchMap.isEmpty && searchQuery.text.isNotEmpty
                                  ? Text('No Matches Found')
                                  : Expanded(
                                      child: CountriesListWidget(
                                      data: provider.countryList,
                                    ))
                          : CountriesListWidget(data: searchMap)
                    ],
                  ),
                ),
        );
      },
    );
  }

  Map<dynamic, dynamic> updateSearchMap(String query) {
    Map<dynamic, dynamic> searchMap = {};
    Map<dynamic, dynamic> countryList =
        Provider.of<LocationProvider>(context, listen: false).countryList;
    countryList.forEach((key, value) {
      if (key.toString().toLowerCase().contains(query.toLowerCase()) ||
          value.capital
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
        searchMap[key] = value;
      }
    });
    return searchMap;
  }
}

import 'package:flutter/material.dart';
import 'package:medicollap_assignment/providers/location_provider.dart';
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
                      provider.countryList.isEmpty
                          ? Container()
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery.text = value;
                                    searchMap = updateSearchMap(searchQuery.text) ;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Search',
                                  suffixIcon: Icon(Icons.search),
                                ),
                              ),
                          ),
                      searchMap.isEmpty
                          ? provider.countryList.isEmpty
                              ? Container()
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: Provider.of<LocationProvider>(context).countryList.length,
                                    itemBuilder: ((context, index) {
                                      String key = provider.countryList.keys
                                          .elementAt(index);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                    'Country Name: ${provider.countryList[key]!.countryName!}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                    'Capital: ${provider.countryList[key]!.capital!}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                    '1 USD to ${provider.countryList[key]!.currencyCode!} : ${provider.countryList[key]!.exchangeRate}'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                )
                          : Expanded(
                            child: ListView.builder(
                                itemCount: searchMap.length,
                                itemBuilder: ((context, index) {
                                  String key = searchMap.keys.elementAt(index);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                                'Country Name: ${searchMap[key]!.countryName!}'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                                'Capital: ${searchMap[key]!.capital!}'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                                '1 USD to ${searchMap[key]!.currencyCode!} : ${searchMap[key]!.exchangeRate}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                          ),
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
        Provider.of<LocationProvider>(context,listen: false).countryList;
    countryList.forEach((key, value) {
      if (key.toString().toLowerCase().contains(query.toLowerCase())|| value.capital.toString().toLowerCase().contains(query.toLowerCase())) {
        searchMap[key] = value;
      }
    });
    return searchMap;
  }
}

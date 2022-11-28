import 'package:flutter/material.dart';

class CountriesListWidget extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  const CountriesListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: ((context, index) {
          String key = data.keys.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Country Name: ${data[key]!.countryName!}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Capital: ${data[key]!.capital!}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                        '1 USD to ${data[key]!.currencyCode!} : ${data[key]!.exchangeRate}'),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

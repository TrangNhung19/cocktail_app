import 'package:flutter/material.dart';
import 'package:flutter_api_integration/controllers/cocktail_controller.dart';
import 'package:flutter_api_integration/model/cocktail_model.dart';
import 'package:flutter_api_integration/services/firebase_auth.dart';
import 'package:get/get.dart';
import 'details_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktail App'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: GetBuilder<CocktailController>(
          init: CocktailController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<CocktailModel>>(
                    future: controller.getCocktails(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 74, 12, 12),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.cocktails.length,
                            itemBuilder: (context, index) {
                              final cocktail =
                                  snapshot.data![index].drinks[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          image: cocktail.strDrinkThumb,
                                          name: cocktail.strDrink,
                                        ),
                                      ));
                                },
                                child: Card(
                                  elevation: 2,
                                  color: Color.fromARGB(255, 56, 17, 124),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          cocktail.strDrinkThumb,
                                          height: 110,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Id: ${cocktail.idDrink}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            cocktail.strDrink,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ],
            );
          }),
    );
  }
}

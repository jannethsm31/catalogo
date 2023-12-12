import 'package:catalogo_bratz/home_page.dart';
import 'package:catalogo_bratz/product_data.dart';
import 'package:catalogo_bratz/colors.dart';
import 'package:catalogo_bratz/custom_app_bar.dart';
import 'package:catalogo_bratz/product_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    List<ProductModel> filteredProducts = filtraProductos(query, productData);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const CustomAppBar(),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  fillColor: kLightGrayClr,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Buscar...',
                  suffixIcon: const Icon(
                    Icons.search,
                    color: kPrimaryClr,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    var product = filteredProducts[index];
                    return Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(color: kLightGrayClr),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.image,
                                height: 200,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    color: kSecondaryClr,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              product.description,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async{
                  var updatedProductos = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                  if (updatedProductos != null && updatedProductos is List<ProductModel>) {
                    setState(() {
                      filteredProducts = filtraProductos(query, updatedProductos);
                    });
                  }
                  },
                child: const Text('Insertar Nuevo Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ProductModel> filtraProductos(String query, List<dynamic> productos) {
    return productos
        .where((dynamic product) {
      if (product is ProductModel) {
        return product.name!.toLowerCase().contains(query.toLowerCase());
      }
      return false;
    })
        .map<ProductModel>((dynamic product) => product as ProductModel)
        .toList();
  }
}

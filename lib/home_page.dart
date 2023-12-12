import 'package:flutter/material.dart';
import 'package:catalogo_bratz/product_model.dart';
import 'package:catalogo_bratz/product_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController imageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<ProductModel> productos = List.empty(growable: true);


  int selectedIndex = -1;

  ProductModel? tempProduct; // Temporary product for preview

  @override
  void initState() {
    super.initState();
    // Asigna los productos del archivo product_data.dart a la lista productos
    productos = List.from(productData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Catalogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                hintText: 'Imagen',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              maxLength: 10,
              decoration: const InputDecoration(
                hintText: 'Descripcion',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String image = imageController.text.trim();
                    String name = nameController.text.trim();
                    String description = descriptionController.text.trim();
                    if (image.isNotEmpty && name.isNotEmpty && description.isNotEmpty) {
                      setState(() {
                        imageController.text = '';
                        nameController.text = '';
                        descriptionController.text = '';
                        ProductModel newProduct = ProductModel(
                          image: image,
                          name: name,
                          description: description,
                        );
                        productos.add(newProduct);
                        productData.add(newProduct);
                      });
                      Navigator.pop(context, productos);
                    }
                  },
                  child: const Text('Guardar'),
                ),
                ElevatedButton(
                    onPressed: () {
                      String image = imageController.text.trim();
                      String name = nameController.text.trim();
                      String description = descriptionController.text.trim();
                      if (image.isNotEmpty &&
                          name.isNotEmpty &&
                          description.isNotEmpty) {
                        setState(() {
                          imageController.text = '';
                          nameController.text = '';
                          descriptionController.text = '';
                          productos[selectedIndex].image = image;
                          productos[selectedIndex].name = name;
                          productos[selectedIndex].description = description;
                          selectedIndex = -1;
                        });
                      }
                    },
                    child: const Text('Actualizar')),

              ],
            ),
            const SizedBox(height: 10),
            productos.isEmpty
                ? const Text(
                    'Vacio',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: productos.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ], // Closing parenthesis for children
        ), // Closing parenthesis for Column
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            productos[index].image[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productos[index].image,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(productos[index].name),
            Text(productos[index].description)
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    imageController.text = productos[index].image;
                    nameController.text = productos[index].name;
                    descriptionController.text = productos[index].description;
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    setState(() {
                      productos.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}

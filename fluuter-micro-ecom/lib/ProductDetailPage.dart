import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProductDetail(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.isDetailLoading) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              title: Text('Loading...'),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (productProvider.productDetail == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              title: Text('Product Not Found'),
            ),
            body: Center(child: Text('Product detail not available')),
          );
        }

        final product = productProvider.productDetail!;
        final reviews = productProvider.reviews;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: Text(
              product['name'],
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'assets/product.jpg',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                Center(
                  child: Text(
                    product['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(58, 66, 86, 1.0),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),

                Center(
                  child: Text(
                    'Rp ${product['price']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                Text(
                  'Deskripsi Produk:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(58, 66, 86, 1.0),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  product['description'],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.0),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Add to Cart pressed!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 12.0),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),

                Text(
                  'Reviews:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(58, 66, 86, 1.0),
                  ),
                ),
                SizedBox(height: 8.0),
                ...reviews.map((review) => Container(
                      margin: EdgeInsets.only(bottom: 12.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['review']['comment'],
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Rating: ${review['review']['ratings']}/10',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

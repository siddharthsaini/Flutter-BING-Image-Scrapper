import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_scraper/web_scraper.dart';

void main() => runApp(WebScraperApp());

class WebScraperApp extends StatefulWidget {
  @override
  _WebScraperAppState createState() => _WebScraperAppState();
}

class _WebScraperAppState extends State<WebScraperApp> {
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://www.bing.com/images/search?&q=');

  // Response of getElement is always List<Map<String, dynamic>>
  List<Map<String, dynamic>> urls;

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage(
        'tokyo+ghoul+wallpaper&qft=+filterui:imagesize-custom_1080_1920&FORM=IRFLTR')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        urls = webScraper.getElement('div.imgpt > a.iusc', ['m']);
      });
    }
    for (var url in urls) {
      print(url);
    }
  }

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Product Catalog"),
        ),
        body: SafeArea(
          child: Center(
            child: RaisedButton(
              onPressed: () {
                fetchProducts();
              },
              child: Text("GET"),
            ),
          ),
          // child: urls == null
          //     ? Center(
          //         child:
          //             CircularProgressIndicator(), // Loads Circular Loading Animation
          //       )
          //     : ListView.builder(
          //         itemCount: urls.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           // Attributes are in the form of List<Map<String, dynamic>>.
          //           Map<String, dynamic> attributes = urls[index]['attributes'];
          //           return ExpansionTile(
          //             title: Text(attributes['cid']),
          //             children: <Widget>[
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: InkWell(
          //                   onTap: () {
          //                     // uses UI Launcher to launch in web browser & minor tweaks to generate url
          //                     launch(webScraper.baseUrl + attributes['murl']);
          //                   },
          //                   child: Text(
          //                     "View Image",
          //                     style: TextStyle(color: Colors.blue),
          //                   ),
          //                 ),
          //               )
          //             ],
          //           );
          //         },
          //       ),
        ),
      ),
    );
  }
}

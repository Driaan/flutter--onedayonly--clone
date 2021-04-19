// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_dashboard/provider.dart';
import 'package:personal_dashboard/smooth_scroll.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:emojis/emoji.dart'; // to use Emoji utilities

// import 'package:responsive_framework/responsive_framework.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: LiquorStoreApp(),
    ),
  );
}

class LiquorStoreApp extends StatelessWidget {
  const LiquorStoreApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: AppBarTheme().copyWith(
              elevation: 0,
              centerTitle: true,
              textTheme: GoogleFonts.montserratTextTheme(
                  ThemeData(brightness: Brightness.dark).textTheme),
              color: Color(0xFF272727)),
          textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(),
          scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme().copyWith(
            textTheme: GoogleFonts.montserratTextTheme(
                ThemeData(brightness: Brightness.dark).textTheme)),
        textTheme: GoogleFonts.montserratTextTheme(
                ThemeData(brightness: Brightness.dark).textTheme)
            .copyWith(),
      ),
      themeMode: ThemeMode.light,
      home: LiquoreStoreAppHomePage(),
    );
  }
}

enum ProductCategory { wine, whiskey, brandy, beer, misc }

class Product {
  Product(
      {this.name,
      this.description,
      this.priceCurrent,
      this.priceDiscounted,
      this.discountPercentage,
      this.category,
      this.link,
      this.icon,
      this.imageUrl});
  String name;
  String description;
  double priceCurrent;
  double priceDiscounted;
  double discountPercentage;
  ProductCategory category;
  String link;
  IconData icon;
  String imageUrl;
}

final products = [
  Product(
      category: ProductCategory.whiskey,
      icon: BrandIcons.jupyter,
      name: "Rowwebos House Rum",
      description: "A smooth backyard brew",
      priceCurrent: 160,
      priceDiscounted: 200,
      discountPercentage: 20,
      imageUrl: "https://i.ibb.co/N9zJcg1/2365x2365.jpg"),
  Product(
      category: ProductCategory.whiskey,
      icon: BrandIcons.jupyter,
      name: "Rowwebos House Vodka",
      description: "Pack of 2 Classic T-Shirts",
      priceCurrent: 199,
      priceDiscounted: 350,
      discountPercentage: 10,
      imageUrl: "https://i.ibb.co/F5Mrd6x/agegate-bottle-1.png"),
  Product(
      category: ProductCategory.whiskey,
      icon: null,
      name: "Speedo",
      description: "Men's Endurance 7cm Brief",
      priceCurrent: 149,
      priceDiscounted: 370,
      discountPercentage: 60,
      imageUrl:
          "https://cdni.onedayonly.co.za/catalog/product/160/614/1606140011.6621.jpeg?auto=compress&w=800&h=800&bg=fff&fit=fill"),
  Product(
      category: ProductCategory.whiskey,
      icon: null,
      name: "LG",
      description: "Artcool Heat & Cool Air Conditioner",
      priceCurrent: 13999,
      priceDiscounted: 19000,
      discountPercentage: 26,
      imageUrl:
          "https://cdni.onedayonly.co.za/catalog/product/160/250/1602509404.2554.jpeg?auto=compress&w=800&h=800&bg=fff&fit=fill"),
  Product(
      category: ProductCategory.whiskey,
      icon: null,
      name: "Serta",
      description: "Savona Bed Set",
      priceCurrent: 8999,
      priceDiscounted: 16200,
      discountPercentage: 44,
      imageUrl:
          "https://cdni.onedayonly.co.za/catalog/product/159/845/1598451351.5751.jpeg?auto=compress&w=800&h=800&bg=fff&fit=fill"),
  Product(
      category: ProductCategory.whiskey,
      icon: null,
      name: "Finish",
      description: "Pack of 3 Dishwashing Tablets (42's)",
      priceCurrent: 399,
      priceDiscounted: 570,
      discountPercentage: 30,
      imageUrl:
          "https://cdni.onedayonly.co.za/catalog/product/158/100/1581000585.1824.jpeg?auto=compress&w=800&h=800&bg=fff&fit=fill"),
  Product(
      category: ProductCategory.whiskey,
      icon: null,
      name: "Assist",
      description: "Cable Organising Box",
      priceCurrent: 169,
      priceDiscounted: 280,
      discountPercentage: 40,
      imageUrl:
          "https://cdni.onedayonly.co.za/catalog/product/161/105/1611054163.9995.jpeg?auto=compress&w=800&h=800&bg=fff&fit=fill"),
  Product(
      category: ProductCategory.whiskey,
      icon: BrandIcons.jupyter,
      name: "Rush",
      description: "Pack of 2 Classic T-Shirts",
      priceCurrent: 199,
      priceDiscounted: 350,
      discountPercentage: 43,
      imageUrl:
          "https://cdni.onedayonly.co.za/catalog/product/159/257/1592574962.9919.jpeg?auto=compress&w=800&h=800&bg=fff&fit=fill"),
];

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Container(
          padding: EdgeInsets.all(32),
          height: 320,
          width: double.infinity,
          color: Color(0xFF272727),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("About us",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("About ODO",
                          style: TextStyle(color: Color(0xFFeff1f3))),
                      Text("Sell with us"),
                      Text("Careers"),
                      Text("Take me to a random deal!")
                    ]),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("About us"),
                      Text("About us"),
                      Text("About us")
                    ]),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("About us"),
                      Text("About us"),
                      Text("About us")
                    ]),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("About us"),
                      Text("About us"),
                      Text("About us")
                    ]),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("About us"),
                      Text("About us"),
                      Text("About us")
                    ]),
              ],
            ),
            Divider(),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("asd")]),
            Divider(),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("Terms and Conditions | Privacy Policy")]),
          ]),
        ));
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({
    Key key,
  })  : preferredSize = Size.fromHeight(36.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
          height: 36,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFF27B26),
                  const Color(0xFFF26F29),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TODAY'S DEALS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.9),
                    )
                  ]))),
      actions: [
        UserPopupMenu(),
        Container(
            width: 48,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 0.0, right: 8.0, top: 6, bottom: 6),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF99ABB9),
                child: Icon(
                  Icons.shopping_cart,
                  size: 16,
                ),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ))
      ],
      automaticallyImplyLeading: true,
    );
  }
}

class CustomHeaderBar extends StatelessWidget {
  const CustomHeaderBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFf5af19),
                  // const Color(0xFF0078BB),
                  const Color(0xFFEF3B36),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          height: 72,
          width: double.infinity,
          child: Center(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                Text(
                  "Rooibos in die week.",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Rowwebos op die naweek.",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                )
              ])),
        ));
  }
}
// linear-gradient( to right,#0F9EE5,#0078BB,#014595 )

class CustomHeaderNotification extends StatelessWidget {
  const CustomHeaderNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      color: Color(0xFFE5F4FA),
      child: Center(
          child: Text(
        "Please note: Alcohol orders will only be delivered within 10 working days after the restrictions have been lifted.",
        style: TextStyle(fontSize: 13, color: Color(0xFF0F9EE5)),
      )),
    );
  }
}

class UserPopupMenu extends StatefulWidget {
  UserPopupMenu({Key key}) : super(key: key);

  @override
  _UserPopupMenuState createState() => _UserPopupMenuState();
}

class _UserPopupMenuState extends State<UserPopupMenu> {
  var _selection;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.all(0),
      tooltip: "Menu",
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(4.0),
      ),
      onSelected: (String value) {
        setState(() {
          _selection = value;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(left: 0.0, right: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            Text(
              'DRIAAN',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.9),
            ),
            Icon(Icons.arrow_drop_down_outlined),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Value1',
          child: Text('My Account'),
        ),
        const PopupMenuItem<String>(
          value: 'Value2',
          child: Text('My Orders'),
        ),
        const PopupMenuItem<String>(
          value: 'Value3',
          child: Text('Help Centre'),
        ),
        const PopupMenuItem<String>(
          value: 'Value4',
          child: Text('Log out'),
        ),
      ],
    );
  }
}

class LiquoreStoreAppHomePage extends StatelessWidget {
  const LiquoreStoreAppHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = new ScrollController();
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 150) / 3;
    final double itemWidth = size.width / 2;
    double aspectRation = (itemHeight / itemWidth);
    return Scaffold(
        appBar: CustomAppBar(),
        body: SmoothScrollWeb(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomHeaderBar(),
                MediaQuery.of(context).size.width > 800
                    ? CustomHeaderNotification()
                    : Container(),
                Expanded(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: 1200),
                        // padding: EdgeInsets.all(32),
                        child: CustomScrollView(
                          // physics: NeverScrollableScrollPhysics(),
                          controller: scrollController,
                          slivers: <Widget>[
                            SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (c, i) => ProductCard(
                                  product: products[i],
                                ),
                                childCount: products.length,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      // childAspectRatio:
                                      //     (itemWidth / itemHeight)
                                      // childAspectRatio: 0.8,
                                      // childAspectRatio: aspectRation,
                                      // childAspectRatio: (600 / 664),
                                      // childAspectRatio: MediaQuery.of(context)
                                      //             .size
                                      //             .width <
                                      //         1201
                                      //     ? MediaQuery.of(context).size.width /
                                      //         (MediaQuery.of(context)
                                      //                 .size
                                      //                 .height /
                                      //             1.4)
                                      //     : 0.8,
                                      childAspectRatio: 0.855,
                                      crossAxisCount:
                                          MediaQuery.of(context).size.width >
                                                  800
                                              ? 2
                                              : 1,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0),
                            ),
                            SliverToBoxAdapter(
                              child: CustomFooter(),
                            ),
                          ],
                        )))
                // Expanded(
                //     child: ListView.builder(
                //   itemCount: launcherApps.length,
                //   itemBuilder: (context, index) {
                //     return AppLauncherCard(
                //       launcherApp: launcherApps[index],
                //     );
                //   },
                // )),
                // CustomFooter()
              ],
            ))

        // Center(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const <Widget>[
        //       Text('You have pushed the button this many times:'),

        //       /// Extracted as a separate widget for performance optimization.
        //       /// As a separate widget, it will rebuild independently from [MyHomePage].
        //       ///
        //       /// This is totally optional (and rarely needed).
        //       /// Similarly, we could also use [Consumer] or [Selector].
        //       Count(),
        //     ],
        //   ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   key: const Key('increment_floatingActionButton'),

        //   /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        //   /// when [Counter] changes.
        //   onPressed: () => context.read<Counter>().increment(),
        //   tooltip: "asd",
        //   child: const Icon(Icons.add),
        // ),
        );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with TickerProviderStateMixin {
  bool _isHovering;
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      animationBehavior: AnimationBehavior.values[1],
      vsync: this,
    );
    _scaleAnimation = Tween(
      begin: 1.0,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.ease));
    _isHovering = false;
  }

  void _enter(PointerEvent details) {
    setState(() {
      _isHovering = true;
      _scaleController.forward();
    });
  }

  void _exit(PointerEvent details) {
    setState(() {
      _isHovering = false;
      _scaleController.reverse();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product.imageUrl != null) {
      return Container(
          // color: Colors.red,
          padding: EdgeInsets.all(32),
          child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: _enter,
              onExit: _exit,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                            child: Stack(children: [
                              Container(
                                  width: double.infinity,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: ScaleTransition(
                                          alignment: Alignment.center,
                                          scale: _scaleAnimation,
                                          child: Image(
                                            image: NetworkImage(
                                                widget.product.imageUrl),
                                            fit: BoxFit.fitHeight,
                                          )))),
                              Align(
                                alignment: Alignment.topRight,
                                child: HorizontalDiscountRibbon(
                                  discountPercentage:
                                      widget.product.discountPercentage,
                                ),
                              )
                            ]),
                            decoration: BoxDecoration(
                              boxShadow: [
                                // 0 5px 30px 0 rgba(58,63,71,0.1)
                                BoxShadow(
                                  color: Color(0xFF3A3F47).withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 30,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ))),
                    SizedBox(height: 16),
                    Text(widget.product.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF444444))),
                    SizedBox(width: 8),

                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF747e86),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'R${widget.product.priceCurrent}',
                          style: TextStyle(
                              fontSize: 31,
                              fontWeight: FontWeight.w600,
                              color: _isHovering
                                  ? Color(0xFFe50e62)
                                  : Color(0xFF444444)),
                        ),
                        if (widget.product.priceDiscounted != null)
                          SizedBox(width: 8),
                        if (widget.product.priceDiscounted != null)
                          Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text(
                                'R${widget.product.priceDiscounted}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF747e86),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )),
                      ],
                    )
                    // Text("asd")
                  ])));
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: _enter,
            onExit: _exit,
            child: DottedBorder(
                radius: Radius.circular(4),
                color: _isHovering
                    ? isLightTheme(context)
                        ? Color(0xff292A2D)
                        : Colors.white
                    : Colors.transparent,
                strokeWidth: 3,
                borderType: BorderType.RRect,
                dashPattern: [5, 2.5],
                padding: EdgeInsets.all(0),
                child: Neumorphic(
                    drawSurfaceAboveChild: false,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    style: NeumorphicStyle(
                        // shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(4)),
                        // depth: -4,
                        // lightSource: LightSource.topRight,
                        shadowLightColor:
                            isLightTheme(context) ? Colors.white : Colors.black,
                        intensity: 0.4,
                        color: isLightTheme(context)
                            ? Colors.white
                            : Colors.black),
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      if (widget.product.icon != null)
                        Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(widget.product.icon)),
                      Flexible(
                          child: Text(
                        widget.product.name,
                        overflow: TextOverflow.ellipsis,
                        // style: TextStyle(
                        //     fontWeight: _isHovering
                        //         ? FontWeight.bold
                        //         : FontWeight.normal),
                      ))
                    ])))));
  }
}

bool isLightTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light;
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

        /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
        '${context.watch<Counter>().count}',
        key: const Key('counterState'),
        style: Theme.of(context).textTheme.headline4);
  }
}

class VerticalDiscountRibbon extends StatelessWidget {
  final double discountPercentage;
  const VerticalDiscountRibbon({this.discountPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("SAVE",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.1)),
        Text("$discountPercentage%",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.1)),
        SizedBox(
          height: 4,
        )
      ]),
      decoration: BoxDecoration(
          color: Color(0xFFE50E62),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      margin: EdgeInsets.only(right: 24),
      padding: EdgeInsets.symmetric(vertical: 5.5, horizontal: 11),
    );
  }
}

class HorizontalDiscountRibbon extends StatelessWidget {
  final double discountPercentage;
  const HorizontalDiscountRibbon({this.discountPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("-$discountPercentage%",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.1)),
      decoration: BoxDecoration(
          color: Color(0xFFE50E62),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
      margin: EdgeInsets.only(top: 26),
      padding: EdgeInsets.symmetric(vertical: 5.5, horizontal: 11),
    );
  }
}

class VerticalFeaturesRibbon extends StatelessWidget {
  const VerticalFeaturesRibbon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("asd"),
    );
  }
}

class HorizontalFeaturesRibbon extends StatelessWidget {
  const HorizontalFeaturesRibbon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("asd"),
    );
  }
}

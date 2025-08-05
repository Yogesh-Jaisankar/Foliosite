import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Mobileview extends StatefulWidget {
  const Mobileview({super.key});

  @override
  State<Mobileview> createState() => _MobileviewState();
}

class _MobileviewState extends State<Mobileview> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<AnimationController> _controllers;
  late List<Animation<double>> _rotationAnimations;
  final List<bool> _isHovered = [false, false, false];

  final List<Map<String, String>> _socialItems = [
    {'asset': 'Asset/gitt.svg', 'url': 'https://github.com/Yogesh-Jaisankar'},
    {
      'asset': 'Asset/lcolor.svg',
      'url': 'https://www.linkedin.com/in/yogeshjaisankar/',
    },
    {'asset': 'Asset/icolor.svg', 'url': 'https://instagram.com/_yoshan._'},
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  // Function to open the drawer
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  // Function to close the drawer
  void closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _socialItems.length,
      (_) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _rotationAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: 3.14159,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87.withOpacity(.4),
        centerTitle: false,

        title: Text(
          "Clonemaster",
          style: GoogleFonts.lexendDeca(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Drawer(
          width: 90,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            side: BorderSide(
              color: Colors.white,
              width: 0.2,
              style:
                  BorderStyle.solid, // Explicitly set to ensure border is drawn
            ),
          ),
          // Other Drawer properties...
          backgroundColor: Colors.black87,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Home",
                  style: GoogleFonts.lexendDeca(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "About",
                  style: GoogleFonts.lexendDeca(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Project",
                  style: GoogleFonts.lexendDeca(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Contact",
                  style: GoogleFonts.lexendDeca(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: PageView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        children: [_buildPage1(context)],
      ),
    );
  }

  // Reusable footer widget
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.mail,
              color: Colors.white,
              size: 25,
              semanticLabel: 'Email',
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                "yogeshjaishankar@gmail.com", // Corrected typo
                style: GoogleFonts.lexendDeca(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 15),
            SvgPicture.asset(
              "Asset/lcolor.svg", // Corrected typo and path
              height: 25,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                "Yogesh Jaishankar",
                style: GoogleFonts.lexendDeca(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Page 1 content
  Widget _buildPage1(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("Asset/about.png", height: 350),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Hello! I am",
                        style: GoogleFonts.lexendDeca(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        "Yogesh Jaishankar",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendDeca(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'I specialize in app development, combining sleek UI/UX design with robust backend architecture to bring powerful ideas to life. From crafting intelligent tools like PixaPlus and Unhike, to shaping social experiences through dating and voice-recording apps, my work reflects a deep focus on user-centric technology and clean design.',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_socialItems.length, (index) {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) {
                              setState(() => _isHovered[index] = true);
                              _controllers[index].forward();
                            },
                            onExit: (_) {
                              setState(() => _isHovered[index] = false);
                              _controllers[index].reverse();
                            },
                            child: GestureDetector(
                              onTap: () =>
                                  _launchURL(_socialItems[index]['url']!),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: AnimatedBuilder(
                                  animation: _rotationAnimations[index],
                                  builder: (context, child) {
                                    return Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(
                                          _rotationAnimations[index].value,
                                        ),
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: SvgPicture.asset(
                                          _socialItems[index]['asset']!,
                                          semanticsLabel:
                                              'Social Icon ${index + 1}',
                                          placeholderBuilder: (context) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          children: [
                            Lottie.asset("Asset/white.json", height: 25),
                            Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.grey,
                              child: Text(
                                "Scroll",
                                style: GoogleFonts.lexendDeca(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

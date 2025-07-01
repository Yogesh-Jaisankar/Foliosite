import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final List<Map<String, String>> _socialItems = [
    {'asset': 'Asset/github.svg', 'url': 'https://github.com/yourusername'},
    {
      'asset': 'Asset/linkdin.svg',
      'url': 'https://linkedin.com/in/yourusername',
    },
    {'asset': 'Asset/insta.svg', 'url': 'https://instagram.com/yourusername'},
  ];

  late List<AnimationController> _controllers;
  late List<Animation<double>> _rotationAnimations;
  final List<bool> _isHovered = [false, false, false];

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
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: RawScrollbar(
          interactive: true,
          thumbColor: Colors.black87,
          thickness: 8.0, // Customize thickness
          radius: Radius.circular(4), // Rounded edges
          controller: _pageController,
          child: PageView(
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: [
              // First Section (Your Provided Code)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "Asset/codebox.svg",
                            height: 50,
                            width: 50,
                          ),
                          const Spacer(),
                          NavItem(
                            text: "Home",
                            onTap: () => _navigateToPage(0),
                          ),
                          NavItem(
                            text: "About",
                            onTap: () => _navigateToPage(1),
                          ),
                          NavItem(
                            text: "Projects",
                            onTap: () => _navigateToPage(2),
                          ),
                          NavItem(
                            text: "Contact",
                            onTap: () => _navigateToPage(1),
                          ),
                          NavItem(
                            text: "Resume",
                            onTap: () => _navigateToPage(1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset("Asset/1.png", fit: BoxFit.fitHeight),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey.shade500,
                                        period: const Duration(seconds: 5),
                                        child: Text(
                                          "Hello! I'm Yogesh Jaisankar",
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Image.asset(
                                        "Asset/wave.gif",
                                        height: 50,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'I specialize in app development, combining sleek UI/UX design with robust backend architecture to bring powerful ideas to life. From crafting intelligent tools like PixaPlus and Unhike, to shaping social experiences through dating and voice-recording apps, my work reflects a deep focus on user-centric technology and clean design.\n\nBeyond apps, I co-host the podcast Retail Rewired, where we explore the future of omni-channel retail alongside industry thought leaders. I’m currently diving deeper into AI-powered interfaces, Flutter development, and backend systems using Firebase and MongoDB, while actively exploring domains like IoT, NFC tech, and smart city solutions. Whether it’s a product that needs a fresh direction, a platform that needs engineering, or an idea that needs to be heard — I’m always up for a new challenge.',
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(_socialItems.length, (
                                      index,
                                    ) {
                                      return MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        onEnter: (_) {
                                          setState(
                                            () => _isHovered[index] = true,
                                          );
                                          _controllers[index].forward();
                                        },
                                        onExit: (_) {
                                          setState(
                                            () => _isHovered[index] = false,
                                          );
                                          _controllers[index].reverse();
                                        },
                                        child: GestureDetector(
                                          onTap: () => _launchURL(
                                            _socialItems[index]['url']!,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15.0,
                                            ),
                                            child: AnimatedBuilder(
                                              animation:
                                                  _rotationAnimations[index],
                                              builder: (context, child) {
                                                return Transform(
                                                  transform: Matrix4.identity()
                                                    ..setEntry(3, 2, 0.001)
                                                    ..rotateY(
                                                      _rotationAnimations[index]
                                                          .value,
                                                    ),
                                                  alignment: Alignment.center,
                                                  child: SvgPicture.asset(
                                                    _socialItems[index]['asset']!,
                                                    color: Colors.white,
                                                    height: 50,
                                                    width: 50,
                                                    semanticsLabel:
                                                        'Social Icon ${index + 1}',
                                                    placeholderBuilder:
                                                        (context) => const Icon(
                                                          Icons.error,
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
                                  const SizedBox(height: 20),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () => _launchURL(
                                        'https://your-resume-link',
                                      ),
                                      child: Semantics(
                                        button: true,
                                        label: 'Download CV',
                                        child: Container(
                                          height: 50,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.expand_circle_down,
                                                  color: Colors.black87
                                                      .withOpacity(0.8),
                                                ),
                                                const SizedBox(width: 15),
                                                Text(
                                                  "Download CV",
                                                  style: GoogleFonts.lexendDeca(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Second Section (Example Content)
              Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.white,
                                    highlightColor: Colors.grey.shade500,
                                    period: const Duration(seconds: 5),
                                    child: Text(
                                      "Education And Extracurricular",
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  _buildTimelineContainer(),
                                  const SizedBox(height: 50),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black87.withOpacity(
                                              0.4,
                                            ),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(
                                        8.0,
                                      ), // Add padding for better spacing
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: SvgPicture.asset(
                                              "Asset/kata.svg",
                                              fit: BoxFit
                                                  .contain, // Ensure proper scaling
                                              height:
                                                  150, // Relative size (adjust as needed)
                                            ),
                                          ),
                                          Expanded(
                                            child: SvgPicture.asset(
                                              "Asset/sakte.svg",
                                              fit: BoxFit.contain,
                                              height: 100,
                                            ),
                                          ),
                                          Expanded(
                                            child: SvgPicture.asset(
                                              "Asset/tennis.svg",
                                              fit: BoxFit.contain,
                                              height: 100,
                                            ),
                                          ),
                                          Expanded(
                                            child: SvgPicture.asset(
                                              "Asset/vol.svg",
                                              fit: BoxFit.contain,
                                              height: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Right Image
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                "Asset/edu.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Third Section (Example Content)
              Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Left SVG Image
                            Image.asset(
                              "Asset/pro.png", // Replace with your SVG asset path
                              height: 600,
                              width: 600,
                              alignment: Alignment
                                  .centerLeft, // Ensure alignment to the left
                            ),
                            // Right Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.white,
                                    highlightColor: Colors.grey.shade500,
                                    period: const Duration(seconds: 5),
                                    child: Text(
                                      "Projects",
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class NavItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const NavItem({super.key, required this.text, required this.onTap});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 2,
                width: _isHovered ? 20 : 0,
                color: Colors.white,
                margin: const EdgeInsets.only(top: 4.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDot(Color color) => Container(
  height: 13,
  width: 13,
  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
);

Widget _buildTimelineContainer() {
  // Timeline data
  const List<Map<String, String>> _timelineData = [
    {
      'year': '2019',
      'description':
          'Sri Vijay Vidyalaya Matric Higher Secondary School, Krishnagiri, Tamil Nadu, India',
    },
    {
      'year': '2021',
      'description':
          'Vailankanni Public School, Krishnagiri, Tamil Nadu, India',
    },
    {
      'year': '2026',
      'description':
          'Vellore Institute of Technology, Chennai, Tamil Nadu, India (2021–2026)',
    },
  ];
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white),
      color: Colors.white.withOpacity(0.09),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.8),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Colored Dots
        Row(
          children: [
            _buildDot(Colors.redAccent.shade400),
            const SizedBox(width: 10),
            _buildDot(Colors.amber.shade400),
            const SizedBox(width: 10),
            _buildDot(Colors.lightGreenAccent.shade400),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Lottie.asset("Asset/cert.json", height: 150, width: 150),
        ),
        const SizedBox(height: 20),
        // Timeline
        ..._timelineData.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: _buildTimelineRow(entry['year']!, entry['description']!),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDot(Color color) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

Widget _buildTimelineRow(String year, String description) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        year,
        style: GoogleFonts.lexendDeca(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: Text(
          description,
          style: GoogleFonts.lexendDeca(fontSize: 16, color: Colors.white),
        ),
      ),
    ],
  );
}

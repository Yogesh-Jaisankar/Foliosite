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
    {'asset': 'Asset/github.svg', 'url': 'https://github.com/Yogesh-Jaisankar'},
    {
      'asset': 'Asset/linkdin.svg',
      'url': 'https://www.linkedin.com/in/yogeshjaisankar/',
    },
    {'asset': 'Asset/insta.svg', 'url': 'https://instagram.com/_yoshan._'},
  ];

  late List<AnimationController> _controllers;
  late List<Animation<double>> _rotationAnimations;
  final List<bool> _isHovered = [false, false, false];
  bool _isVisible = false;

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
    // Add listener to PageController
    _pageController.addListener(() {
      setState(() {
        _isVisible = _pageController.page != null && _pageController.page! > 0;
      });
    });
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
      floatingActionButton: _isVisible
          ? FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () => _navigateToPage(0),
              child: Icon(Icons.arrow_upward),
              tooltip: 'Back to top',
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: RawScrollbar(
          interactive: true,
          thumbColor: Colors.black87,
          thickness: 8.0, // Customize thickness
          radius: Radius.circular(4), // Rounded edges
          controller: _pageController,
          child: PageView(
            // pageSnapping: false,
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
                            onTap: () => _navigateToPage(3),
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
                                          "Hello! I'm Yogesh Jaishankar",
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
                                      "About Me",
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
                                "Asset/about.png",
                                height: 600,
                                width: 600,
                                alignment: Alignment.centerRight,
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
                            Column(
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
                                SizedBox(height: 25),
                                Image.asset(
                                  "Asset/final.png", // Replace with your SVG asset path
                                  height: 600,
                                  width: 600,
                                  alignment: Alignment
                                      .centerLeft, // Ensure alignment to the left
                                ),
                              ],
                            ),
                            // Right Column
                            Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 1.5,
                                    ),
                                itemCount: projects.length,
                                itemBuilder: (context, index) {
                                  final project = projects[index];
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: ProjectCard(
                                      title: project["title"]!,
                                      description: project["description"]!,
                                      imagePath: project["imagePath"]!,
                                      githubUrl: project["githubUrl"]!,
                                      demoUrl: project["demoUrl"]!,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //FootSection
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("Asset/bye.png", height: 300),
                              const SizedBox(height: 40),
                              Text(
                                "Get in Touch",
                                style: GoogleFonts.lexendDeca(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Contact Me",
                                style: GoogleFonts.lexendDeca(
                                  color: Colors.black87,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 600,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.black87,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: Text(
                                        "Yogeshjaisnkar@gmail.com",
                                        style: GoogleFonts.lexendDeca(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    SvgPicture.asset(
                                      "Asset/linkdin.svg",
                                      height: 30,
                                      color: Colors.black, // Match theme
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: Text(
                                        "Yogesh Jaisankar",
                                        style: GoogleFonts.lexendDeca(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(15.0),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey.shade500,
                            period: const Duration(seconds: 5),
                            child: Text(
                              "© 2025 Yogesh Jaishankar. All Rights Reserved.",
                              style: GoogleFonts.lexendDeca(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: List.generate(_socialItems.length, (
                              index,
                            ) {
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
                                          child: SvgPicture.asset(
                                            _socialItems[index]['asset']!,
                                            color: Colors.white,
                                            height: 40,
                                            width: 40,
                                            placeholderBuilder: (context) =>
                                                const Icon(Icons.error),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
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

  final List<Map<String, String>> projects = const [
    {
      "title": "Wheel and Meal",
      "description":
          "A multifunctional mobile app enabling users to book bike rides and order groceries or food seamlessly.",
      "imagePath": "Asset/wm.png",
      "githubUrl": "https://github.com/Yogesh-Jaisankar/wheel_and_meal",
      "demoUrl": "https://github.com/Yogesh-Jaisankar/wheel_and_meal",
    },
    {
      "title": "CrediLend",
      "description":
          "An app that helps users borrow and lend money easily, with full KYC and credit profiling.",
      "imagePath": "Asset/cl.png",
      "githubUrl": "https://github.com/Yogesh-Jaisankar/credilend",
      "demoUrl": "https://credilend.com",
    },
    {
      "title": "Mystimatch",
      "description":
          "MystiMatch is a modern dating app that connects people through smart matching and real-time chemistry.",
      "imagePath": "Asset/mystimatch.png",
      "githubUrl": "https://github.com/Yogesh-Jaisankar/credilend",
      "demoUrl": "https://credilend.com",
    },
    {
      "title": "PixaplusX",
      "description":
          "PixaPlusX is a sleek wallpaper app offering high-quality, curated visuals to personalize your device effortlessly.",
      "imagePath": "Asset/pixaplus.png",
      "githubUrl": "https://github.com/Yogesh-Jaisankar/credilend",
      "demoUrl": "https://credilend.com",
    },
    // Add more projects as needed
  ];

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

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String githubUrl;
  final String demoUrl;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.githubUrl,
    required this.demoUrl,
  }) : super(key: key);

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.white, size: 80),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexendDeca(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.lexendDeca(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _launchURL(githubUrl),
                        child: SvgPicture.asset(
                          "Asset/github.svg",
                          height: 50,
                          width: 50,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(demoUrl),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Shimmer.fromColors(
                                baseColor: Colors.black87,
                                highlightColor: Colors.grey,
                                period: const Duration(seconds: 5),
                                child: Text(
                                  "Live Demo",
                                  style: GoogleFonts.lexendDeca(
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
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
        ],
      ),
    );
  }
}

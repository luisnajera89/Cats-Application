import 'package:camera/camera.dart';
import 'package:cat_aplication/helpers/database_helper.dart';
import 'package:cat_aplication/screens/contact.dart';
import 'package:cat_aplication/screens/details_page.dart';
import 'package:cat_aplication/screens/taken_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:cat_aplication/widgets/image_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

import '../models/cat_model.dart';

class HomePageWidget extends StatefulWidget {
  final CameraDescription firstCamera;

  const HomePageWidget({Key? key, required this.firstCamera}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Star Walk',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        const Text(
                          'From Our universe',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 30, 5),
                    child: FlutterFlowIconButton(
                      borderColor: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: 20,
                      borderWidth: 2,
                      buttonSize: 45,
                      fillColor: const Color(0x003F2D1C),
                      icon: const Icon(
                        Icons.search_outlined,
                        color: Color.fromARGB(135, 0, 0, 0),
                        size: 25,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ],
              ),

              Expanded(
                child: (FutureBuilder<List<Planet>>(
                    future: DatabaseHelper.instance.getPlanets(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Planet>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: const Text("Loading"),
                          ),
                        );
                      } else {
                        return snapshot.data!.isEmpty
                            ? Center(
                                child: Container(
                                    child: const Text("No galaxies found!")),
                              )
                            : ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: snapshot.data!.map((planet) {
                                  return Center(
                                      child: GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.all(15.0),
                                      child: Image_s(path: planet.Image),
                                      height: 480,
                                      width: 360,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        final route = MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsScreenWidget(
                                                  firstCamera:
                                                      widget.firstCamera,
                                                  Description:
                                                      planet.Description,
                                                  Image: planet.Image,
                                                  Name: planet.Name,
                                                  Size: planet.Size,
                                                  Type: planet.Type,
                                                ));
                                        Navigator.push(context, route);
                                      });
                                    },
                                  ));
                                }).toList());
                      }
                    })),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 30, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: '',
                      icon: Icon(
                        Icons.auto_awesome,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 25,
                      ),
                      options: FFButtonOptions(
                        width: 50,
                        height: 50,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 180, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()),
                          );
                        },
                        text: '',
                        icon: FaIcon(
                          FontAwesomeIcons.addressBook,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        options: FFButtonOptions(
                          height: 50,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        print('button_n_planet pressed ...');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TakenPictureScreen(
                                    camera: widget.firstCamera,
                                  )),
                        );
                      },
                      text: '',
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 11,
                      ),
                      options: FFButtonOptions(
                        width: 35,
                        height: 35,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //new
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_1.jpg',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Atreus',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_circle_3.png',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Orion',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_circle_2.png',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'VK-47 Flatline',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_circle_1.png',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Andromeda 01',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_4.jpg',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Nomde 89',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_1.jpg',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Celestia-I7',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_2.jpg',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Keptir 56',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/galaxy_3.jpg',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Hal0 U67',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

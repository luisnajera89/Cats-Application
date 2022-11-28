import 'package:camera/camera.dart';
import 'package:cat_aplication/helpers/database_helper.dart';
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(120, 10, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Cat Unite',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        const Text(
                          'An application for cats',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: (FutureBuilder<List<Cat>>(
                    future: DatabaseHelper.instance.getCats(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Cat>> snapshot) {
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
                                    child: const Text("No Cats found!")),
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
                                                  Name: planet.Name,
                                                  Image: planet.Image,
                                                  Race: planet.Race,
                                                  Food: planet.Food,
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
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 30, 10),
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 180, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: '',
                        icon: FaIcon(
                          FontAwesomeIcons.cat,
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
                          borderSide: BorderSide(
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
                        Icons.note_add_outlined,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 14,
                      ),
                      options: FFButtonOptions(
                        width: 38,
                        height: 38,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
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
    );
  }
}

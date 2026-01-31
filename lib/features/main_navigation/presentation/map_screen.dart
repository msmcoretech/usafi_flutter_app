import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  final LatLng _destination = const LatLng(26.9124, 75.7873);
  LatLng? _currentLocation;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  BitmapDescriptor? _sourceIcon;
  BitmapDescriptor? _sourceIconMain;

  @override
  void initState() {
    super.initState();
    _loadMarkerIcon();

  }

  Future<void> _loadMarkerIcon() async {
    _sourceIcon = await MarkerIconHelper.roundPinFromNetwork(
      'https://i.pravatar.cc/130',
    );
    _sourceIconMain = await MarkerIconHelper.roundPinFromNetwork(
      'https://i.pravatar.cc/170',
    );
    setState(() {
      _requestPermission();
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _getLocation();
    }
  }

  Future<void> _getLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentLocation = LatLng(position.latitude, position.longitude);

    _markers.clear();
    _polylines.clear();

    _markers.addAll([
      Marker(
        markerId: const MarkerId('source'),
        position: _currentLocation!,
        icon: _sourceIcon ?? BitmapDescriptor.defaultMarker,
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: _destination,
        icon: _sourceIconMain ?? BitmapDescriptor.defaultMarker,
      ),
    ]);

    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        color: AppColors.primary,
        width: 5,
        points: [_currentLocation!, _destination],
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: AppCircleButton(
            icon: back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          'New Accreditations to Work Futur...',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _destination,
              zoom: 13,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Column(
              children: [
                _locationCard(),
                const SizedBox(height: 12),
                _startButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationCard() {
    return Container(
      padding: const EdgeInsets.all(07),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.jobHeader,
            child: Image(image:AssetImage(marker),height: 15,),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.w600,color: AppColors.textSecondary),
                ),
                Text(
                  'Etihad Stadium, Manchester',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            // margin: EdgeInsets.only(left: 50),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary,width: 0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(image:AssetImage(distance),height: 13,),
                SizedBox(width: 05),
                const Text(
                  '3.5 km',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _startButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {},
      child: const Text(
        'Start Journey',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}



class MarkerIconHelper {
  static Future<BitmapDescriptor> roundPinFromNetwork(
      String imageUrl, {
        int size = 150,
        Color pinColor = AppColors.primary,
      }) async {
    final response = await http.get(Uri.parse(imageUrl));
    final Uint8List imageBytes = response.bodyBytes;

    final ui.Codec codec = await ui.instantiateImageCodec(
      imageBytes,
      targetWidth: size,
    );
    final ui.FrameInfo frame = await codec.getNextFrame();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final double radius = size / 2;
    final double pinHeight = size * 0.35;
    final Size canvasSize = Size(size.toDouble(), size + pinHeight);

    final paint = Paint()..isAntiAlias = true;

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paint..color = pinColor,
    );

    final clipPath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius - 6,
      ));

    canvas.save();
    canvas.clipPath(clipPath);
    canvas.drawImageRect(
      frame.image,
      Rect.fromLTWH(
        0,
        0,
        frame.image.width.toDouble(),
        frame.image.height.toDouble(),
      ),
      Rect.fromLTWH(
        0,
        0,
        size.toDouble(),
        size.toDouble(),
      ),
      Paint()..isAntiAlias = true,
    );
    canvas.restore();

    final pinPath = Path()
      ..moveTo(radius - 16, size.toDouble() - 10)
      ..quadraticBezierTo(
        radius,
        size.toDouble() + pinHeight,
        radius + 16,
        size.toDouble() - 10,
      )
      ..close();

    canvas.drawPath(
      pinPath,
      paint..color = pinColor,
    );

    final picture = recorder.endRecording();
    final ui.Image image =
    await picture.toImage(canvasSize.width.toInt(), canvasSize.height.toInt());

    final byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }
}


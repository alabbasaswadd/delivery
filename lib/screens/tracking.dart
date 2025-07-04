import 'package:delivery/models.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TrackingScreen extends StatefulWidget {
  final Order order;

  TrackingScreen({required this.order});

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _updateMarkersAndPolyline();
  }

  void _updateMarkersAndPolyline() {
    _markers.clear();
    _polylines.clear();

    // علامة المتجر
    _markers.add(
      Marker(
        markerId: MarkerId('store'),
        position: widget.order.storeLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: 'المتجر'),
      ),
    );

    // علامة موقع التوصيل
    _markers.add(
      Marker(
        markerId: MarkerId('delivery'),
        position: widget.order.deliveryLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'موقع التوصيل'),
      ),
    );

    // علامة السائق (إذا كانت متاحة)
    if (widget.order.currentDriverLocation != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('driver'),
          position: widget.order.currentDriverLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'السائق'),
        ),
      );
    }

    // خط السير (إذا كان متاحًا)
    if (widget.order.routePolyline != null && widget.order.routePolyline!.length > 1) {
      _polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          points: widget.order.routePolyline!,
          color: Colors.blue,
          width: 4,
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تتبع الطلب #${widget.order.id}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
                // تكبير الخريطة لتظهر جميع العلامات
                _fitToMarkers();
              },
              initialCameraPosition: CameraPosition(
                target: widget.order.storeLocation,
                zoom: 12,
              ),
              markers: _markers,
              polylines: _polylines,
            ),
          ),
          _buildTrackingInfo(),
        ],
      ),
    );
  }

  void _fitToMarkers() async {
    if (_markers.isEmpty) return;
    
    LatLngBounds bounds = _createBounds();
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
    mapController.animateCamera(cameraUpdate);
  }

  LatLngBounds _createBounds() {
    double minLat = widget.order.storeLocation.latitude;
    double maxLat = widget.order.storeLocation.latitude;
    double minLng = widget.order.storeLocation.longitude;
    double maxLng = widget.order.storeLocation.longitude;

    void updateBounds(LatLng point) {
      minLat = minLat < point.latitude ? minLat : point.latitude;
      maxLat = maxLat > point.latitude ? maxLat : point.latitude;
      minLng = minLng < point.longitude ? minLng : point.longitude;
      maxLng = maxLng > point.longitude ? maxLng : point.longitude;
    }

    updateBounds(widget.order.deliveryLocation);
    if (widget.order.currentDriverLocation != null) {
      updateBounds(widget.order.currentDriverLocation!);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  Widget _buildTrackingInfo() {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'حالة الطلب: ${widget.order.status}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('رقم الطلب: #${widget.order.id}'),
            Text('العميل: ${widget.order.customerName}'),
            Text('العنوان: ${widget.order.address}'),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: _getProgressValue(widget.order.status),
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 5),
            Text(_getStatusText(widget.order.status)),
          ],
        ),
      ),
    );
  }

  double _getProgressValue(String status) {
    switch (status) {
      case 'تم الاستلام':
        return 0.25;
      case 'قيد التحضير':
        return 0.4;
      case 'قيد التوصيل':
        return 0.75;
      case 'تم التوصيل':
        return 1.0;
      default:
        return 0.1;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'تم الاستلام':
        return 'تم استلام الطلب من المتجر';
      case 'قيد التحضير':
        return 'جاري تحضير الطلب';
      case 'قيد التوصيل':
        return 'الطلب في الطريق إليك';
      case 'تم التوصيل':
        return 'تم تسليم الطلب';
      default:
        return 'جاري معالجة الطلب';
    }
  }
}
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitalAdPage extends StatefulWidget {
  const InterstitalAdPage({super.key});

  @override
  State<InterstitalAdPage> createState() => _InterstitalAdPageState();
}

class _InterstitalAdPageState extends State<InterstitalAdPage> {
  @override
  void initState() {
    super.initState();
    initInterstitialAd();
  }

  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;

  initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;

          setState(() {
            isAdLoaded = true;
          });
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              setState(() {
                isAdLoaded = false;
              });
              print("Ad is Dismissed");
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdShowedFullScreenContent: (ad) {
              print('$ad onAdShowedFullScreenContent');
            },
          );
        },
        onAdFailedToLoad: (error) {
          interstitialAd.dispose();
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Interstitial Ad Page'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              if (isAdLoaded) {
                interstitialAd.show();
              }
            },
            child: const Text('Task Completed'),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
//import 'package:flutter_web3/flutter_web3.dart';
import 'package:flutter/services.dart';
import 'package:pixy_chain/blockchain_services.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'blockchain_service.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final BlockchainService _blockchainService = BlockchainService();
  final String walletAddress = "0x7d5c73C219387443aB297Ec7532e3214043A1df0";
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkWalletStatus();
  }

  void checkWalletStatus() async {
    setState(() {
      isConnected = _blockchainService.isConnected;
    });
  }

  void _copyAddress() {
    Clipboard.setData(ClipboardData(text: walletAddress));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Wallet address copied!")),
    );
  }

  void _openMetaMaskWebsite() async {
    const url = 'https://metamask.io/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not open MetaMask website.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Contribute to support", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - MetaMask Guide & Registration
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Text(
                      "How to Connect MetaMask",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                   const  SizedBox(height: 10),
                    const Text(
                      "1. Install MetaMask as a browser extension or mobile app.\n"
                      "2. Create an account and save your secret recovery phrase securely.\n"
                      "3. Click 'Connect Wallet' below to link your MetaMask account.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _openMetaMaskWebsite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child:const  Text(
                        "Register on MetaMask",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Image.network(
                      'https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/contibution.jpeg',
                
                      width: 350,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
           const   SizedBox(width: 20),

            // Right Column - Wallet Actions
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                   const  Text(
                      "Connect to MetaMask & Make Transactions",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  const   SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        await _blockchainService.connectWallet();
                        checkWalletStatus();
                        _openMetaMaskWebsite();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding:const  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        isConnected ? "Connected" : "Connect Wallet",
                        style:const  TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                walletAddress,
                                style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon:const  Icon(Icons.copy, color: Colors.deepPurple),
                              onPressed: _copyAddress,
                            )
                          ],
                        ),
                      ),
                    ),
                  const   SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        await _blockchainService.switchToSepolia();
                        _openMetaMaskWebsite();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding:const  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child:const  Text("Switch to Sepolia", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await _blockchainService.sendTransaction(0.01);
                        _openMetaMaskWebsite();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:const  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child:const  Text("Send 0.01 ETH", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

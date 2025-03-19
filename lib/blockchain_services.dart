import 'package:flutter_web3/flutter_web3.dart';
import 'dart:js' as js;

class BlockchainService {
  static const String contractAddress = "0xeec7320b6dff5a28c6e0529b45f8cc02eeeaec45"; // Your Contract
  static const String recipientAddress = "0x7d5c73C219387443aB297Ec7532e3214043A1df0"; // Your Wallet
  static const int chainId = 11155111; // Sepolia Testnet

  String currentAddress = "";
  bool isConnected = false;
  late Web3Provider? provider;

  /// Check if MetaMask is installed
  bool get isMetaMaskAvailable => ethereum != null;

  /// Connect to MetaMask and open the extension
  Future<void> connectWallet() async {
    if (!isMetaMaskAvailable) {
      print("❌ MetaMask is NOT installed.");
      return;
    }

    try {
      final accounts = await ethereum!.requestAccount();
      if (accounts.isNotEmpty) {
        currentAddress = accounts.first;
        isConnected = true;
        provider = Web3Provider(ethereum!);

        print("✅ Wallet Connected: $currentAddress");

        // 🔥 Open MetaMask extension UI
        js.context.callMethod('open', ['https://metamask.io/']);
      } else {
        print("❌ No accounts found.");
      }
    } catch (e) {
      print("❌ Error connecting wallet: $e");
    }
  }

  /// Switch to Sepolia Network
  Future<void> switchToSepolia() async {
    if (isMetaMaskAvailable) {
      try {
        await ethereum!.walletSwitchChain(chainId);
      } catch (e) {
        print("❌ Error switching to Sepolia: $e");
      }
    }
  }

  /// Send ETH Transaction and force MetaMask to open
  Future<void> sendTransaction(double amountInEth) async {
    if (!isConnected || provider == null) {
      print("❌ Wallet not connected.");
      return;
    }

    try {
      // 🔥 Open MetaMask when sending transaction
      js.context.callMethod('open', ['https://metamask.io/']);

      final signer = provider!.getSigner();
      final tx = await signer.sendTransaction(
        TransactionRequest(
          to: recipientAddress,
          value: BigInt.from(amountInEth * 1e18), // Convert ETH to Wei
        ),
      );

      print("✅ Transaction sent: $tx");
    } catch (e) {
      print("❌ Transaction failed: $e");
    }
  }
}

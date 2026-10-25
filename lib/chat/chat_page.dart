import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme/app_colors.dart';

class ChatPage extends StatefulWidget {
  final String? carName;
  const ChatPage({super.key, this.carName});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'seller',
      'text': 'Halo, selamat datang di Mercedes-Benz Showroom! 👋',
      'time': '10:00'
    },
    {
      'sender': 'seller',
      'text': 'Ada yang bisa kami bantu terkait mobil impian Anda?',
      'time': '10:01'
    },
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _messages.add({
          'sender': 'user',
          'text': _controller.text.trim(),
          'time': TimeOfDay.now().format(context)
        }));
    _controller.clear();
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _messages.add({
            'sender': 'seller',
            'text': 'Baik, kami akan segera menindaklanjuti. Terima kasih! 🙏',
            'time': TimeOfDay.now().format(context)
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite, // Background Putih
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.gunmetal),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceGrey,
                  image: DecorationImage(
                      image: AssetImage('assets/images/foto_seller.png'),
                      fit: BoxFit.cover)),
              child: Image.asset('assets/images/foto_seller.png',
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, color: AppColors.gunmetal)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Budi (Sales)',
                    style: TextStyle(
                        color: AppColors.gunmetal,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Text(
                    widget.carName != null
                        ? 'Tanya: ${widget.carName}'
                        : 'Online',
                    style: const TextStyle(
                        color: AppColors.moonstone,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppColors.moonstone
                          : AppColors.surfaceGrey, // Biru Pastel & Abu Muda
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isUser
                            ? const Radius.circular(16)
                            : const Radius.circular(0),
                        bottomRight: isUser
                            ? const Radius.circular(0)
                            : const Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(msg['text'],
                            style: TextStyle(
                                color:
                                    isUser ? Colors.white : AppColors.gunmetal,
                                fontSize: 15)),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(msg['time'],
                                style: TextStyle(
                                    fontSize: 10,
                                    color: isUser
                                        ? Colors.white70
                                        : AppColors.textGrey)),
                            if (isUser) ...[
                              const SizedBox(width: 4),
                              const Icon(CupertinoIcons.checkmark_alt,
                                  size: 14, color: Colors.white)
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
                border: Border(top: BorderSide(color: AppColors.borderGrey))),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.surfaceGrey,
                        borderRadius: BorderRadius.circular(24)),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: AppColors.gunmetal),
                      decoration: const InputDecoration(
                          hintText: 'Ketik pesan...',
                          hintStyle: TextStyle(color: AppColors.textGrey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.moonstone,
                  radius: 24,
                  child: IconButton(
                      icon: const Icon(CupertinoIcons.paperplane_fill,
                          color: Colors.white, size: 20),
                      onPressed: _sendMessage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

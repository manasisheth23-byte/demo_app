import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../services/claude_service.dart';
import '../widgets/common_widgets.dart';

class ClaudeScreen extends StatefulWidget {
  final UserModel user;
  const ClaudeScreen({super.key, required this.user});

  @override
  State<ClaudeScreen> createState() => _ClaudeScreenState();
}

class _ClaudeScreenState extends State<ClaudeScreen> {
  final _ctrl    = TextEditingController();
  final _scroll  = ScrollController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  bool _loading = false;
  bool _showQuickQ = true;

  @override
  void initState() {
    super.initState();
    // Initial AI message
    _messages.add(ChatMessage(
      content: 'Good morning. I have today\'s full Cloud9 context loaded — DDMRP buffers, DBR schedule, MES floor status, CCPM projects, and ERP orders. 3 components are in the red zone, the K2 CCR buffer is 34% penetrated, and 4 customer orders are at risk. What would you like to analyse?',
      isUser: false,
    ));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _loading) return;
    _ctrl.clear();
    setState(() {
      _messages.add(ChatMessage(content: text, isUser: true));
      _loading = true;
      _showQuickQ = false;
    });
    _scrollToBottom();

    try {
      final reply = await ClaudeService.sendMessage(
        userMessage: text,
        history: _messages.sublist(0, _messages.length - 1),
      );
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(content: reply, isUser: false));
          _loading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            content: 'Unable to connect to Claude AI. Please check your API key and network connection.',
            isUser: false,
          ));
          _loading = false;
        });
        _scrollToBottom();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: SafeArea(
        child: Column(children: [
          // ── Header ─────────────────────────────────────────────
          Container(

            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: const BoxDecoration(
                color: AppColors.puple,
                border: Border(bottom: BorderSide(color: AppColors.borderCard))),
            child: Row(children: [
              // Cloud9 small logo
              const Cloud9Logo(fontSize: 20),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Claude AI',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.bgCard, letterSpacing: -0.3)),
                const Text('Powered by Anthropic · TOC context loaded',
                  style: TextStyle(fontSize: 10.5, color: AppColors.textMuted)),
              ])),
              // Status dot
              Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(color: AppColors.zoneAmber, shape: BoxShape.circle),
              ),
            ]),
          ),

          // ── Messages ───────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(14),
              itemCount: _messages.length + (_loading ? 1 : 0),
              itemBuilder: (context, i) {
                if (_loading && i == _messages.length) return _TypingIndicator();
                final msg = _messages[i];
                return _MessageBubble(message: msg);
              },
            ),
          ),

          // ── Quick questions ────────────────────────────────────
          if (_showQuickQ)
            Container(
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ClaudeService.quickQuestions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => _sendMessage(ClaudeService.quickQuestions[i]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.borderCard),
                      ),
                      child: Text(
                        _shortLabel(ClaudeService.quickQuestions[i]),
                        style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
                      ),
                    ),
                  );
                },
              ),
            ),

          // ── Input row ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            decoration: const BoxDecoration(
              color: AppColors.bgCard,
              border: Border(top: BorderSide(color: AppColors.borderCard)),
            ),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  focusNode: _focusNode,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Ask about any module, order, buffer…',
                    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: AppColors.borderCard),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: AppColors.borderCard),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: AppColors.bgCard.withOpacity(0.5)),
                    ),
                    filled: true,
                    fillColor: AppColors.bgCard,
                  ),
                  onSubmitted: _sendMessage,
                  textInputAction: TextInputAction.send,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _loading ? null : () => _sendMessage(_ctrl.text),
                child: AnimatedOpacity(
                  opacity: _loading ? 0.4 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 36, height: 36,
                    decoration: const BoxDecoration(color: AppColors.bgCard, shape: BoxShape.circle),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  String _shortLabel(String q) {
    if (q.length > 28) return '${q.substring(0, 26)}…';
    return q;
  }
}

// ── Message Bubble ────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 40),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            color: AppColors.c9Blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(3),
            ),
          ),
          child: Text(message.content,
            style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.5)),
        ),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, right: 40),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(12),
          ),
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('CLAUDE AI',
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.bgCard, letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(message.content,
            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.55)),
        ]),
      ),
    );
  }
}

// ── Typing indicator ──────────────────────────────────────────

class _TypingIndicator extends StatefulWidget {
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> with TickerProviderStateMixin {
  late List<AnimationController> _ctrls;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(3, (i) {
      final c = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))
        ..repeat(reverse: true);
      Future.delayed(Duration(milliseconds: i * 200), () { if (mounted) c.repeat(reverse: true); });
      return c;
    });
  }

  @override
  void dispose() {
    for (final c in _ctrls) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12),
            bottomLeft: Radius.circular(3), bottomRight: Radius.circular(12),
          ),
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) => AnimatedBuilder(
            animation: _ctrls[i],
            builder: (_, __) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 5, height: 5,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withOpacity(0.4 + 0.6 * _ctrls[i].value),
                shape: BoxShape.circle,
              ),
            ),
          )),
        ),
      ),
    );
  }
}

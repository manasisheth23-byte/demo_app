import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

/// ClaudeService — integrates with Anthropic's Claude API
/// Replace [apiKey] with your actual key (use flutter_dotenv in production).

class ClaudeService {
  ClaudeService._();

  static const String _apiUrl = 'https://api.anthropic.com/v1/messages';
  static const String _model  = 'claude-sonnet-4-20250514';

  /// ⚠ Store this in a secure backend proxy in production. Never ship API keys in the app.
  static const String apiKey  = 'YOUR_ANTHROPIC_API_KEY_HERE';

  static const String _systemPrompt = '''
You are Claude AI embedded in Cloud9 ERP — a TOC-based enterprise platform (CCPM, DDMRP, DBR, MES, ERP) built by Cloud9 eBiz Pvt. Ltd. You assist CEOs, Directors, and Plant Heads with TOC-based decision support. Answer concisely (2-5 sentences) — this is a mobile interface.

Today's live status:
DDMRP RED: MS Pipe Asm 40mm (K2, NFP 12%, no PO, 1.8d coverage), Fabric Panel Grey (K4, NFP 8%, 1.2d), Caster Wheel 75mm (K3, NFP 22%, no PO, 2.8d)
DDMRP YELLOW: 7 SKUs trending down
DBR: Paint Shop K2 CCR — 34% buffer penetration, 87% utilization, 12 jobs in queue, 5 in red buffer zone
MES K2: CELL-07 2.5h behind plan; CELL-09 ahead of plan; K3 at 74% of plan
CCPM: Project Phoenix (Godrej Interio) 74% buffer consumed; i-tek ERP Phase I 68% consumed; Rishi Laser 48%; Gufic 28%
ERP: 47 open orders; 4 at OTD risk (₹18L total); OTD rate 84.6% vs 90% target; 8 dispatches planned today
Root cause chain: CELL-07 delay → Paint Shop queue → CCR buffer penetration → OTD risk

Be a decisive TOC expert. Give specific names and numbers. Prioritize by throughput impact.
''';

  /// Send a message and receive AI response.
  static Future<String> sendMessage({
    required String userMessage,
    required List<ChatMessage> history,
  }) async {
    final messages = <Map<String, String>>[
      ...history.map((m) => {
        'role': m.isUser ? 'user' : 'assistant',
        'content': m.content,
      }),
      {'role': 'user', 'content': userMessage},
    ];

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': 1000,
        'system': _systemPrompt,
        'messages': messages,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final content = data['content'] as List<dynamic>;
      return content.first['text'] as String;
    } else {
      throw Exception('Claude API error ${response.statusCode}: ${response.body}');
    }
  }

  /// Quick questions pre-loaded for the Claude chat screen
  static const List<String> quickQuestions = [
    'What is the single most urgent action I need to take this morning?',
    'How does the CELL-07 delay connect to the CCR buffer penetration?',
    'If I re-sequence the drum today, which orders can I save?',
    'Which vendor should I call first for the red-zone DDMRP items?',
    'What will OTD look like by end of week if no action is taken?',
  ];
}

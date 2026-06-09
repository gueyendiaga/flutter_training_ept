import 'package:flutter_training/core/models/chat_model.dart';

final List<ChatModel> chats = [
  ChatModel(
    name: 'Mamadou Falilou',
    message: 'Bonjour, comment ça va ?',
    date: '9 juin 2026',
    type: MessageType.text
  ),
  ChatModel(
    name: 'Fatima Diallo',
    message: 'Salut, ça va ?',
    photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ43Vw_rjnFDbHwcJD7XOT_fyDkEROeqk64Er8N47H9tQ&s',
    date: '5 juin 2026',
    type: MessageType.text
  ),
  ChatModel(
    name: 'Abdou Fatah GUEYE',
    message: 'Hey, what\'s up?',
    photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ43Vw_rjnFDbHwcJD7XOT_fyDkEROeqk64Er8N47H9tQ&s',
    date: '8 juin 2026',
    type: MessageType.audio
  ),
    ChatModel(
    name: 'Abdou Salam Mboup',
    message: 'Oui, ça va bien, merci !',
    photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ43Vw_rjnFDbHwcJD7XOT_fyDkEROeqk64Er8N47H9tQ&s',
    date: '04 juin 2026',
    type: MessageType.text
  ),
  ChatModel(
    name: 'Adja Soukeyna Diop',
    message: 'Ok d\'accord, à plus tard !',
    date: '03 juin 2026',
    type: MessageType.text
  ),
  ChatModel(
    name: 'Aïssatou Sow',
    message: 'Ok, à plus tard !',
    date: '02 juin 2026',
    type: MessageType.document
  ),
  ChatModel(
    name: 'Amath Thiam',
    message: 'Salut !',
    date: '01 juin 2026',
    type: MessageType.video
  ),
    ChatModel(
    name: 'Ndiaga GUEYE',
    message: 'Good Job !',
    date: '03 juin 2026',
    type: MessageType.document
  ),
  ChatModel(
    name: 'Mohamed Lamine Diop',
    message: 'Pas de souci.',
    date: '01 juin 2026',
    type: MessageType.video
  )
];
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mensageiro/app/core/infra/call/signalling_service.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/presenter/pages/chat_controller.dart';
import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import "package:cached_network_image/cached_network_image.dart";

class ChatPage extends StatefulWidget {
  final ChatController controller;
  final Contact contact;

  const ChatPage({
    Key? key,
    required this.controller,
    required this.contact,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late VideoPlayerController _videoPlayerController;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  AudioRecorder _audioRecorder = AudioRecorder();
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _startVideoCall,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Chat>>(
              stream: widget.controller.messages(widget.contact.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [_buildMessagesList(snapshot.data!)],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          _buildMessageComposer(context),
        ],
      ),
    );
  }

  Widget _buildMessagesList(List<Chat> messages) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        if (message.typeMessage == 'A') {
          return _buildAudioBubble(message);
        } else if (message.typeMessage == 'P') {
          return _buildImageBubble(message);
        } else if (message.typeMessage == 'V') {
          return _buildVideoMessage(message);
        } else if (message.typeMessage == 'D') {
          return _buildDocumentMessage(message);
        }
        return _buildTextBubble(message);
      },
    );
  }

  Widget _buildAudioBubble(Chat message) {
    return BubbleNormalAudio(
      color: const Color(0xFFE8E8EE),
      duration: duration.inSeconds.toDouble(),
      position: position.inSeconds.toDouble(),
      isPlaying: isPlaying,
      isLoading: isLoading,
      isPause: isPause,
      isSender: message.userId != widget.contact.id,
      onSeekChanged: _changeSeek,
      key: Key(message.timestamp),
      onPlayPauseButtonClick: () {
        _playAudio(audioLink: message.message);
      },
      sent: true,
    );
  }

  Widget _buildImageBubble(Chat message) {
    return BubbleNormalImage(
      id: message.id ?? message.timestamp,
      image: _image(message.message),
      color: Colors.transparent,
      tail: true,
      sent: true,
      delivered: true,
    );
  }

  Widget _buildVideoMessage(Chat message) {
    return ListTile(
      title: AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(_videoPlayerController),
      ),
    );
  }

  Widget _buildDocumentMessage(Chat message) {
    return ListTile(
      title: Text("Document: ${message.message}"),
    );
  }

  Widget _buildTextBubble(Chat message) {
    return BubbleNormal(
      text: message.message,
      isSender: message.userId != widget.contact.id,
      color: Colors.black,
      sent: true,
      tail: true,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMessageComposer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[300],
              ),
              child: Row(
                children: <Widget>[
                  _buildAttachmentButton(context),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Digite uma mensagem...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                  ),
                  _buildSendButton(),
                ],
              ),
            ),
          ),
          _buildMicButton(),
        ],
      ),
    );
  }

  Widget _buildAttachmentButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.black,
      ),
      child: IconButton(
        icon: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showAttachmentOptions(context);
        },
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey,
      ),
      child: IconButton(
        icon: Icon(Icons.send, color: Colors.white),
        onPressed: () {
          _sendMessage(_messageController.text);
        },
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPressed ? Colors.red : Colors.grey[300],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.mic,
          color: _isPressed ? Colors.white : Colors.black,
          size: _isPressed ? 32 : 28,
        ),
      ),
      onLongPress: () {
        setState(() {
          _isPressed = true;
          _recordAudio();
        });
      },
      onLongPressUp: () {
        setState(() {
          _isPressed = false;
          _recordAudioStop();
        });
      },
    );
  }

  void _startVideoCall() {
    final signallingService = SignallingService.instance;
    signallingService.socket?.emit('startVideosCall', {
      'callerId': widget.contact.id,
      'calleeId': widget.contact.id,
    });
  }

  void _sendMessage(String message) {
    widget.controller.sendMessage(
      widget.contact.id,
      Chat(
        message: message,
        timestamp: DateTime.now().toString(),
        typeMessage: 'M',
      ),
    );
    _messageController.clear();
  }

  Future<void> _recordAudioStop() async {
    final recording = await _audioRecorder.stop();
    if (recording == null) {
      return;
    }
    await widget.controller.sendAudio(widget.contact.id, recording);
  }

  Future<void> _recordAudio() async {
    if (await _audioRecorder.hasPermission()) {
      String directoryPath =
          (await getApplicationDocumentsDirectory()).path;
      Directory('$directoryPath/audio/').createSync(recursive: true);
      String filePath =
          '$directoryPath${DateTime.now().millisecondsSinceEpoch}.wav';

      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.wav, bitRate: 128000),
        path: filePath,
      );
    }
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildAttachmentOption(
                Icon(Icons.photo_camera),
                'Fotos',
                () {
                  _sendPhoto();
                },
              ),
              _buildAttachmentOption(
                Icon(Icons.videocam),
                'Vídeos',
                () {
                  // _sendVideo();
                },
              ),
              _buildAttachmentOption(
                Icon(Icons.insert_drive_file),
                'Documentos',
                () {
                  _sendDocuments();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile _buildAttachmentOption(
    Icon icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTap,
    );
  }

  Future<void> _sendPhoto() async {
    await widget.controller.sendImage(widget.contact.id);
  }

  Future<void> _sendDocuments() async {
    await widget.controller.sendDocument(widget.contact.id);
  }

  Widget _image(String image) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 20.0,
        minWidth: 20.0,
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  void _playAudio({required String audioLink}) async {
    final url = audioLink;
    if (isPause) {
      await audioPlayer.resume();
      setState(() {
        isPlaying = true;
        isPause = false;
      });
    } else if (isPlaying) {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
        isPause = true;
      });
    } else {
      setState(() {
        isLoading = true;
      });
      await audioPlayer.setSourceDeviceFile(url);
      audioPlayer.resume();

      setState(() {
        audioPlayer.getDuration.call().then((value) => duration = value!);
        isPlaying = true;
      });
    }

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
        isLoading = false;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        duration = const Duration();
        position = const Duration();
      });
    });
  }

  void _changeSeek(double value) {
    setState(() {
      audioPlayer.seek(Duration(seconds: value.toInt()));
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    audioPlayer.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }
}

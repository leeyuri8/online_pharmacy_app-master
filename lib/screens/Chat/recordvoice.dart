import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:drug_delivery_application/helpers/theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../backend/firebase.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class Recordvoice extends StatefulWidget {
  final String usrrecivname;
  final String usrrecivid;
  final String groupNameController;
  final String usrrecivmsg;
  final String userImage;
  Recordvoice(this.usrrecivname, this.usrrecivid, this.groupNameController,
      this.usrrecivmsg, this.userImage,
      {Key? key})
      : super(key: key);

  @override
  State<Recordvoice> createState() => _RecordvoiceState();
}

class _RecordvoiceState extends State<Recordvoice> {
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  @override
  void initState() {
    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  String msar = '';
  Future<void> openTheRecorder() async {
    // if (!kIsWeb) {
    //   var status = await Permission.microphone.request();
    //   if (status != PermissionStatus.granted) {
    //     throw RecordingPermissionException('Microphone permission not granted');
    //   }
    // }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = msar + '.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    setState(() {
      print('openTheRecorderhiii');

      msar = Uuid().v1();
    });
    _mPath = msar + '.mp4';
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        _mplaybackReady = true;
        onFileUploadButtonPressed(value!).then((value) {
          print(value);

          savechatFirestore(widget.usrrecivname, widget.usrrecivid,
              widget.groupNameController, false, 0, 0, value, true, false, '', widget.userImage );
        });
      });
    });
  }

  bool micrec = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      margin: EdgeInsets.only(left: 5.w, right: 5.w),
      decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(
          Icons.mic,
          color: micrec == false ? white : red,
        ),
        onPressed: () async {
          setState(() {
            micrec = !micrec;
            micrec == true ? record() : stopRecorder();
          });
        },
      ),
    );
  }
}

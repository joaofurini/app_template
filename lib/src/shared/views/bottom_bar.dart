import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/classes.dart';
import '../extensions.dart';

import '../providers/providers.dart';
import 'image_clipper.dart';

/// Currently-playing informational bar that always spans the entire bottom
/// of the UI.
class BottomBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return _BottomBar();
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    this.artist,
    this.isMuted,
    this.isPlaying,
    this.preferredSize,
    this.progress,
    this.song,
    this.togglePlayPause,
    this.volume,
  });

  final Artist? artist;
  final bool? isMuted;
  final bool? isPlaying;
  final Size? preferredSize;
  final Duration? progress;
  final Song? song;
  final VoidCallback? togglePlayPause;
  final double? volume;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => constraints.isTablet
            ? _buildDesktopBar(context, constraints)
            : _buildMobileBar(context, constraints),
      );

  Widget _buildDesktopBar(BuildContext context, BoxConstraints constraints) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox.fromSize(
        size: preferredSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                _AlbumArt(song: song),
                _SongDetails(
                  artist: artist,
                  song: song,
                ),
              ],
            ),
            if (song != null)
              IconButton(
                icon: const Icon(Icons.fullscreen),
                onPressed: () {
                  final overlay = Overlay.of(context);
                  OverlayEntry? entry;
                  entry = OverlayEntry(
                    builder: (context) => Stack(
                      children: [
                        Positioned(
                          child: _FullScreenPlayer(
                            onClose: () {
                              entry?.remove();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                  overlay!.insert(entry);
                },
              ),
          ],
        ),
      ),
    );
  }

  double get songProgress => progress != null && song != null
      ? progress!.inMilliseconds / song!.length.inMilliseconds
      : 0;

  Widget _buildMobileBar(BuildContext context, BoxConstraints constraints) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox(
        height: kToolbarHeight,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            final overlay = Overlay.of(context);
            OverlayEntry? entry;
            entry = OverlayEntry(
              builder: (context) => Stack(
                children: [
                  Positioned(
                    child: _MobilePlayer(
                      onClose: () {
                        entry?.remove();
                      },
                    ),
                  ),
                ],
              ),
            );
            overlay!.insert(entry);
          },
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 4,
                bottom: 0,
                child: LinearProgressIndicator(
                  value: songProgress.clamp(0, 1),
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              Positioned(
                left: 4,
                bottom: 4,
                top: 4,
                right: 4,
                child: Row(
                  children: [
                    _AlbumArt(song: song),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song?.title ?? '',
                          style: context.labelMedium,
                        ),
                        Text(
                          song?.artist.name ?? '',
                          style: context.labelSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.progress,
    required this.song,
  });

  /// Current playback depth into user is into [song].
  final Duration? progress;

  final Song? song;

  double get songProgress => progress != null && song != null
      ? progress!.inMilliseconds / song!.length.inMilliseconds
      : 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        late EdgeInsets padding = EdgeInsets.zero;
        if (constraints.maxWidth > 500) {
          padding = const EdgeInsets.symmetric(horizontal: 50);
        } else if (constraints.maxWidth < 350) {
          padding = const EdgeInsets.symmetric(horizontal: 25);
        } else {
          padding = const EdgeInsets.symmetric(horizontal: 20);
        }
        return Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                child: progress != null
                    ? Text(progress!.toHumanizedString(),
                        style: Theme.of(context).textTheme.bodySmall)
                    : const Text('-'),
              ),
              Expanded(
                child: Slider(
                  value: songProgress.clamp(0, 1),
                  divisions: 1000,
                  onChanged: (percent) {},
                  onChangeEnd: (percent) {
                    // Because dragging pauses auto playback, resume playing
                    // once the user finishes dragging.
                  },
                  activeColor:
                      Theme.of(context).colorScheme.onTertiaryContainer,
                  inactiveColor: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(
                child: song != null
                    ? Text(song!.length.toHumanizedString(),
                        style: Theme.of(context).textTheme.bodySmall)
                    : const Text('-'),
              ),
              const SizedBox(width: 10)
            ],
          ),
        );
      },
    );
  }
}

class _VolumeBar extends StatelessWidget {
  const _VolumeBar({
    required this.volume,
    required this.isMuted,
  });

  /// The percentage, between 0 and 1, at which to render the volume slider.
  final double volume;

  /// True if the user has explicitly pressed the mute button. The value for
  /// [volume] can be zero without this also being `true`, but if this is `true`,
  /// then the value for [volume] will always be zero.
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            GestureDetector(
              child: Icon(!isMuted ? Icons.volume_mute : Icons.volume_off),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaybackControls extends StatelessWidget {
  const _PlaybackControls({
    required this.isPlaying,
    required this.togglePlayPause,
  });

  final bool isPlaying;
  final VoidCallback togglePlayPause;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double iconSize = 24;
      double playIconSize = 32;
      double innerPadding = 16;
      double playPadding = 20;
      if (constraints.maxWidth < 500) {
        iconSize = 21;
        playIconSize = 28;
        innerPadding = 14;
        playPadding = 17;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, innerPadding, 0),
              child: Icon(Icons.shuffle, size: iconSize)),
          Icon(Icons.skip_previous, size: iconSize),
          Padding(
            padding: EdgeInsets.fromLTRB(playPadding, 0, innerPadding, 0),
            child: GestureDetector(
              onTap: togglePlayPause,
              child: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: playIconSize,
              ),
            ),
          ),
          Icon(Icons.skip_next, size: iconSize),
          Padding(
            padding: EdgeInsets.fromLTRB(innerPadding, 0, 0, 0),
            child: Icon(Icons.repeat, size: iconSize),
          ),
        ],
      );
    });
  }
}

class _AlbumArt extends StatelessWidget {
  const _AlbumArt({
    required this.song,
  });

  final Song? song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 70,
        height: 70,
        child: song != null
            ? Image.asset(song!.image.image)
            : Container(
                color: Colors.pink[100],
              ),
      ),
    );
  }
}

class _SongDetails extends StatelessWidget {
  const _SongDetails({
    required this.artist,
    required this.song,
  });

  final Artist? artist;
  final Song? song;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song != null ? song!.title : '-',
              style: context.labelLarge!.copyWith(fontSize: 12),
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
            Text(
              artist != null ? artist!.name : '-',
              style: context.labelSmall!.copyWith(fontSize: 8),
              overflow: TextOverflow.clip,
            ),
          ],
        );
      },
    );
  }
}

class _FullScreenPlayer extends StatefulWidget {
  const _FullScreenPlayer({
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  State<_FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<_FullScreenPlayer> {
  bool _showControls = true;
  Timer? _controlsTimer;

  void hideControls() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    hideControls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, dimens) {
          return MouseRegion(
            onHover: (_) {
              setState(() {
                _showControls = true;
              });
              hideControls();
            },
            child: buildPlayer(context),
          );
        },
      ),
    );
  }

  Widget buildPlayer(
    BuildContext context,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [],
    );
  }
}

class _MobilePlayer extends StatelessWidget {
  const _MobilePlayer({
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeProvider.of(context).dark(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, dimens) {
            return buildPlayer(context);
          },
        ),
      ),
    );
  }

  Widget buildPlayer(BuildContext context) {
    return Stack(
      children: [],
    );
  }
}

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'list_tile.dart';
import 'switch.dart';
import 'theme.dart';

/// A [ListTile] with a [Switch]. In other words, a switch with a label.
///
/// The entire list tile is interactive: tapping anywhere in the tile toggles
/// the switch.
///
/// The [value], [onChanged], [activeColor], [activeThumbImage], and
/// [inactiveThumbImage] properties of this widget are identical to the
/// similarly-named properties on the [Switch] widget.
///
/// The [title], [subtitle], [isThreeLine], and [dense] properties are like
/// those of the same name on [ListTile].
///
/// The [selected] property on this widget is similar to the [ListTile.selected]
/// property, but the color used is that described by [activeColor], if any,
/// defaulting to the accent color of the current [Theme]. No effort is made to
/// coordinate the [selected] state and the [value] state; to have the list tile
/// appear selected when the switch is on, pass the same value to both.
///
/// The switch is shown on the right by default in left-to-right languages (i.e.
/// in the [ListTile.trailing] slot). The [secondary] widget is placed in the
/// [ListTile.leading] slot. This cannot be changed; there is not sufficient
/// space in a [ListTile]'s [ListTile.leading] slot for a [Switch].
///
/// ## Sample code
///
/// This widget shows a switch that, when toggled, changes the state of a [bool]
/// member field called `_lights`.
///
/// ```dart
/// new SwitchListTile(
///   title: const Text('Lights'),
///   value: _lights,
///   onChanged: (bool value) { setState(() { _lights = value; }); },
///   secondary: const Icon(Icons.lightbulb_outline),
/// )
/// ```
///
/// See also:
///
///  * [ListTileTheme], which can be used to affect the style of list tiles,
///    including switch list tiles.
///  * [CheckboxListTile], a similar widget for checkboxes.
///  * [RadioListTile], a similar widget for radio buttons.
///  * [ListTile] and [Switch], the widgets from which this widget is made.
class SwitchListTile extends StatelessWidget {
  /// Creates a combination of a list tile and a switch.
  ///
  /// The switch tile itself does not maintain any state. Instead, when the
  /// state of the switch changes, the widget calls the [onChanged] callback.
  /// Most widgets that use a switch will listen for the [onChanged] callback
  /// and rebuild the switch tile with a new [value] to update the visual
  /// appearance of the switch.
  ///
  /// The following arguments are required:
  ///
  /// * [value] determines whether this switch is on or off.
  /// * [onChanged] is called when the user toggles the switch on or off.
  const SwitchListTile({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.title,
    this.subtitle,
    this.isThreeLine: false,
    this.dense,
    this.secondary,
    this.selected: false,
  }) : assert(value != null),
       assert(isThreeLine != null),
       assert(!isThreeLine || subtitle != null),
       assert(selected != null),
       super(key: key);

  /// Whether this switch is checked.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch tile with the
  /// new value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// new SwitchListTile(
  ///   value: _lights,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _lights = newValue;
  ///     });
  ///   },
  ///   title: new Text('Lights'),
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to accent color of the current [Theme].
  final Color activeColor;

  /// An image to use on the thumb of this switch when the switch is on.
  final ImageProvider activeThumbImage;

  /// An image to use on the thumb of this switch when the switch is off.
  final ImageProvider inactiveThumbImage;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget subtitle;

  /// A widget to display on the opposite side of the tile from the switch.
  ///
  /// Typically an [Icon] widget.
  final Widget secondary;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  final bool dense;

  /// Whether to render icons and text in the [activeColor].
  ///
  /// No effort is made to automatically coordinate the [selected] state and the
  /// [value] state. To have the list tile appear selected when the switch is
  /// on, pass the same value to both.
  ///
  /// Normally, this property is left to its default value, false.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Widget control = new Switch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      activeThumbImage: activeThumbImage,
      inactiveThumbImage: inactiveThumbImage,
    );
    return new MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? Theme.of(context).accentColor,
        child: new ListTile(
          leading: secondary,
          title: title,
          subtitle: subtitle,
          trailing: control,
          isThreeLine: isThreeLine,
          dense: dense,
          enabled: onChanged != null,
          onTap: onChanged != null ? () { onChanged(!value); } : null,
          selected: selected,
        ),
      ),
    );
  }
}

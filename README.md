# Bird Game

A tiny top-down 2D game made with **Godot 4.7**. Fly the bird around the scene, scoop up berries, and drop them in the basket. Every berry delivered adds to your count.

![Godot](https://img.shields.io/badge/Godot-4.7-478cbf?logo=godotengine&logoColor=white)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)

## Gameplay

One berry at a time. Touch a berry to pick it up — the bird carries it visibly. Touch the basket
while carrying a berry to drop it in and score a point. Three berries are scattered around the level.

The whole loop is:

```
fly to a berry -> pick it up -> fly to the basket -> drop it -> count +1
```

## Controls

| Action | Key |
| --- | --- |
| Move | Arrow keys |

Movement is 8-directional with no acceleration or gravity — this is a top-down game, not a platformer.

## Running the project

1. Install [Godot 4.7](https://godotengine.org/download) (standard build, not .NET).
2. Open `project.godot` in the editor, or from a terminal:

   ```sh
   godot --path .
   ```

3. Press **F5** to play.

The project uses the **GL Compatibility** renderer, so it runs on low-end GPUs and older hardware.

## Project structure

```
project.godot     Project settings, input map, renderer config
main.tscn         The level: background, basket, player, berries, HUD
player.gd         Movement, berry pickup, basket delivery, score label
berry.tscn        Reusable berry pickup (Area2D + sprite + circle shape)
Heaven Kanpur/    Image assets
```

## How it works

- **`Player`** is a `CharacterBody2D` that reads the `move_left` / `move_right` / `move_up` /
  `move_down` actions and calls `move_and_slide()` each physics frame.
- **`PickupArea`** is an `Area2D` on the player that detects both berries and the basket.
  The `area_entered` signal handles the instant case, and a per-frame overlap check in
  `_physics_process` covers picking a berry up while already standing in the basket.
- **Berries** are `Area2D`s in the `Berry` group; the **basket** is an `Area2D` in the `Basket`
  group (group names are case-sensitive).
- The HUD label lives in a `CanvasLayer`, so the score stays fixed on screen.

## Status

Playable prototype. The three core actions — movement, pickup, delivery — are implemented and
verified. No menus, audio, win screen, or save system yet.

## Known limitations

- No win condition yet: after the third delivery the level is simply empty.
- Art is placeholder stock imagery; replace it with original or properly licensed assets before
  releasing anything.
- No export presets are set up yet, so there is no distributable build.
- No automated tests are checked in.

## License

No license file yet — treat this as all rights reserved until one is added.
Third-party images in `Heaven Kanpur/` remain the property of their original creators.

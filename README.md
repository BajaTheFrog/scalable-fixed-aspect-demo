# Scalable Fixed Aspect Ratio 
Or in other words - setting up your game to be constrained by UI/Screen bounds.

![Demo in action](demo.gif)


The primary use case here is something like making a mobile game played in portrait.
And you want a consistent and constrained gameplay region that can scale within any screen size. 

Check out `phone_portrait_demo` to see a demo. 

Check out `phone_portrait_template` to see the bare-bones setup you could use. 

## Usage
When customizing, you'll want to play around with a few things.

### safe_area_container
`safe_area_container` is an `AspectRatioContainer`.
Set it to a ratio or size that represents the "safe area" of your game. 

> On iOS, there is an actual concept of a Safe Area. This is not using that but it is trying to solve for the same thing. 

Your safe area should be within the margins of the overall display such that a user can safely interact with it or read information on it.

### game_viewport_container
`game_viewport_container` is a `SubViewportContainer` that will hold onto your gameplay scene.
The effect here is created by the following configuration:
- `stretch` is set to `false`
- the `horizontal` and `vertical` container sizing values are set to `shrink center`

### game_viewport
`game_viewport` is a `SubViewport`.
Set its dimensions to the explicit size you want your game to be.
Don't worry - it will scale within the container, this is essentially the target or reference size.


## Credits
Texture Pattern: https://polycount.com/discussion/186513/free-checker-pattern-texture

Reddit Help: https://www.reddit.com/r/godot/comments/1gg4kz5/looking_for_help_with_subviewports_resizing/

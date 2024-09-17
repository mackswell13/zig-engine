const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    var pos_x: i32 = 40;
    var pos_y: i32 = 40;


    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");

    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second

    // Main game loop
    while (!rl.windowShouldClose()) { 
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);
        
        rl.drawFPS(10, 10);

        if (rl.isKeyDown(rl.KeyboardKey.key_w)) {
            pos_y -= 10;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_a)) {
            pos_x -= 10;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_s)) {
            pos_y += 10;
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_d)) {
            pos_x += 10;
        }
        rl.drawRectangle(pos_x, pos_y, 100, 100, rl.Color.red);

    }
}

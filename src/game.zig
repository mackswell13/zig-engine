const rl = @import("raylib");

pub const Game = struct {
    tile_size: i32,
    rows: i32,
    cols: i32,
    show_grid: bool = false,

    pub fn init(tile_size: i32, rows: i32, cols: i32) Game {
        return Game{ .tile_size = tile_size, .rows = rows, .cols = cols };
    }

    pub fn handle_input(self: Game) void {
        if (rl.isKeyDown(rl.KeyboardKey.key_g)) {
            self.show_grid = true;
        }
    }

    pub fn run(self: Game) void {
        rl.initWindow(self.rows * self.tile_size, self.cols * self.tile_size, "Test");
        rl.setTargetFPS(60);

        while (!rl.windowShouldClose()) {
            rl.beginDrawing();
            defer rl.endDrawing();
            handle_input();

            rl.clearBackground(rl.Color.white);
            if (self.show_grid) {
                renderGrid(self);
            }
        }
    }
};

fn renderGrid(game: Game) void {
    for (0..@intCast(game.rows)) |r| {
        for (0..@intCast(game.cols)) |c| {
            const i: i32 = @intCast(r);
            const j: i32 = @intCast(c);
            rl.drawRectangleLines(i * game.tile_size, j * game.tile_size, game.tile_size, game.tile_size, rl.Color.red);
        }
    }
}

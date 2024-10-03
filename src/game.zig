const std = @import("std");
const rl = @import("raylib");

pub const Game = struct {
    tile_size: i32,
    rows: i32,
    cols: i32,
    show_grid: bool = false,

    pub fn init(tile_size: i32, rows: i32, cols: i32) Game {
        return Game{ .tile_size = tile_size, .rows = rows, .cols = cols };
    }

    pub fn handle_input(self: *Game) void {
        if (rl.isKeyPressed(rl.KeyboardKey.key_g) and rl.isKeyDown(rl.KeyboardKey.key_left_control)) {
            self.show_grid = !self.show_grid;
        }
    }

    pub fn run(self: *Game) void {
        rl.initWindow(self.rows * self.tile_size, self.cols * self.tile_size, "Test");
        rl.setTargetFPS(60);

        const camera = rl.Camera2D{
            .target = rl.Vector2{ .x = 0, .y = 0 },
            .offset = rl.Vector2{ .x = 0, .y = 0 },
            .rotation = 0.0,
            .zoom = 1,
        };

        var player = Player.init();

        while (!rl.windowShouldClose()) {
            self.handle_input();
            player.update();

            rl.beginDrawing();
            rl.beginMode2D(camera);
            defer rl.endMode2D();
            defer rl.endDrawing();


            rl.clearBackground(rl.Color.white);
            drawChunk(0, 0);
            player.render();
            if (self.show_grid) {
                renderGrid(self);
            }
        }
    }
};

const Player = struct {
    pos: rl.Vector2,
    color: rl.Color,
    size: i32,

    pub fn init() Player {
        return Player{
            .pos = rl.Vector2{ .x = 10, .y = 10 },
            .color = rl.Color.blue,
            .size = 32,
        };
    }

    pub fn update(self: *Player) void {
        if (rl.isKeyPressed(rl.KeyboardKey.key_w)) {
            self.pos.y -= 1;
        }
        if (rl.isKeyPressed(rl.KeyboardKey.key_a)) {
            self.pos.x -= 1;
        }
        if (rl.isKeyPressed(rl.KeyboardKey.key_s)) {
            self.pos.y += 1;
        }
        if (rl.isKeyPressed(rl.KeyboardKey.key_d)) {
            self.pos.x += 1;
        }
        if (rl.isKeyPressed(rl.KeyboardKey.key_p)) {
            std.debug.print("x: {d}, y {d}\n", .{self.pos.x, self.pos.y});
        }
    }

    pub fn render(self: *Player) void {
        const actual = calcRenderPos(self.pos);
        rl.drawRectangle(@intFromFloat(actual.x), @intFromFloat(actual.y), self.size, self.size, self.color);
    }
};

fn drawChunk(x: i32, y: i32) void {
    rl.drawRectangle(x, y, 32 * 16, 32 * 16, rl.Color.red);
}

fn calcRenderPos(pos: rl.Vector2) rl.Vector2 {
    return rl.Vector2{ .x = pos.x * 32, .y = pos.y * 32 };
}

fn renderGrid(game: *Game) void {
    for (0..@intCast(game.rows)) |r| {
        for (0..@intCast(game.cols)) |c| {
            const i: i32 = @intCast(r);
            const j: i32 = @intCast(c);
            rl.drawRectangleLines(i * game.tile_size, j * game.tile_size, game.tile_size, game.tile_size, rl.Color.red);
        }
    }
}

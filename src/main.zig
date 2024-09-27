const rl = @import("raylib");
const game = @import("game.zig");

pub fn main() anyerror!void {
    var g = game.Game.init(32, 40, 30);

    g.run();
}

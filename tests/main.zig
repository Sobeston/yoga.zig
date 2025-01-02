const std = @import("std");
const yoga = @import("yoga");

test "basic" {
    const config = yoga.YGConfigGetDefault();

    const root = yoga.YGNodeNewWithConfig(config);
    yoga.YGNodeStyleSetFlexDirection(root, yoga.YGFlexDirectionRow);
    yoga.YGNodeStyleSetPositionType(root, yoga.YGPositionTypeAbsolute);
    yoga.YGNodeStyleSetWidthAuto(root);
    yoga.YGNodeStyleSetHeight(root, 50);

    yoga.YGNodeCalculateLayout(root, 100, 100, yoga.YGDirectionInherit);

    try std.testing.expectApproxEqAbs(50, yoga.YGNodeLayoutGetHeight(root), 0.1);
    try std.testing.expectApproxEqAbs(0, yoga.YGNodeLayoutGetLeft(root), 0.1);
}

const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("yoga_cpp", .{});
    const lib = b.addStaticLibrary(.{
        .name = "yogacore",
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
    lib.linkLibC();
    lib.linkLibCpp();

    lib.addIncludePath(upstream.path(""));

    lib.addCSourceFiles(.{
        .root = upstream.path(""),
        .files = source_files,
        .flags = &.{
            "-Wall",
            "-Wextra",
            "-Wpedantic",
            "-Wformat",
            "-std=c++20",
        },
    });

    for (includes) |inc| {
        lib.installHeader(upstream.path(inc), inc);
    }

    b.installArtifact(lib);
}

const includes: []const []const u8 = &.{
    "yoga/YGConfig.h",
    "yoga/YGEnums.h",
    "yoga/YGMacros.h",
    "yoga/YGNode.h",
    "yoga/YGNodeLayout.h",
    "yoga/YGNodeStyle.h",
    "yoga/YGPixelGrid.h",
    "yoga/YGValue.h",
    "yoga/Yoga.h",
};

const source_files: []const []const u8 = &.{
    "yoga/YGEnums.cpp",
    //     "yoga/YGNode.h",
    "yoga/YGPixelGrid.cpp",
    "yoga/YGConfig.cpp",
    "yoga/YGNode.cpp",
    //     "yoga/event/event.h",
    "yoga/event/event.cpp",
    //     "yoga/algorithm/CalculateLayout.h",
    //     "yoga/algorithm/PixelGrid.h",
    "yoga/algorithm/CalculateLayout.cpp",
    //     "yoga/algorithm/FlexDirection.h",
    //     "yoga/algorithm/Align.h",
    //     "yoga/algorithm/Cache.h",
    //     "yoga/algorithm/Baseline.h",
    "yoga/algorithm/PixelGrid.cpp",
    "yoga/algorithm/Cache.cpp",
    //     "yoga/algorithm/FlexLine.h",
    "yoga/algorithm/FlexLine.cpp",
    "yoga/algorithm/AbsoluteLayout.cpp",
    //     "yoga/algorithm/BoundAxis.h",
    //     "yoga/algorithm/AbsoluteLayout.h",
    "yoga/algorithm/Baseline.cpp",
    //     "yoga/algorithm/SizingMode.h",
    //     "yoga/algorithm/TrailingPosition.h",
    "yoga/YGValue.cpp",
    "yoga/YGNodeStyle.cpp",
    //     "yoga/Yoga.h",
    //     "yoga/YGEnums.h",
    "yoga/config/Config.cpp",
    //     "yoga/config/Config.h",
    //     "yoga/YGNodeStyle.h",
    //     "yoga/YGMacros.h",
    //     "yoga/YGNodeLayout.h",
    //     "yoga/YGConfig.h",
    //     "yoga/YGValue.h",
    //     "yoga/enums/PhysicalEdge.h",
    //     "yoga/enums/LogLevel.h",
    //     "yoga/enums/BoxSizing.h",
    //     "yoga/enums/Wrap.h",
    //     "yoga/enums/Overflow.h",
    //     "yoga/enums/FlexDirection.h",
    //     "yoga/enums/Align.h",
    //     "yoga/enums/Display.h",
    //     "yoga/enums/Direction.h",
    //     "yoga/enums/Justify.h",
    //     "yoga/enums/MeasureMode.h",
    //     "yoga/enums/Unit.h",
    //     "yoga/enums/Edge.h",
    //     "yoga/enums/PositionType.h",
    //     "yoga/enums/Dimension.h",
    //     "yoga/enums/ExperimentalFeature.h",
    //     "yoga/enums/NodeType.h",
    //     "yoga/enums/Gutter.h",
    //     "yoga/enums/Errata.h",
    //     "yoga/enums/YogaEnums.h",
    //     "yoga/style/StyleLength.h",
    //     "yoga/style/StyleValuePool.h",
    //     "yoga/style/SmallValueBuffer.h",
    //     "yoga/style/StyleValueHandle.h",
    //     "yoga/style/Style.h",
    //     // "yoga/style/StyleSizeLength.h",
    //     "yoga/node/LayoutResults.h",
    "yoga/node/LayoutResults.cpp",
    "yoga/node/Node.cpp",
    //     "yoga/node/LayoutableChildren.h",
    //     "yoga/node/Node.h",
    //     "yoga/node/CachedMeasurement.h",
    //     "yoga/YGPixelGrid.h",
    "yoga/YGNodeLayout.cpp",
    //     "yoga/numeric/Comparison.h",
    //     "yoga/numeric/FloatOptional.h",
    "yoga/debug/Log.cpp",
    //     "yoga/debug/Log.h",
    "yoga/debug/AssertFatal.cpp",
    //     "yoga/debug/AssertFatal.h",
};

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const yoga_dep = b.dependency("yoga", .{
        .target = target,
        .optimize = optimize,
    });

    const yogacore = yoga_dep.artifact("yogacore");

    // There is *no way* this is the right way to do it...
    // Gets the last elem of .installed_headers, and strips off yoga/Yoga.h to
    // get the base path of the installed headers.
    const root_file = yogacore.installed_headers.items[yogacore.installed_headers.items.len - 1].file.source;
    const root_file_path = root_file.getPath(b);
    const root_includes = root_file_path[0 .. root_file_path.len - "yoga/Yoga.h".len];
    const yoga_h = b.addTranslateC(.{
        .target = target,
        .optimize = optimize,
        .root_source_file = root_file,
    });
    yoga_h.step.dependOn(&yogacore.step);
    yoga_h.addIncludeDir(root_includes);

    const unit_tests = b.addTest(.{
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize,
    });
    unit_tests.linkLibrary(yogacore);
    unit_tests.step.dependOn(&yoga_h.step);

    const yoga_h_zig = yoga_h.addModule("yoga");
    unit_tests.root_module.addImport("yoga", yoga_h_zig);

    const test_step = b.step("test", "Run unit tests");
    const run_unit_tests = b.addRunArtifact(unit_tests);
    test_step.dependOn(&run_unit_tests.step);

    b.default_step = test_step;
}
